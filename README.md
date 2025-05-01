# Augmented‑Engineering 🚀  
_Stop vibe coding, start AI augmented engineering_

---

## 1 Why this repo exists – the problem we’re solving

Large‑language models are brilliant sprinters but terrible marathoners: they forget everything between completions.  
Cursor’s **Project Rules** give them a durable memory, **but only if _we_ control what goes in**.  
Cursor’s own implicit context algorithm is powerful **yet still a moving target** – relevance scoring changes weekly and can miss critical files.  
By version‑controlling every rule and reference _inside the repo_ we ensure that humans **and** AI share a single, dependable source of truth.

---

## 2 Architecture in one picture

```
repo/
├── .cursor/          # _How_ we build  → AI guidance (rules, templates)
├── .tasks/           # _What_ to build → Work items (YAML)
└── src/…             # The product     → Code, tests, assets
```

* **Rules** teach the Agent *how* we build software.  
* **Tasks** tell the Agent (and us) *what* to build next.  
Ideas become **Tasks** ➜ Tasks invoke **Rules** ➜ Rules change **Code** ➜ passing code closes Tasks – a virtuous loop.

---

## 3 Cursor Rules – opinionated but flexible

| Kind | Role in our system | Why it matters |
|------|--------------------|----------------|
| **Actions**    | Step‑by‑step playbooks (`EXECUTE_TASK`, `DEBUG`, …) | Turn chat commands into deterministic procedures |
| **Behaviours** | Always‑on guard‑rails (style, naming, tone)        | Keep output consistent without nagging            |
| **Guides**     | Deep‑dive reference docs (library policy, security) | Centralise decisions so we never rediscover them  |
| **Tools**      | Cheat‑sheets for external CLIs / APIs              | Prevent “rm ‑rf prod” moments                     |

Most files are **Agent‑Requested** – the Agent decides when to include them based on `description:` for leaner prompts.  
We graduate to **Always** or **Auto‑Attached** only when guidance is universal or path‑specific.

Templates live in `.cursor/.templates/`, so adding a rule is copy‑paste‑commit.

---

## 4 YAML Task Board – work items that explain themselves

A task is _both_ a ticket and an executable spec:

```yaml
id: FEAT-102           # Immutable slug
context:               # <– Cursor loads these first (critical!)
  code:
    - src/features/workflowDesigner/…
  docs:
    - .cursor/guides/ui/confirmations.mdc
work_steps:            # Ordered, file‑level instructions
  - step_id: 1
    targets:
      - src/…
    instructions: Create DeleteConfirmationDialog…
acceptance:            # Proof that we’re done
  automated:
    - command: "npm run test --silent"
      description: All unit tests green
  manual:
    - description: Dialog matches design in Figma link
self_checklist:        # “Did I … ?” reminders
  - "No direct DOM manipulation"
```

Because the schema is explicit, Cursor can:

1. **Load context before editing** (no blind changes).  
2. **Execute `work_steps` sequentially** via `edit_file`, `run_terminal_cmd`, etc.  
3. **Prove success** by running the same commands we would script in CI.

Lifecycle is pure Git: move the file between `0‑draft/`, `now/`, `next/`, `later/`, `done/` or just update `status:`.

---

## 5 A day in the life ☀️

1. **Idea appears** in chat: “We should support dark mode.”  
2. Dev runs `/Generate Task` → **`CREATE_TASK`** interviews them and emits `THEM‑201‑dark‑mode.yml` into `0‑draft/`.  
3. Team refines acceptance criteria; file moves to `next/`.  
4. Sprint starts. Agent (or dev) opens task and says “execute” → **`EXECUTE_TASK`** loads context, edits code, runs tests, ticks checklist.  
5. All checks pass, PR auto‑opens with the diff; task file lands in `done/`.  
6. Any new knowledge becomes a **Guide** so the next dev never repeats the research.

---

## 6 Extending the system

* **Add a rule** – copy a template, fill front‑matter, commit ✔️  
* **Add a task** – copy `.templates/task-template.yml` or let `CREATE_TASK` do it ✔️  
* **Tune behaviours** – tweak or add always‑on rules; the scaffolding won’t fight you ✔️  

---

## 7 Where to go next

* **Rule details & index** → [`./.cursor/README.md`](./.cursor/README.md)  
* **Task schema & workflow** → [`./.tasks/README.md`](./.tasks/README.md)  
* **Official docs** – Cursor > Context > [Rules](https://docs.cursor.com/context/rules)  
* **Try it live** – open `task-example.yml` in Cursor Chat and type “Execute this task”.

---

> Process should **accelerate** engineers, not handcuff them.  
> Turning tacit know‑how into editable, executable files lets humans and AI play from the same sheet of music – freeing everyone to focus on the truly novel problems.
