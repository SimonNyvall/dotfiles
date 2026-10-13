---
name: code-review
description: Review the changes since a fixed point.
---

## Process
1. Pin the fixed point
    - This could be a commit SHA provided by the user, or the unstaged changes in the working directory of no SHA is povided.
2. Identify the handoff document or the requested changes to review.
    - If a handoff document is provided, use it to guide the review.
    - If no handoff document is provided, use the changes since the fixed point to guide the review.
3. Identify the standard sources
    - Try to keep the code identifiable and understandable for someone who is familier with the codebase but not the specific changes.

    Each smell reads `what it is -> how to fix it; match against the diff:`
    - Mysterious Name: a function, veriable, or type whose name doesn't reveal what it does or holds. -> rename it; if no honest name comes, the design's murky.
    - Duplicated Code: the same logic shape appears in more then one hunk or file in the change. -> extract the shared shape, call it from both.
    - Feature Envy: a method that reaches into another objects's data more then its own. -> move the method onto the data it envies.
    - Data Clumps: the same few fields or params keep travelling together (a type wanting to be born). -> bundle them into one type, pass that.
    - Primitive Obsession: a primitive or string standing in for a domain concept that deseves its own type -> give the concept its own small type.
    - Repeated Switches: the same switch/if-cases on the same type recurs across the change. ->replace with polymorphism, or one map both sites share.
    - Shutgun Surgery: one logical change forces scatterd edits across many files in the diff -> gather what changes together into one module.
    - Divergent Change: one file or module is editoed for several unrelated reasons -> split so each module changes for one reason.
    - Message Chains: long a.b().c().d() navigation the caller shouldn't depend on. -> hide the walk behind one method on the first object.
    - Middle man: a class or function that mostly just delegates onward -> cut it, call the real target directly.:
    - Refused baquest: a subclass or implementer that ignores or overrides most of what it inherits -> drop the inheritance, use composition.
    - If working with C# use the /csharp-documentation skill to review the XML documentation comments for public methods, classes, interfaces and properties.
4. Update the handoff docuemnt with the review findings, including any identified smells and suggsted fixes.

