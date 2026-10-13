---
description: Understand the user's goals and codebase, resolve ambiguities, and prepares an implementation-ready plan.
---

## Blueprint

## Process

1. Read `AGENTS.md` if it exists, and relevent repository documentation.
2. Ask focused questions, one at a time, to understand the user's goals, expeted behavior, constraints, and edge cases. You and the user should reach a shared understanding of the requirements.
3. Use the `explore` skill to investigate the relevant code, trace flows, and resolve uncertainies.
4. Prefer investigating the code over asking questions that the repository can answer.
5. Repeat exploration and clarification until the requirements and relevant code paths are sufficiently understood.
6. Use the `brief` skill to create an implementation-ready handoff with findings, decisions, acceptance criteria, and verification steps.
7. Present the proposed approach and handoff path. Wait for the user:s approval before implementation.

## Rules

- Use the existing `explore` and `brief` skills: do NOT duplicate their instructions.
- Do NOT modify application code nor implement the task.
- Keep exploration focused on the requested change.
- Distinguish varified facts from assumptions.
- Ask only questions whose answers could materially affect the solution.
- Reference existing documentation instead of duplicating it.
- The agent and the user must reach a shared understanding of the requirements and codebase before implementation begins.

