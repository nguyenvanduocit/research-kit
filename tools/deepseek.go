package tools

import (
	"context"
	"fmt"
	"strings"
	"time"

	"github.com/mark3labs/mcp-go/mcp"
	"github.com/mark3labs/mcp-go/server"
	"github.com/nguyenvanduocit/research-kit/services"
	"github.com/nguyenvanduocit/research-kit/util"
	"github.com/sashabaranov/go-openai"
)

const (
	defaultTemperature = 0.7
	defaultModel      = "deepseek-reasoner"
	defaultTimeout    = 5 * time.Minute
)

// DeepseekRequest represents the structure of incoming requests
type DeepseekRequest struct {
	Question string `json:"question"`
	Context  string `json:"context"`
	Knowledge string `json:"knowledge,omitempty"`
}

func RegisterDeepseekTool(s *server.MCPServer) {
	reasoningTool := mcp.NewTool("deepseek_reasoning",
		mcp.WithDescription("advanced reasoning engine using Deepseek's AI capabilities for multi-step problem solving, critical analysis, and strategic decision support"),
		mcp.WithString("question", mcp.Required(), mcp.Description("The structured query or problem statement requiring deep analysis and reasoning")),
		mcp.WithString("context", mcp.Required(), mcp.Description("Defines the operational context and purpose of the query within the MCP ecosystem")),
		mcp.WithString("knowledge", mcp.Description("Provides relevant chat history, knowledge base entries, and structured data context for MCP-aware reasoning")),
	)

	s.AddTool(reasoningTool, util.ErrorGuard(deepseekReasoningHandler))
}

func deepseekReasoningHandler(arguments map[string]interface{}) (*mcp.CallToolResult, error) {
	// Parse and validate request
	req, err := parseDeepseekRequest(arguments)
	if err != nil {
		return mcp.NewToolResultError(fmt.Sprintf("invalid request: %v", err)), nil
	}

	// Create context with timeout
	ctx, cancel := context.WithTimeout(context.Background(), defaultTimeout)
	defer cancel()

	// Prepare messages
	messages := prepareMessages(req)

	// Make API request
	resp, err := services.DefaultDeepseekClient().CreateChatCompletion(
		ctx,
		openai.ChatCompletionRequest{
			Model:       defaultModel,
			Messages:    messages,
			Temperature: defaultTemperature,
		},
	)

	if err != nil {
		return handleDeepseekError(err)
	}

	return processDeepseekResponse(resp)
}

func parseDeepseekRequest(arguments map[string]interface{}) (*DeepseekRequest, error) {
	question, ok := arguments["question"].(string)
	if !ok || question == "" {
		return nil, fmt.Errorf("question must be a non-empty string")
	}

	context, ok := arguments["context"].(string)
	if !ok {
		context = ""
	}

	knowledge, _ := arguments["knowledge"].(string)

	return &DeepseekRequest{
		Question: question,
		Context:  context,
		Knowledge: knowledge,
	}, nil
}

func prepareMessages(req *DeepseekRequest) []openai.ChatCompletionMessage {
	systemContent := strings.Builder{}
	systemContent.WriteString("Context:\n")
	systemContent.WriteString(req.Context)

	if req.Knowledge != "" {
		systemContent.WriteString("\n\nAdditional Context:\n")
		systemContent.WriteString(req.Knowledge)
	}

	return []openai.ChatCompletionMessage{
		{
			Role:    openai.ChatMessageRoleSystem,
			Content: systemContent.String(),
		},
		{
			Role:    openai.ChatMessageRoleUser,
			Content: req.Question,
		},
	}
}

func handleDeepseekError(err error) (*mcp.CallToolResult, error) {
	if err != nil {
		return mcp.NewToolResultError(fmt.Sprintf("failed to generate content: %v", err)), nil
	}
	return nil, nil
}

func processDeepseekResponse(resp openai.ChatCompletionResponse) (*mcp.CallToolResult, error) {
	if len(resp.Choices) == 0 {
		return mcp.NewToolResultError("no response from Deepseek"), nil
	}

	return mcp.NewToolResultText(resp.Choices[0].Message.Content), nil
}
