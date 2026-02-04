---
name: research
description: Orchestrate Systematic Research Development (SRD) workflow. Use when user wants to conduct research, investigate topics, or mentions research. Auto-detects current research state and drives the workflow forward using the right commands and agents.
---

# research

SRD orchestrator that detects research state and drives it forward.

## Quick start

1. Detect current branch and research directory
2. Scan for existing artifacts to determine phase
3. Present state and suggest next step
4. Execute via the appropriate slash command

## Detect state

**Check environment:**

1. `git rev-parse --abbrev-ref HEAD 2>/dev/null` → if branch matches `###-topic-name`, research dir is `research/<branch-name>/`
2. If on `main`, check `research/` for topic directories
3. Fallback: `RESEARCH_TOPIC` env var

**Scan artifacts in research directory:**

| File | Phase complete |
|---|---|
| `definition.md` | Define |
| `methodology.md` | Methodology |
| `tasks.md` | Task breakdown |
| `execution.md` + `data/` files | Execution |
| `analysis.md` | Analysis |
| `synthesis.md` | Synthesis |
| `publications/` files | Publication |

## Phase transitions

```
NO research dir     → Ask topic, then /research.define
definition.md only  → /research.methodology
methodology.md      → /research.tasks (or /research.refine if unclear)
tasks.md            → /research.execute
execution.md + data → /research.analyze
analysis.md         → /research.synthesize
synthesis.md        → /research.publish
publications/       → Complete. Ask if revisions needed.
```

## Execution

Present detected state before acting:

```
Current research: [topic]
Phase completed: [last phase]
Next step: [action]
```

Wait for user confirmation, then invoke the slash command. After completion, suggest next phase.

**Agent delegation:**

- `@agent-literature-specialist` → methodology/execution phases (source discovery)
- `@agent-data-collector` → execution phase (data gathering)
- `@agent-analysis-expert` → analysis phase (statistical work)
- `@agent-academic-writer` → publish phase (writing)
- `@agent-research-reviewer` → phase transitions (quality validation)

## Quality gates

Every phase transition is enforced by quality gates at two layers:

1. **Shell scripts** check structural requirements (file existence, sections, content size, source counts). Failures block the setup script with clear error messages.
2. **Commands** instruct AI to verify content quality (specificity, coverage, evidence standards). AI outputs gate results and stops if REQUIRED checks fail.

Gates cannot be skipped. CRITICAL failures (missing files, missing sections) block unconditionally. REQUIRED failures block but can be overridden with `--force` flag (logged to `gate-log.md`). User can also say "skip gate" to bypass AI-level REQUIRED checks.

See each command's "Quality Gate: AI Verification" section for specific criteria per transition.

## Edge cases

**No research context**: Ask what they want to research, help articulate a question, then `/research.define <topic>`.

**Multiple topics**: List all with current phase, ask which to work on, `git checkout <branch>`.

**Specific request** (e.g., "analyze my data"): Skip auto-detection, jump to relevant command, but verify prerequisites exist.

## Command reference

| Command | Purpose | Requires |
|---|---|---|
| `/research.principles` | Set research governance | Nothing |
| `/research.define <topic>` | Create definition | Nothing |
| `/research.refine` | Clarify scope | `definition.md` |
| `/research.methodology` | Design methodology | `definition.md` |
| `/research.validate` | Validate methodology | `methodology.md` |
| `/research.tasks` | Generate tasks | `methodology.md` |
| `/research.execute` | Collect data | `methodology.md` |
| `/research.analyze` | Analyze data | `execution.md` + data |
| `/research.synthesize` | Draw conclusions | `analysis.md` |
| `/research.publish` | Create outputs | `synthesis.md` |
| `/research.quality` | Quality checklists | Varies |
