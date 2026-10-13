---
name brief
description: Move a plan into a repository markdown document.
slash: true
metadata:
    opencode/autoinvoke: false
---

## Brief

Create a concise Markdown file so a fresh agent can continue the work without repeating discovery.

Save to the repo root at `<repo-root>/docs/tasks/<work-name>.md`

## Goals

- Summarize the relevant conversation, goal, requirements, decisions, and current state.
- Include relevant codebase findings, file paths, constraints, and unresolved questions.
- Outline concrete next steps and verification criteria when applicable.
- Do NOT duplicate existing content in other artifacts (specs, plans, ADRs, issues, commits, diffs). Reference them by path or URL instead.
- Redact secrets, credentials, and unnecessary personal information.
- If arguments are provided, treat them as a description of what the next session will focus on and tailor the doc accordingly.
- Do not implment the task.

Keep the document concise, factual, and actionable. Distinguish confirmed facts from assumptions. Omit sections that are not relevant.

Finish by stating the path of the created document.
