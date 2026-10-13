---
name retro
description: Analyze a failed or unsatisfactory task to identify what the agent missed and how to prevent it next time.
slash: true
metadata:
    opencode/autoinvoke: false
---

# Retro

Identify why the task did not go as intended. Focus on improving the agent's inputs, reasoning, and access to information — not just fixing the final code.

## Steps

1. Review the task prompt, relevant session history, tool calls, code changes, errors, and available external information.
2. Identify the root cause(s). Focus on:
    - Prompt: Were requirements, constraints, priorities, or the intended outcome unclear or missing?
    - Code and reasoning: Did the agent make incorrect assumptions, miss dependencies, misunderstand existing behavior, or fail to verify its solution?
    - External information: Did the agent miss relevant documentation, APIs, examples, logs, repository context, or other information needed to succeed?
3. For each root cause, propose the smallest concrete improvement. Examples include clarifying a prompt, adding a targeted instruction, improving information retrieval, adding a verification step, or correcting a code-level issue.
4. Present findings in order of impact. Distinguish the root cause from symptoms, and avoid proposing changes that would not have prevented the failure.

## Output

Keep the retrospective short. Report only meaningful findings:

- What went wrong: The specific failure and its root cause.
- What was missed: The prompt, code behavior, assumption, or information that led to it.
- Improvement: The smallest actionable change to prevent recurrence.

If no systemic improvement is justified, say so. Do not invent problems or recommend new rules, tools, or documentation without evidence.
