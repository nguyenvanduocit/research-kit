---
description: Create publication-ready research outputs
scripts:
  sh: scripts/bash/setup-publish.sh
---

## User Input

```text
$ARGUMENTS
```

## Outline

This command creates **publication-ready research articles** that are rich, informative, and submission-ready. Run this **after** `/research.synthesize`.

## CRITICAL: Writing Quality Requirements

**Your publication MUST be a complete, submission-ready article — NOT a summary or outline.**

### The Problem with AI-Generated Research

AI often produces:
- ❌ Skeleton outlines with placeholder text
- ❌ Excessive bullet points instead of prose
- ❌ Mechanical, repetitive sentence structures
- ❌ Surface-level summaries that waste the reader's time
- ❌ Missing evidence and citations
- ❌ Generic statements without specific insights

### What This Publication MUST Be

- ✅ **Rich narrative prose** — Write in flowing paragraphs, not bullet lists
- ✅ **Evidence-dense** — Every claim backed by footnotes with exact quotes
- ✅ **Insightful** — Provide analysis, synthesis, and original insights
- ✅ **Complete** — Ready for journal/conference submission as-is
- ✅ **Human-quality writing** — Varied sentence structure, engaging flow
- ✅ **Specific and concrete** — Numbers, examples, case studies, not vague generalizations

## Footnote Citation Format (MANDATORY)

**Every significant claim MUST have a footnote citation with:**
1. The exact quote from the source (in quotation marks)
2. The file:line reference

### Footnote Format

```markdown
The research demonstrates significant improvements in model accuracy.[^1]

[^1]: "Our experiments showed a 34.7% improvement in accuracy compared to the baseline, with statistical significance at p < 0.001" — sources/papers/smith-2024-ml-safety.md:145-147
```

### Multiple Sources for One Claim

```markdown
This finding aligns with the broader consensus in the field.[^2]

[^2]: "Transformer architectures have become the dominant paradigm" — sources/papers/vaswani-2017-attention.md:23; See also: "The shift to attention-based models represents a fundamental change" — sources/papers/brown-2020-gpt3.md:89-91
```

### Footnote Rules

1. **Minimum 15 footnotes** per major section (Introduction, Literature Review, Results, Discussion)
2. **Every data point** must have a footnote
3. **Every quoted claim** must cite the exact source line
4. **Synthesized insights** should reference multiple sources in one footnote
5. **Contradictory evidence** must cite both sides

## Writing Style Requirements

### Prose Over Bullets

**WRONG** (mechanical, shallow):
```markdown
## Key Findings

- Finding 1: Model accuracy improved
- Finding 2: Training time decreased
- Finding 3: Memory usage was reduced
```

**CORRECT** (rich, narrative):
```markdown
## Key Findings

The experimental results revealed three interconnected improvements that challenge
conventional assumptions about the accuracy-efficiency tradeoff. Most notably, the
proposed architecture achieved a 34.7% improvement in classification accuracy on the
benchmark dataset, surpassing the previous state-of-the-art by a substantial margin.[^1]
This improvement did not come at the cost of computational efficiency — contrary to
expectations, training time decreased by 23% compared to the baseline transformer
architecture.[^2]

Perhaps most surprisingly, the memory footprint during inference was reduced by nearly
half (47% reduction), suggesting that the attention mechanism's sparse activation
patterns contribute to both accuracy and efficiency simultaneously.[^3] This finding
contradicts the widely-held assumption that accuracy improvements necessarily require
increased computational resources.[^4]

[^1]: "Classification accuracy reached 94.3% on ImageNet-1K, compared to 70.1% for the ResNet-152 baseline" — sources/papers/experiment-results.md:234-236
[^2]: "Total training time: 72 hours on 8×A100, versus 94 hours for the baseline configuration" — sources/papers/experiment-results.md:245
[^3]: "Peak memory usage during inference: 2.3GB vs 4.4GB baseline" — sources/papers/experiment-results.md:251
[^4]: Smith et al. argued that "scaling laws inevitably link model performance to computational cost" — sources/papers/smith-2023-scaling.md:12-14
```

### Sentence Variety

**WRONG** (mechanical repetition):
```markdown
The study found that X. The study also found that Y. The study revealed that Z.
The results showed A. The results indicated B. The results demonstrated C.
```

