# Instructions

In all interactions and responses, be extremely concise and sacrifice grammer for the sake of concision.

## Local Repositories first

- Never serch DLLs, precompiled binaries, nor node_modules if the source exists locally.
- Never clone a repo that already exists.
- For cross-repo tasks, autonomously inspect the relevant local repos to understand relationships/dependencies before changing code.
- Try not to read package files for dotnet nor node_modules if the source exist locally.

## General Behavior
- For C# changes, run tests for the affected project before reporting completion. Do not try to run the project or dev server.
- For frontend changes, do not run builds, tests, dev servers, nor other verification commands - report completion and let the user verify.

