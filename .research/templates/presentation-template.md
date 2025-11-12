---
# Configure the theme
theme: default
# Use custom background
background: https://source.unsplash.com/collection/94734566/1920x1080
# Apply unocss classes to the current slide
class: text-center
# Highlighting and drawing
highlighter: shiki
# Show line numbers in code blocks
lineNumbers: false
# Persist drawings in exports
drawings:
  persist: false
# Use slide transitions
transition: slide-left
# Use title of the page in the browser tab
title: Research Presentation
# Enable Monaco editor
monaco: true
# Download as PDF or PPT
download: true
# Presentation info
info: |
  ## Research Presentation

  Academic research presentation created with Sli.dev
---

# [Research Title]

<div class="pt-12">
  <span @click="$slidev.nav.next" class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    Press Space for next slide <carbon:arrow-right class="inline"/>
  </span>
</div>

<div class="abs-br m-6 flex gap-2">
  <span class="text-sm opacity-50">Authors: [Names]</span>
</div>

<div class="abs-bl m-6 flex gap-2">
  <span class="text-sm opacity-50">Institution: [Organization] | Date: [Presentation Date]</span>
</div>

---
transition: fade-out
layout: default
---

# Agenda

<div class="grid grid-cols-2 gap-4 pt-4">

<div>

### Research Foundation
1. Background & Motivation
2. Research Questions
3. Methodology

</div>

<div>

### Findings & Impact
4. Key Findings
5. Discussion
6. Conclusions & Recommendations

</div>

</div>

<v-click>

<div class="mt-8 text-center text-sm opacity-75">
  Estimated Duration: 20 minutes + Q&A
</div>

</v-click>

---
layout: image-right
image: https://source.unsplash.com/collection/94734566/1920x1080
---

# Background

## The Problem

<v-clicks>

- **Issue 1**: [Key problem point 1]
- **Issue 2**: [Key problem point 2]
- **Issue 3**: [Key problem point 3]

</v-clicks>

<v-click>

<div class="mt-8 p-4 bg-blue-500 bg-opacity-20 rounded">
  <strong>Why This Matters</strong>: [One sentence impact statement]
</div>

</v-click>

---
layout: center
class: text-center
---

# Research Questions

<div class="text-left inline-block">

<v-clicks>

<div class="mb-6">
  <span class="text-3xl text-blue-500">1.</span>
  <span class="text-xl ml-2">[RQ1 in simple terms]</span>
</div>

<div class="mb-6">
  <span class="text-3xl text-green-500">2.</span>
  <span class="text-xl ml-2">[RQ2 in simple terms]</span>
</div>

<div class="mb-6">
  <span class="text-3xl text-yellow-500">3.</span>
  <span class="text-xl ml-2">[RQ3 in simple terms]</span>
</div>

</v-clicks>

</div>

---
layout: two-cols
---

# Methodology

How We Investigated

<v-clicks>

- **Approach**
  - [Research design]

- **Data Sources**
  - [Data sources]

- **Analysis Methods**
  - [Methods used]

- **Timeline**
  - [Study period]

</v-clicks>

::right::

<div class="flex h-full items-center">

```mermaid {theme: 'neutral', scale: 0.8}
graph TD
    A[Research Design] --> B[Data Collection]
    B --> C[Data Analysis]
    C --> D[Results Synthesis]
    D --> E[Conclusions]
```

</div>

---
layout: fact
---

# Key Findings

Three major discoveries from our research

---
layout: image-left
image: ./figures/finding1.png
---

# Finding 1

## [Finding Title]

<v-clicks>

- **What we found**
  - [Finding statement]

- **Supporting evidence**
  - [Supporting data]

- **Impact**
  - [What this means]

</v-clicks>

<v-click>

<div class="mt-4 p-3 bg-green-500 bg-opacity-20 rounded">
  <strong>Key Insight</strong>: [One-line summary]
</div>

</v-click>

---
layout: image-left
image: ./figures/finding2.png
---

# Finding 2

## [Finding Title]

<v-clicks>

- **What we found**
  - [Finding statement]

- **Supporting evidence**
  - [Supporting data]

- **Impact**
  - [What this means]

</v-clicks>

<v-click>

