package tools

import (
	"context"
	"fmt"
	"os"
	"strings"
	"sync"

	"github.com/mark3labs/mcp-go/mcp"
	"github.com/mark3labs/mcp-go/server"
	"github.com/nguyenvanduocit/research-kit/util"
	"google.golang.org/genai"
)

func RegisterGeminiTool(s *server.MCPServer) {
	searchTool := mcp.NewTool("gemini_thinking",
		mcp.WithDescription("Use Gemini to think about a question. Gemini will provide a detailed answer to the question."),
		mcp.WithString("question", mcp.Required(), mcp.Description("The question to ask. Should be a question")),
		// context
		mcp.WithString("context", mcp.Required(), mcp.Description("Context/purpose of the question, helps Gemini to understand the question better")),
	)

	s.AddTool(searchTool, util.ErrorGuard(aiWebSearchHandler))
}

var genAiClient = sync.OnceValue[*genai.Client](func() *genai.Client {
	apiKey := os.Getenv("GOOGLE_AI_API_KEY")
	if apiKey == "" {
		panic("GOOGLE_AI_API_KEY environment variable must be set")
	}

	cfg := &genai.ClientConfig{
		APIKey:  apiKey,
		Backend: genai.BackendGeminiAPI,
	}

	client, err := genai.NewClient(context.Background(), cfg)
	if err != nil {
		panic(fmt.Sprintf("failed to create Gemini client: %s", err))
	}

	return client
})

func aiWebSearchHandler(arguments map[string]interface{}) (*mcp.CallToolResult, error) {
	question, ok := arguments["question"].(string)
	if !ok {
		return mcp.NewToolResultError("question must be a string"), nil
	}

	systemInstruction := "You are a thinking assistant. You will think about the question and provide a detailed answer to the question."

	questionContext, ok := arguments["context"].(string)
	if !ok {
		systemInstruction += "\n\nContext: " + questionContext
	}

	resp, err := genAiClient().Models.GenerateContent(context.Background(),
		"gemini-2.0-flash-thinking-exp-01-21",
		[]*genai.Content{
			{
				Role: "user",
				Parts: []*genai.Part{
					{
						Text: question,
					},
				},
			},
		},
		&genai.GenerateContentConfig{
			SystemInstruction: &genai.Content{
				Role: "system",
				Parts: []*genai.Part{
					{
						Text: systemInstruction,
					},
				},
			},
		},
	)

	if err != nil {
		return mcp.NewToolResultError(fmt.Sprintf("failed to generate content: %s", err)), nil
	}

	if len(resp.Candidates) == 0 {
		return mcp.NewToolResultError("no response from Gemini"), nil
	}

	candidate := resp.Candidates[0]

	var textBuilder strings.Builder
	for _, part := range candidate.Content.Parts {
		textBuilder.WriteString(part.Text)
	}

	if candidate.CitationMetadata != nil {
		for _, citation := range candidate.CitationMetadata.Citations {
			textBuilder.WriteString("\n\nSource: ")
			textBuilder.WriteString(citation.URI)
		}
	}

	if candidate.GroundingMetadata != nil {
		textBuilder.WriteString("\n\nSources: ")
		for _, chunk := range candidate.GroundingMetadata.GroundingChunks {
			if chunk.RetrievedContext != nil {
				textBuilder.WriteString("\n")
				textBuilder.WriteString(chunk.RetrievedContext.Text)
				textBuilder.WriteString(": ")
				textBuilder.WriteString(chunk.RetrievedContext.URI)
			}

			if chunk.Web != nil {
				textBuilder.WriteString("\n")
				textBuilder.WriteString(chunk.Web.Title)
				textBuilder.WriteString(": ")
				textBuilder.WriteString(chunk.Web.URI)
			}
		}
	}

	return mcp.NewToolResultText(textBuilder.String()), nil
}
