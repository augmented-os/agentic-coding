# vibe-tools

**Supercharge your AI coding experience with structured workflows and guardrails**

 ![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)
 ![License](https://img.shields.io/badge/license-MIT-green.svg)

## 🚗 vs 🚄: The Vibe Coding Problem

Using AI to write code (vibe coding) today is like using a **self-driving car without roads**:

```
🚗 Unpredictable AI         vs        🚄 vibe-tools
  
  "Just build it"                     "Follow these tracks"
      ↓                                     ↓
     🧠                               🧠 ─→ 🛣️ 🛣️ 🛣️ 🛣️ 🛣️ 🛣️ ─→ 🏗️
  ↙️  ↓  ↘️                         
 ❓  ❓  ❓                           You define the path. AI follows it.
Unpredictable results                   Predictable quality code
```

* It makes technical decisions you wouldn't choose
* It goes off in unpredictable directions
* When it crashes, you're left figuring out what went wrong
* Getting back on track means starting the journey again

**What if your AI coding assistant could run on tracks YOU design and verify in advance?**

## 🚄 vibe-tools: AI Coding on Rails

vibe-tools transforms unpredictable AI coding into a **guided journey on well-defined tracks**:

* **Front-load the thinking** - Define requirements, architecture, and specific tasks before coding
* **Pre-validate your approach** - Iterate on the plan and technical decisions when they're easiest to change
* **Create clear boundaries** - Break work into step-by-step chunks with explicit goals
* **Execute with precision** - Feed tasks one by one to the AI, preserving context and focus

### The vibe-tools Difference:


1. **You decide everything important upfront** - Business requirements, product design, architecture, and engineering decisions are made by you, not the AI
2. **The AI follows your blueprint** - No unexpected technical decisions or creative interpretations
3. **Task-by-task guidance** - The AI gets exactly the context it needs at each step, never losing track
4. **Easy recovery** - If anything goes wrong, the issue is contained to a specific, well-defined task

## 💫 Seamless Integration with Cursor

**Use vibe-tools right through your existing Cursor AI agent:**

* No need to learn new interfaces - interact with vibe-tools through familiar Cursor conversations
* Cursor's AI agent uses Model Context Protocol (MCP) to access all vibe-tools functionality
* The same structured workflows and guardrails, accessed through your favorite AI coding assistant
* Simple prompts like "Create a new project with vibe-tools" or "Create a task for implementing login"

This integration makes structured AI development accessible without changing your workflow - the Cursor agent becomes your interface to structured, predictable AI coding.

## 🏗️ How vibe-tools Works

```
  Cursor IDE                      vibe-tools                   Project Files
     │                                │                             │
     ▼                                ▼                             ▼
┌──────────┐   MCP Protocol    ┌─────────────┐    Executes    ┌──────────────┐
│ Cursor AI│◄────────────────►│ MCP Server  │───────────────►│ Requirements │
│  Agent   │   Tool Calls     │ (connects   │                │ Architecture │
└──────────┘                  │  to CLI)    │                │ Task Docs    │
                              └─────────────┘                │ Code         │
                                    │                        └──────────────┘
                                    │
                              ┌─────────────┐
                              │ vibe-tools  │
                              │     CLI     │
                              └─────────────┘
```

vibe-tools uses a straightforward but powerful architecture:


1. **Cursor Integration via MCP** - Cursor connects to vibe-tools through the Model Context Protocol
2. **MCP Server as Bridge** - Translates agent requests into CLI commands
3. **CLI as Implementation** - The core functionality that creates/manages projects and tasks
4. **Structured Templates** - Pre-defined patterns for project organization and documentation

The CLI can be used directly by developers or through the Cursor agent - giving you flexibility while maintaining consistent project structure.

## ✨ Benefits for Developers and Teams

### For Individual Developers

* **Make Decisions When They Matter** - Front-load your thinking before coding starts
* **Write Less Boilerplate** - Focus on the creative aspects while the AI handles repetitive patterns
* **Maintain Control** - Set guardrails that keep the AI working within your preferred conventions
* **Prevent Context Collapse** - By feeding tasks one by one, the AI maintains focus
* **Recover Easily** - When things go wrong, simply put the AI back on track instead of starting over

### For Teams

* **Consistent Project Structure** - Everyone works within the same organized framework
* **Documented Decisions** - Technical and product choices are clearly recorded through the structured workflow
* **Shared Knowledge Base** - Documentation is automatically structured and maintained
* **Standards Enforcement** - Code and architecture adhere to your established patterns
* **Reduced Onboarding Time** - New team members quickly understand project organization

## 🎯 Key Features

* **Project Templates** - Start new projects with best-practice structure and documentation
* **Structured Planning Process** - Move from business requirements → product specs → architecture → specific tasks
* **Guided AI Workflows** - AI follows your defined paths and procedures
* **Task-by-Task Execution** - Break work into manageable, documented units with clear boundaries
* **Context Management** - Each task provides exactly the context the AI needs at that moment
* **Direct CLI Access** - Use command-line tools directly or let AI assistants use them for you
* **Integrated Documentation** - Built-in templates for requirements, architecture, and tasks
* **Cursor Integration** - Seamless experience with Cursor AI through MCP

## 🔍 How It Works: The Step-by-Step Approach

vibe-tools enforces a structured, gradual refinement process:


1. **Define Business Requirements** - What problem are we solving and why?
2. **Create Product Requirements** - What features will solve these problems?
3. **Design Architecture** - How will we technically implement these features?
4. **Break Into Tasks** - Create explicit, atomic units of work with clear boundaries
5. **Execute Tasks One-by-One** - Feed each task individually to the AI with precise context
6. **Verify & Iterate** - Confirm each task's success before moving to the next

This approach means:

* Technical decisions are made by you before coding starts
* The AI is only deciding "how to implement this specific step," not "what should we build"
* Context is never lost because each task is contained and specific
* Problems are isolated to individual tasks, making debugging easier

## 🤔 Why "On Rails" Is Better Than "Anything Goes"

| Unconstrained AI | vibe-tools |
|----|----|
| Makes technical choices you might not agree with | You make all important decisions upfront |
| Tries to design and implement simultaneously | Separates planning from implementation |
| Works with full files that may lose context | Works with focused tasks and specific context |
| May implement features you didn't ask for | Stays within scope boundaries you define |
| Documentation often an afterthought | Documentation integrated into the workflow |
| Difficult to maintain consistency | Enforces consistent structure and patterns |
| When it fails, you start over | When it fails, reset just that specific task |

## 📚 Learn More

* [Project Workflow](./docs/project-initialization-workflow.md)
* [Templates & Structure](./docs/project-templates-and-structure.md)
* [Project Overview](./docs/overview.md)


---

*vibe-tools: Plan first, then let AI code the details, staying on the tracks you carefully designed.*