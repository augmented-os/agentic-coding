# Vibe Tools · AI‑First Developer Workflow

> **Vibe Tools** is a set of conventions, templates and Cursor IDE playbooks that turn your codebase into a _self‑describing system_—one where both humans **and** AI agents can plan, code, test and ship with the same, deterministic workflow.

&nbsp;

| Feature | What it gives you |
|---------|------------------|
| **.cursor/rules** | Fine‑grained behaviour controls for Cursor IDE—split into _Always_, _Auto‑Attach_ and _Agent‑Requested_ rules. |
| **.cursor/guides** | Project‑specific technical standards (libraries, file structure, code taste) written in MDC. |
| **.cursor/actions** | Re‑usable playbooks (`DEBUG`, `REFACTOR`, `NEW_FEATURE`, `ANALYSE`, …) that drive step‑level agent behaviour. |
| **.cursor/tasks** | Decomposed, YAML runbooks with acceptance tests and self‑validation check‑lists. |
| **.cursor/.templates** | Scaffolds for new rules, guides, actions and tasks—used by the CLI wizard. |

The result: each agent instance receives **only the context it needs**, follows a battle‑tested action script, and self‑validates against machine‑readable criteria.

---

## Quick Start

```bash
# 1 · Install deps
pnpm install   # or npm / yarn

# 2 · Bootstrap the workspace
pnpm vibe init              # creates the .cursor/ tree
pnpm vibe new:task FEAT-101 # scaffolds a runbook
pnpm vibe run FEAT-101      # executes the task via Cursor
```

> The `vibe` CLI is a thin wrapper around Cursor’s local API plus a few lint hooks—see `scripts/` for commands.

---

## Folder Layout

```text
.cursor/
  rules/       # one file = one rule (MDC)
  guides/      # deeper technical docs (MDC)
  actions/     # step‑by‑step playbooks (MDC)
  tasks/
    0‑draft/   # un‑reviewed runbooks
    1‑now/     # ready for execution
    9‑done/    # auto‑archived
  .templates/  # scaffolds for the CLI
```

*Run `vibe doctor` to verify the structure and token budgets.*

---

## Authoring a New Feature

1. **Draft** a runbook (`vibe new:task`) in `.cursor/tasks/0‑draft/`.
2. **Review & move** to `1‑now/`.
3. **Execute** via `vibe run <ID>`  
   _Selector rule picks `NEW_FEATURE` → playbook adds scaffold files → agent codes test‑first._  
4. **Auto‑validate**; on success the task moves to `9‑done/`.

---

## Why “Vibe” Tools?

* **Think‑Left Planning** – break decisions into small YAMLs _before_ coding starts.  
* **Deterministic Context** – no hidden magic; every byte the model sees is visible in source control.  
* **Human & AI Symmetry** – the same guides and actions work for pair‑programming or full automation.

---

## Roadmap

| Status | Item |
|--------|------|
| ✅ | MVP folder structure & templates |
| 🔄 | CLI wizard (`vibe`) with lint & run commands |
| ⬜ | GitHub Action for CI‑driven task execution |
| ⬜ | Web dashboard (Augmented OS integration) |

---

## Contributing

1. Fork → feature branch → PR.  
2. Add/modify runbooks in `0‑draft/`; CI will auto‑execute them.  
3. Follow the style guide in `guides/lang‑style.mdc`.

---

## License

MIT © Augmented OS
