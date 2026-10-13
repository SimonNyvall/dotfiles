---
name explore
description: Explore a repository or repositories and return a summary of its contents.
slash: true
metadata:
    opencode/autoinvoke: false
---

## Workflow

Build a clear understanding of the requested flow before any implementation.

## Steps

1. Read `AGENTS.md` if it exists, and any specified files, directories or repositories.
2. Trace the flow through the relevant code, following dependencies as needed.
3. Identify gaps in understanding. Investigate what can be answered from code and ask the user focused questions about unresolved intent or behavior.
4. Repeat until you can explin the flow, its key components, and relevant dependecies with confidance.

**Done when** You can explin how the flow works end to end, identiy where the relevant behavior lives, and have no critical unanswered questions.

Summarize your understanding and state any ermaining assumptions.

Do NOT modify code during exploration.