<div class="mt-4 p-3 bg-blue-500 bg-opacity-20 rounded">
  <strong>Key Insight</strong>: [One-line summary]
</div>

</v-click>

---
layout: image-left
image: ./figures/finding3.png
---

# Finding 3

## [Finding Title]

<v-clicks>

- **What we found**
  - [Finding statement]

- **Supporting evidence**
  - [Supporting data]

- **Impact**
  - [What this means]

</v-clicks>

<v-click>

<div class="mt-4 p-3 bg-purple-500 bg-opacity-20 rounded">
  <strong>Key Insight</strong>: [One-line summary]
</div>

</v-click>

---
layout: default
---

# Discussion

## What It All Means

<div class="grid grid-cols-3 gap-4 pt-4">

<v-click>
<div class="p-4 bg-green-500 bg-opacity-20 rounded">
  <h3 class="text-green-400 mb-2">✓ Confirms</h3>
  <p>[What we validated]</p>
</div>
</v-click>

<v-click>
<div class="p-4 bg-yellow-500 bg-opacity-20 rounded">
  <h3 class="text-yellow-400 mb-2">? Challenges</h3>
  <p>[What we questioned]</p>
</div>
</v-click>

<v-click>
<div class="p-4 bg-blue-500 bg-opacity-20 rounded">
  <h3 class="text-blue-400 mb-2">! Reveals</h3>
  <p>[What's new]</p>
</div>
</v-click>

</div>

---
layout: quote
---

# Limitations

<div class="text-xl">

Study Boundaries

</div>

<v-clicks>

- [Limitation 1]
- [Limitation 2]
- [Limitation 3]

</v-clicks>

<v-click>

<div class="mt-8 text-sm opacity-75 italic">
  These limitations [do/do not] significantly impact our conclusions
</div>

</v-click>

---
layout: statement
---

# Conclusions

<v-clicks>

<div class="text-2xl mb-6">
  <span class="text-blue-400">1.</span> **Main Conclusion**: [Primary finding]
</div>

<div class="text-2xl mb-6">
  <span class="text-green-400">2.</span> **Implication**: [What organizations should do]
</div>

<div class="text-2xl">
  <span class="text-yellow-400">3.</span> **Future**: [What comes next]
</div>

</v-clicks>

---
layout: default
---

# Recommendations

## Action Items

<v-clicks>

<div class="mb-6 p-4 bg-red-500 bg-opacity-20 rounded">
  <h3 class="text-red-400">🔥 Immediate (Now)</h3>
  <ul class="mt-2">
    <li>[Action 1]</li>
  </ul>
</div>

<div class="mb-6 p-4 bg-yellow-500 bg-opacity-20 rounded">
  <h3 class="text-yellow-400">📅 Short-term (3-6 months)</h3>
  <ul class="mt-2">
    <li>[Action 2]</li>
  </ul>
</div>

<div class="p-4 bg-blue-500 bg-opacity-20 rounded">
  <h3 class="text-blue-400">🎯 Long-term (1+ years)</h3>
  <ul class="mt-2">
    <li>[Action 3]</li>
  </ul>
</div>

</v-clicks>

---
layout: default
---

# Future Research

## Next Steps

<v-clicks>

<div class="space-y-4">

<div class="flex items-center space-x-3">
  <div class="text-3xl">🔬</div>
  <div>[Research direction 1]</div>
</div>

<div class="flex items-center space-x-3">
  <div class="text-3xl">📊</div>
  <div>[Research direction 2]</div>
</div>

<div class="flex items-center space-x-3">
  <div class="text-3xl">🌍</div>
  <div>[Research direction 3]</div>
</div>

</div>

</v-clicks>

---
layout: end
class: text-center
---

# Thank You

Questions?

<div class="pt-12">
  <span class="text-sm opacity-75">**Contact**: [Email]</span><br>
  <span class="text-sm opacity-75">**Full Report**: [Where to find it]</span><br>
  <span class="text-sm opacity-75">**Data**: [If publicly available]</span>
</div>

---
layout: section
---

# Backup Slides

Additional details for Q&A

---

# [Additional Detail Slide 1]

[Content for deeper dive on specific topics]

---

# [Additional Detail Slide 2]

[Content for deeper dive on specific topics]