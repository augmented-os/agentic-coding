# Cursor Rules

Our `.cursor/` folder encodes **persistent AI guidance** in four flavours:

| Type | Purpose | Folder |
|------|---------|--------|
| **Actions**    | Step-by-step playbooks that the Agent can invoke (`ANALYSE`, `EXECUTE_TASK`, …) | `rules/actions/` |
| **Behaviours** | Always-on conventions (coding style, response tone, action selector) | `rules/behaviours/` |
| **Guides**     | In-depth standards, technical guides and policies | `rules/guides/` |
| **Tools**      | Documentation for external CLIs / APIs the Agent may run | `rules/tools/` |

Templates for each live in `.cursor/.templates/`.

## Rule file anatomy

Every rule is a single **MDC file**:

```mdc
---
description: One-line summary       # used for search & selection
globs:                              # optional path patterns that auto-attach
alwaysApply: false                  # true = "Always" rule, false = "Agent-Requested"
---
# Markdown body with instructions, lists, code blocks, @file references…

Cursor recognises four application modes (Always, Auto Attached, Agent Requested, Manual).
Setting alwaysApply: true turns a file into an Always rule; adding globs: turns it into Auto Attached; otherwise it is Agent-Requested (our default).  ￼

Index

<details><summary>Actions (6)</summary>


	•	ANALYSE.mdc – architecture + tech-debt scanner
	•	CREATE_RULE.mdc – wizard for writing new rules
	•	CREATE_TASK.mdc – turns loose ideas into YAML tasks
	•	DEBUG.mdc – red/green TDD repair loop
	•	EXECUTE_TASK.mdc – generic task executor
	•	REFACTOR.mdc – safe incremental refactor plan

</details>


<details><summary>Behaviours (3)</summary>


	•	action-selection.mdc – chooses which action to trigger
	•	code-conventions.mdc – folder & naming standards
	•	response-style.mdc – tone: concise, professional, best-practice

</details>


<details><summary>Guides (1)</summary>


	•	guide-example.mdc – sample structure

</details>


<details><summary>Tools (1)</summary>


	•	tool-example.mdc – Supabase CLI cheatsheet

</details>


Creating a new rule
	1.	Copy the right template from .cursor/.templates/.
	2.	Fill in the front-matter (name, description, etc.).
	3.	Write clear, focused content (≤ 500 lines is a good target).
	4.	Commit – Cursor will pick it up immediately.

See actions/CREATE_RULE.mdc for detailed guidance.