**CORRECT** (natural variation):
```markdown
Initial analysis revealed X, a finding that prompted deeper investigation into Y.
While the primary results confirmed our hypothesis, an unexpected pattern emerged:
Z exhibited behavior that contradicted established theory. This anomaly, rather than
undermining the research, opened new avenues for understanding A, which in turn
shed light on the relationship between B and C.
```

### Depth Over Breadth

Each paragraph should:
- **Minimum 4-6 sentences**
- **Develop ONE idea fully** before moving to the next
- **Include specific evidence** (numbers, quotes, examples)
- **Provide analysis** — don't just state facts, explain significance
- **Connect to the broader argument**

## Content Depth Requirements

### Minimum Requirements by Section

| Section | Min Words | Min Paragraphs | Min Footnotes |
|---------|-----------|----------------|---------------|
| Abstract | 250 | 1 | 0 |
| Introduction | 800 | 5+ | 10+ |
| Literature Review | 1500 | 10+ | 25+ |
| Methodology | 1000 | 6+ | 10+ |
| Results | 1500 | 8+ | 20+ |
| Discussion | 2000 | 12+ | 25+ |
| Conclusion | 500 | 3+ | 5+ |
| **TOTAL** | **7500+** | **45+** | **95+** |

### Content Quality Checks

Before completing each section, verify:
- [ ] Every paragraph has at least one footnote citation
- [ ] No paragraph is shorter than 4 sentences
- [ ] No bullet lists (convert to prose)
- [ ] Specific numbers/data rather than vague claims
- [ ] Original analysis, not just restating sources
- [ ] Smooth transitions between paragraphs
- [ ] Each section achieves its minimum word count

## Publication Structure

### Research Report (Full Article)

Create `publications/report/article.md`:

```markdown
---
title: "[Full Descriptive Title]"
authors:
  - name: [Author Name]
    affiliation: [Institution]
date: [YYYY-MM-DD]
abstract: |
  [250+ word abstract covering: context, objective, methods, key findings, conclusions]
keywords: [keyword1, keyword2, keyword3, keyword4, keyword5]
---

# [Title]

## Abstract

[Write a dense, informative abstract of 250-350 words. This is NOT a summary —
it should provide enough detail that a reader gains substantive knowledge just
from the abstract. Include: research context, specific objectives, methodology
highlights, quantitative key findings, and concrete conclusions.]

## 1. Introduction

[800+ words of flowing prose. Establish the research context, identify the gap
in current knowledge, state research questions explicitly, and preview the
contribution. Every claim about "the state of the field" must cite sources.]

### 1.1 Research Context

[Provide deep background. Not "AI is important" — but specific developments,
trends, and problems in the field that motivate this research.]

### 1.2 Problem Statement

[Clearly articulate what problem remains unsolved and why it matters.
Use evidence to demonstrate the significance of the gap.]

### 1.3 Research Questions

[State each research question precisely. Explain why each question matters
and how answering it advances knowledge.]

### 1.4 Contributions

[Explicitly state what this research contributes. Be specific — not "we
provide insights" but "we demonstrate that X achieves Y under conditions Z."]

## 2. Literature Review

[1500+ words. This is NOT a list of papers. Synthesize the literature into
a coherent narrative that builds toward your research gap. Group by themes,
show evolution of ideas, identify points of consensus and debate.]

### 2.1 Theoretical Framework

[Explain the theoretical lens through which you approach the problem.
What concepts and models underpin your research?]

### 2.2 Current State of Knowledge

[What do we know? Synthesize findings across multiple sources. Show how
different researchers have approached similar problems.]

### 2.3 Debates and Contradictions

[Where do researchers disagree? What remains contested? Present multiple
perspectives with evidence from each side.]

### 2.4 Research Gap

[What remains unknown? Build from the synthesis to show exactly what
gap your research addresses. This should flow naturally from the review.]

## 3. Methodology

[1000+ words. Provide enough detail for replication. Justify methodological
choices by reference to the literature.]

### 3.1 Research Design

[Explain and justify your overall approach.]

### 3.2 Data Collection

[Specific procedures, sources, sampling strategies, time periods.]

### 3.3 Analysis Methods

[Detailed analysis procedures with justification.]

### 3.4 Validity and Limitations

[Acknowledge methodological limitations and how you addressed them.]

## 4. Results

[1500+ words. Present findings with rich context. Every data point needs
a footnote. Explain what the data shows, don't just list it.]

### 4.1 Overview of Data

[Describe dataset characteristics, quality, any preprocessing.]

### 4.2 Findings by Research Question

[For each RQ, present findings in narrative form. Include specific
numbers, statistical tests, confidence intervals. Reference figures
and tables but explain them in prose.]

### 4.3 Unexpected Findings

[What emerged that you didn't expect? Often the most interesting results.]

## 5. Discussion

[2000+ words. This is where you add value. Don't just repeat results —
interpret, analyze, contextualize, and synthesize.]

### 5.1 Interpretation of Findings

[What do the results mean? Connect back to research questions.
Explain the significance of each major finding.]

### 5.2 Relation to Prior Work

[How do your findings relate to the literature reviewed earlier?
Do they confirm, contradict, or extend previous work?]

### 5.3 Theoretical Implications

[What do your findings suggest for theory? Do they support or
challenge existing frameworks?]

### 5.4 Practical Implications

[What are the real-world applications? Be specific about who
should do what differently based on your findings.]

### 5.5 Limitations

[Honest assessment of what your research cannot claim. This
strengthens, not weakens, your paper.]

### 5.6 Future Research

[What questions remain? What would you do differently? What
natural extensions does your work suggest?]

## 6. Conclusion

[500+ words. Synthesize the entire paper. Not a summary — a
final statement of what we now know that we didn't before.]

## References

[Complete bibliography in consistent format]

## Appendices

[Supplementary materials, detailed data tables, additional analyses]
```

