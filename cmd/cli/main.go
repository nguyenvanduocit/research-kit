package main

import (
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"os"
	"strings"

	"github.com/joho/godotenv"
	"github.com/nguyenvanduocit/research-kit/services"
	"github.com/sashabaranov/go-openai"
	"google.golang.org/genai"
)

func main() {
	if len(os.Args) < 2 {
		printUsage()
		os.Exit(1)
	}
	switch os.Args[1] {
	case "deepseek-reason":
		runDeepseekReason(os.Args[2:])
	case "gemini-reason":
		runGeminiReason(os.Args[2:])
	case "sequential-thinking":
		runSequentialThinking(os.Args[2:])
	case "help", "--help", "-h":
		printUsage()
	default:
		fmt.Fprintf(os.Stderr, "unknown command: %s\n", os.Args[1])
		os.Exit(1)
	}
}

func printUsage() {
	fmt.Fprintf(os.Stderr, `research-cli - CLI for research-kit tools

Usage:
  research-cli <command> [flags]

Commands:
  deepseek-reason       Run Deepseek reasoning engine
  gemini-reason         Run Gemini thinking
  sequential-thinking   Process a sequential thinking step

Flags (all commands):
  --env string     Path to .env file (optional)
  --output string  Output format: text (default) or json

Run 'research-cli <command> --help' for command-specific flags.
`)
}

func loadEnv(envFile string) {
	if envFile != "" {
		if err := godotenv.Load(envFile); err != nil {
			fmt.Fprintf(os.Stderr, "warning: could not load env file %s: %v\n", envFile, err)
		}
	} else {
		// load .env silently if present
		_ = godotenv.Load()
	}
}

func outputResult(format string, text string, data interface{}) {
	if format == "json" {
		enc := json.NewEncoder(os.Stdout)
		enc.SetIndent("", "  ")
		var payload interface{}
		if data != nil {
			payload = data
		} else {
			payload = map[string]string{"result": text}
		}
		if err := enc.Encode(payload); err != nil {
			fmt.Fprintf(os.Stderr, "json encode error: %v\n", err)
			os.Exit(1)
		}
	} else {
		fmt.Print(text)
		if len(text) > 0 && text[len(text)-1] != '\n' {
			fmt.Println()
		}
	}
}

// deepseek-reason

func runDeepseekReason(args []string) {
	fs := flag.NewFlagSet("deepseek-reason", flag.ExitOnError)
	question := fs.String("question", "", "The query or problem statement requiring deep analysis (required)")
	context_ := fs.String("context", "", "Operational context and purpose of the query (required)")
	knowledge := fs.String("knowledge", "", "Relevant chat history, knowledge base entries (optional)")
	model := fs.String("model", "deepseek-reasoner", "Deepseek model to use")
	envFile := fs.String("env", "", "Path to .env file")
	output := fs.String("output", "text", "Output format: text or json")
	fs.Parse(args)

	if *question == "" {
		fmt.Fprintln(os.Stderr, "error: --question is required")
		fs.Usage()
		os.Exit(1)
	}
	if *context_ == "" {
		fmt.Fprintln(os.Stderr, "error: --context is required")
		fs.Usage()
		os.Exit(1)
	}

	loadEnv(*envFile)

	systemContent := strings.Builder{}
	systemContent.WriteString("Context:\n")
	systemContent.WriteString(*context_)
	if *knowledge != "" {
		systemContent.WriteString("\n\nAdditional Context:\n")
		systemContent.WriteString(*knowledge)
	}

	messages := []openai.ChatCompletionMessage{
		{Role: openai.ChatMessageRoleSystem, Content: systemContent.String()},
		{Role: openai.ChatMessageRoleUser, Content: *question},
	}

	resp, err := services.DefaultDeepseekClient().CreateChatCompletion(
		context.Background(),
		openai.ChatCompletionRequest{
			Model:       *model,
			Messages:    messages,
			Temperature: 0.7,
		},
	)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error: failed to generate content: %v\n", err)
		os.Exit(1)
	}
	if len(resp.Choices) == 0 {
		fmt.Fprintln(os.Stderr, "error: no response from Deepseek")
		os.Exit(1)
	}

	result := resp.Choices[0].Message.Content
	outputResult(*output, result, map[string]string{"result": result})
}

// gemini-reason

