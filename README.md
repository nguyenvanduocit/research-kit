# Research Kit - Model Context Protocol (MCP) Server

Research Kit is a powerful Model Context Protocol (MCP) server designed to enhance AI model capabilities by providing seamless integration with various development tools and services. It serves as a bridge between AI models (like Claude) and essential development services such as Jira, Confluence, and GitLab.

## Overview

This server implements the Model Context Protocol, allowing AI models to interact with development tools in a structured and secure way. It's particularly useful for automating development workflows, managing documentation, and handling version control operations through natural language interactions.

## Prerequisites

- Go 1.23.2 or higher
- Various API keys and tokens for the services you want to use

## Installation

### Installing via Go

1. Install the server:

```bash
go install github.com/nguyenvanduocit/research-kit@latest
```

2. Create a `.env` file with your configuration:

```env
# Required for AI services
DEEPSEEK_API_KEY=      # Your Deepseek API key for advanced reasoning capabilities
GOOGLE_AI_API_KEY=     # Your Google AI API key for Gemini services

# Optional configurations
ENABLE_TOOLS=          # Comma-separated list of tool groups to enable (empty = all enabled)
PROXY_URL=            # Optional: HTTP/HTTPS proxy URL if needed
```

3. Config your claude's config:

```json{claude_desktop_config.json}
{
  "mcpServers": {
    "research_kit": {
      "command": "research-kit",
      "args": ["-env", "/path/to/.env"],
    }
  }
}
```

## Enable Tools

There are a hidden variable `ENABLE_TOOLS` in the environment variable. It is a comma separated list of tools group to enable. If not set, all tools will be enabled. Leave it empty to enable all tools.

## Available Tools

### Group: deepseek

#### deepseek_reasoning

advanced reasoning engine using Deepseek's AI capabilities for multi-step problem solving, critical analysis, and strategic decision support

### Group: gemini

#### gemini_thinking

Use Gemini to think about a question. Gemini will provide a detailed answer to the question.

### Group: sequentialthinking

#### sequentialthinking

`A detailed tool for dynamic and reflective problem-solving through thoughts.
This tool helps analyze problems through a flexible thinking process that can adapt and evolve.
Each thought can build on, question, or revise previous insights as understanding deepens.

When to use this tool:
- Breaking down complex problems into steps
- Planning and design with room for revision
- Analysis that might need course correction
- Problems where the full scope might not be clear initially
- Problems that require a multi-step solution
- Tasks that need to maintain context over multiple steps
- Situations where irrelevant information needs to be filtered out

Key features:
- You can adjust total_thoughts up or down as you progress
- You can question or revise previous thoughts
- You can add more thoughts even after reaching what seemed like the end
- You can express uncertainty and explore alternative approaches
- Not every thought needs to build linearly - you can branch or backtrack
- Generates a solution hypothesis
- Verifies the hypothesis based on the Chain of Thought steps
- Repeats the process until satisfied
- Provides a correct answer

Parameters explained:
- thought: Your current thinking step, which can include:
* Regular analytical steps
* Revisions of previous thoughts
* Questions about previous decisions
* Realizations about needing more analysis
* Changes in approach
* Hypothesis generation
* Hypothesis verification
- next_thought_needed: True if you need more thinking, even if at what seemed like the end
- thought_number: Current number in sequence (can go beyond initial total if needed)
- total_thoughts: Current estimate of thoughts needed (can be adjusted up/down)
- is_revision: A boolean indicating if this thought revises previous thinking
- revises_thought: If is_revision is true, which thought number is being reconsidered
- branch_from_thought: If branching, which thought number is the branching point
- branch_id: Identifier for the current branch (if any)
- needs_more_thoughts: If reaching end but realizing more thoughts needed

You should:
1. Start with an initial estimate of needed thoughts, but be ready to adjust
2. Feel free to question or revise previous thoughts
3. Don't hesitate to add more thoughts if needed, even at the "end"
4. Express uncertainty when present
5. Mark thoughts that revise previous thinking or branch into new paths
6. Ignore information that is irrelevant to the current step
7. Generate a solution hypothesis when appropriate
8. Verify the hypothesis based on the Chain of Thought steps
9. Repeat the process until satisfied with the solution
10. Provide a single, ideally correct answer as the final output
11. Only set next_thought_needed to false when truly done and a satisfactory answer is reached`

