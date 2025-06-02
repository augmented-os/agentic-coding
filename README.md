# Agentic Coding CLI 🚀
_A CLI tool to set up Cursor rules for AI-augmented engineering workflows_

---

## Overview

This CLI tool helps you quickly set up a comprehensive set of Cursor rules for agentic coding. Instead of manually creating rules files, simply run one command to copy a battle-tested collection of rules, actions, guides, and tools into your project.

The rules work as part of a complete agentic coding system:
- **Rules** (installed by this CLI) teach the AI *how* to build software
- **Tasks** (YAML files) tell the AI *what* to build next
- **Code** (your project) gets created and modified through this workflow

This creates a virtuous loop: Ideas become **Tasks** → Tasks invoke **Rules** → Rules change **Code** → passing code closes Tasks.

## Installation

```bash
npm install -g agentic-coding
```

Or clone and link locally:
```bash
git clone <your-repo>
cd agentic-coding
npm link
```

## Usage

Navigate to any project directory and run:

```bash
agentic-coding setup
```

This will copy all rules to `.cursor/rules/` in your current directory, creating:

```
your-project/
└── .cursor/
    └── rules/
        ├── actions/     # Step-by-step playbooks
        ├── behaviours/  # Always-on guardrails  
        ├── guides/      # Deep-dive reference docs
        └── tools/       # External CLI/API cheat-sheets
```

## What's Included

### 📋 Actions
Step-by-step playbooks that turn chat commands into deterministic procedures:
- Task execution workflows
- Debugging procedures  
- Code review checklists

### 🛡️ Behaviours
Always-on guardrails that keep AI output consistent:
- Code style and naming conventions
- Tone and communication guidelines
- Security best practices

### 📚 Guides  
Deep-dive reference documentation:
- Library usage policies
- Architecture decisions
- Security guidelines

### 🔧 Tools
Cheat-sheets for external CLIs and APIs:
- Common command patterns
- Configuration templates
- Integration guides

## Rule System Architecture

The rules are designed to work with Cursor's context system:

- **Agent-Requested**: AI decides when to include based on relevance
- **Always**: Universal guidance that applies to every interaction
- **Auto-Attached**: Path-specific rules that load automatically

## YAML Task Board – Work Items That Explain Themselves

The rules work best when paired with a structured task system. A task is _both_ a ticket and an executable spec:

```yaml
id: FEAT-102           # Immutable slug
context:               # ← Cursor loads these first (critical!)
  code:
    - src/features/workflowDesigner/…
  docs:
    - .cursor/guides/ui/confirmations.mdc
work_steps:            # Ordered, file-level instructions
  - step_id: 1
    targets:
      - src/…
    instructions: Create DeleteConfirmationDialog…
acceptance:            # Proof that we're done
  automated:
    - command: "npm run test --silent"
      description: All unit tests green
  manual:
    - description: Dialog matches design in Figma link
self_checklist:        # "Did I …?" reminders
  - "No direct DOM manipulation"
```

Because the schema is explicit, Cursor can:

1. **Load context before editing** (no blind changes)
2. **Execute `work_steps` sequentially** via `edit_file`, `run_terminal_cmd`, etc.
3. **Prove success** by running the same commands you would script in CI

### Task Lifecycle

Organize tasks in your project using a simple folder structure:

```
.tasks/
├── 0-draft/     # Ideas being refined
├── now/         # Current sprint work
├── next/        # Prioritized backlog
├── later/       # Future considerations
└── done/        # Completed tasks
```

Or simply update the `status:` field in each YAML file.

### A Day in the Life ☀️

1. **Idea appears** in chat: "We should support dark mode"
2. Dev runs `/Generate Task` → **`CREATE_TASK`** interviews them and emits `THEM-201-dark-mode.yml` into `0-draft/`
3. Team refines acceptance criteria; file moves to `next/`
4. Sprint starts. Agent (or dev) opens task and says "execute" → **`EXECUTE_TASK`** loads context, edits code, runs tests, ticks checklist
5. All checks pass, PR auto-opens with the diff; task file lands in `done/`
6. Any new knowledge becomes a **Guide** so the next dev never repeats the research

Ideas become **Tasks** → Tasks invoke **Rules** → Rules change **Code** → passing code closes Tasks – a virtuous loop.

## Development

To modify or extend the rules:

1. Edit files in the `rules/` directory
2. Test with `agentic-coding setup` in a test project
3. Commit changes to version control

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add or modify rules in the appropriate category
4. Test the CLI tool
5. Submit a pull request

---

> **Philosophy**: Process should accelerate engineers, not handcuff them. These rules turn tacit knowledge into executable guidance, letting humans and AI collaborate more effectively.