func runGeminiReason(args []string) {
	fs := flag.NewFlagSet("gemini-reason", flag.ExitOnError)
	question := fs.String("question", "", "The question to ask (required)")
	context_ := fs.String("context", "", "Context/purpose of the question (optional)")
	model := fs.String("model", "gemini-2.0-flash-thinking-exp-01-21", "Gemini model to use")
	envFile := fs.String("env", "", "Path to .env file")
	output := fs.String("output", "text", "Output format: text or json")
	fs.Parse(args)

	if *question == "" {
		fmt.Fprintln(os.Stderr, "error: --question is required")
		fs.Usage()
		os.Exit(1)
	}

	loadEnv(*envFile)

	apiKey := os.Getenv("GOOGLE_AI_API_KEY")
	if apiKey == "" {
		fmt.Fprintln(os.Stderr, "error: GOOGLE_AI_API_KEY environment variable must be set")
		os.Exit(1)
	}

	ctx := context.Background()
	client, err := genai.NewClient(ctx, &genai.ClientConfig{
		APIKey:  apiKey,
		Backend: genai.BackendGeminiAPI,
	})
	if err != nil {
		fmt.Fprintf(os.Stderr, "error: failed to create Gemini client: %v\n", err)
		os.Exit(1)
	}

	systemInstruction := "You are a thinking assistant. You will think about the question and provide a detailed answer to the question."
	if *context_ != "" {
		systemInstruction += "\n\nContext: " + *context_
	}

	resp, err := client.Models.GenerateContent(ctx,
		*model,
		[]*genai.Content{
			{
				Role: "user",
				Parts: []*genai.Part{
					{Text: *question},
				},
			},
		},
		&genai.GenerateContentConfig{
			SystemInstruction: &genai.Content{
				Role: "system",
				Parts: []*genai.Part{
					{Text: systemInstruction},
				},
			},
		},
	)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error: failed to generate content: %v\n", err)
		os.Exit(1)
	}
	if len(resp.Candidates) == 0 {
		fmt.Fprintln(os.Stderr, "error: no response from Gemini")
		os.Exit(1)
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

	result := textBuilder.String()
	outputResult(*output, result, map[string]string{"result": result})
}

// sequential-thinking

type thoughtResult struct {
	ThoughtNumber        int      `json:"thoughtNumber"`
	TotalThoughts        int      `json:"totalThoughts"`
	NextThoughtNeeded    bool     `json:"nextThoughtNeeded"`
	Branches             []string `json:"branches"`
	ThoughtHistoryLength int      `json:"thoughtHistoryLength"`
}

func runSequentialThinking(args []string) {
	fs := flag.NewFlagSet("sequential-thinking", flag.ExitOnError)
	thought := fs.String("thought", "", "Current thinking step (required)")
	thoughtNumber := fs.Int("thought-number", 0, "Current thought number (required)")
	totalThoughts := fs.Int("total-thoughts", 0, "Estimated total thoughts needed (required)")
	nextThoughtNeeded := fs.Bool("next-thought-needed", false, "Whether another thought step is needed (required)")
	isRevision := fs.Bool("is-revision", false, "Whether this revises previous thinking")
	revisesThought := fs.Int("revises-thought", 0, "Which thought number is being reconsidered (0 = not set)")
	branchFromThought := fs.Int("branch-from-thought", 0, "Branching point thought number (0 = not set)")
	branchID := fs.String("branch-id", "", "Branch identifier")
	needsMoreThoughts := fs.Bool("needs-more-thoughts", false, "If more thoughts are needed")
	envFile := fs.String("env", "", "Path to .env file")
	output := fs.String("output", "text", "Output format: text or json")
	fs.Parse(args)

	if *thought == "" {
		fmt.Fprintln(os.Stderr, "error: --thought is required")
		fs.Usage()
		os.Exit(1)
	}
	if *thoughtNumber == 0 {
		fmt.Fprintln(os.Stderr, "error: --thought-number is required and must be > 0")
		fs.Usage()
		os.Exit(1)
	}
	if *totalThoughts == 0 {
		fmt.Fprintln(os.Stderr, "error: --total-thoughts is required and must be > 0")
		fs.Usage()
		os.Exit(1)
	}

	loadEnv(*envFile)

	tNum := *thoughtNumber
	tTotal := *totalThoughts
	if tNum > tTotal {
		tTotal = tNum
	}

	res := thoughtResult{
		ThoughtNumber:        tNum,
		TotalThoughts:        tTotal,
		NextThoughtNeeded:    *nextThoughtNeeded,
		Branches:             []string{},
		ThoughtHistoryLength: tNum,
	}

	// suppress unused variable warnings - these flags are accepted for compatibility
	_ = isRevision
	_ = revisesThought
	_ = branchFromThought
	_ = branchID
	_ = needsMoreThoughts

	jsonBytes, err := json.MarshalIndent(res, "", "  ")
	if err != nil {
		fmt.Fprintf(os.Stderr, "error: %v\n", err)
		os.Exit(1)
	}

	if *output == "json" {
		fmt.Println(string(jsonBytes))
	} else {
		fmt.Println(string(jsonBytes))
	}
}
