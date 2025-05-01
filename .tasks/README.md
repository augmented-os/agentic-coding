# YAML Task Board

We manage work as **self-describing YAML files** that Cursor (and humans) can read, edit and move across lifecycle folders.

.tasks/
├── 0-draft/      # brainstorming & backlog
├── 1-now/         # WIP – high-focus items
├── 2-next/        # queued for the sprint
├── 3-later/       # icebox / parking lot
├── 9-done/        # completed, locked
└── .templates/    # schema + starter template

## Why YAML?

* **Explicit context** – each task lists the code/docs/designs it touches, so the Agent can load them automatically.  
* **Deterministic** – `id`, `work_steps`, `acceptance`, `self_checklist` map 1-to-1 with what the executor will do.  
* **Git-native** – tasks travel through branches & PRs just like code.

## Schema highlights

Mandatory keys (see [`task-schema.yml`](./.templates/task-schema.yml)):

| Field | Meaning |
|-------|---------|
| `id` / `title` | Unique slug + short imperative summary |
| `work_steps[]` | Ordered, file-specific instructions |
| `acceptance`   | Automated commands **and** manual checks |
| _(optional)_ `context`, `dependencies`, `self_checklist`, priorities… |

## Creating tasks

1. Copy `.templates/task-template.yml` or ask Cursor:  
   “*Turn this idea into tasks*” → triggers `CREATE_TASK`.  
2. Save new files to `0-draft/` as `ABCD-123-slug.yml`.  
3. Once groomed, move to `now/`, `next/`, etc. (or update the `status:` field).

## Executing tasks

Opening a task and telling Cursor Chat “*execute this task*” fires the `EXECUTE_TASK` action.  
It will:

1. Load all files under `context:`  
2. Follow each `work_step` **sequentially**  
3. Run `acceptance.automated` commands, simulate `acceptance.manual`, self-check, then report.

## Index

* **Schema** – `.templates/task-schema.yml`  
* **Blank template** – `.templates/task-template.yml`  
* **Example** – `task-example.yml` (node deletion dialog)

Happy shipping! 🚀