## Workflow

1. **Quality Gate: AI Verification** (after script gate passes)

   Read `synthesis.md` and `definition.md`. Verify ALL of the following:

   **REQUIRED checks** (block unless user says "skip gate"):
   - [ ] 100% of research questions addressed with explicit answers in synthesis.md
   - [ ] At least 70% of research questions have High or Medium confidence
   - [ ] Every answer has at least 3 supporting evidence items
   - [ ] At least 3 emergent themes identified
   - [ ] At least 5 practical implications documented
   - [ ] Limitations section has at least 5 items

2. **Load ALL research materials**:
   - Read every file in `sources/` — you have this evidence, USE IT
   - Read `synthesis.md` for the analytical conclusions
   - Read `analysis.md` for data and statistics
   - Read `literature-review.md` for the scholarly context
   - Read `methodology.md` for methods justification

3. **Write the full article**:
   - **DO NOT outline first** — write complete prose sections
   - **Every paragraph must have footnotes** with exact quotes
   - **Meet all minimum word counts** — check before moving on
   - **Write for a knowledgeable reader** — don't oversimplify
   - **Vary your sentence structure** — read aloud to check flow

4. **Self-review for quality**:
   - Count words per section — are minimums met?
   - Count footnotes — at least 95 total?
   - Check for bullet lists — convert to prose
   - Check sentence beginnings — too many "The study..."?
   - Read conclusion — does it provide insight beyond summary?

5. **Output the complete publication**:
   - Save to `publications/report/article.md`
   - Generate `publications/metadata.yml`
   - Copy figures to `publications/report/figures/`
   - Create `publications/report/references.bib`

## Anti-Patterns to Avoid

| Anti-Pattern | Why It's Bad | What to Do Instead |
|--------------|--------------|-------------------|
| Bullet point lists | Shallow, no analysis | Write narrative paragraphs |
| "This study examines..." × 10 | Mechanical, boring | Vary sentence structures |
| Section without footnotes | Unsupported claims | Add evidence for every claim |
| 2-sentence paragraphs | Underdeveloped ideas | Expand with evidence + analysis |
| "Findings suggest..." without data | Vague, unhelpful | Include specific numbers |
| Generic recommendations | Not actionable | Be specific: who, what, when |
| Summarizing without analyzing | Wastes reader's time | Add YOUR interpretation |

## Remember

**You have rich source material.** You downloaded papers, articles, data. You analyzed it. You synthesized it. Now WRITE about it — in depth, with evidence, with insight. The reader should learn something substantial from your publication.

**This is not a draft.** This is the final, submission-ready article. It should be complete, polished, and professional.

**Specialized agents**: Use `@agent-academic-writer` for professional academic style and citation management.
