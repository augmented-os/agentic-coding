# Cursor MCP Project Brief

## Project Overview

This project creates an integrated development workflow system that leverages Cursor's AI capabilities with a custom CLI tool (`vibe-tools`) and an MCP server. The system streamlines software project creation, planning, and execution through structured workflows with clear task boundaries and comprehensive logging.

```
┌─────────────────────────┐      MCP Protocol      ┌─────────────────────────┐
│                         │◄─────────────────────►│                         │
│                         │                       │                         │
│      Cursor IDE         │      Tool Calls       │     vibe-tools          │
│    (MCP Host/Client)    │                       │     MCP Server          │
│                         │─────────────────────►│                         │
│    ┌─────────────┐      │                       │    ┌─────────────┐      │
│    │             │      │      Results          │    │             │      │
│    │ Cursor AI   │      │◄─────────────────────│    │   Tools:    │      │
│    │  Agent      │      │                       │    │ project:*   │      │
│    │             │      │                       │    │ template:*  │      │
│    └─────────────┘      │                       │    │ git:*       │      │
│                         │                       │    └─────────────┘      │
└─────────────────────────┘                       └──────────┬──────────────┘
                                                             │
                                                             │ Executes
                                                             ▼
                                                  ┌─────────────────────────┐
                                                  │                         │
                                                  │    vibe-tools CLI       │
                                                  │                         │
                                                  │  - create               │
                                                  │  - templates            │
                                                  │  - configure            │
                                                  │                         │
                                                  └─────────────────────────┘
```

## Core Components

### CLI Application (`vibe-tools`)

The CLI tool provides the implementation layer that:

* Creates and manages project directory structures
* Handles file operations and template management
* Executes commands that mirror the software development lifecycle
* Maintains project state and configuration

### MCP Server

The MCP server acts as a bridge between Cursor and the CLI that:

* Exposes CLI functionality to the Cursor AI agent through the Model Context Protocol
* Translates MCP tool calls into CLI commands
* Creates a structured approach to task initialization and completion
* Maintains logs of all agent-initiated operations

The MCP server exposes capabilities such as:

* **Tools**: Functions that map to CLI commands (e.g., `project:create`, `template:apply`)
* **Resources**: File templates and project structures
* **Prompts**: Pre-defined templates for different project types

### Cursor IDE Integration

The system leverages Cursor's built-in AI capabilities by:

* Acting as an MCP host that connects to the vibe-tools MCP server
* Following Project Rules to control agent behavior
* Referencing Technical Guides for implementation details
* Operating within a task-based workflow for focused execution
* Using MCP to execute external operations without consuming context window space

## Workflow Architecture

The system follows a task-centered architecture where:


1. Each task is an atomic unit of work with clear boundaries
2. Tasks are initialized through the MCP server
3. The agent operates within the task context
4. All file operations are executed via the CLI through MCP tools
5. Task completion is recorded and logged

## Communication Flow


1. **User → Cursor AI Agent**: User requests project creation or other tasks
2. **Cursor AI Agent → MCP Server**: Agent calls appropriate MCP tools (e.g., `project:create`)
3. **MCP Server → CLI**: Server translates tool calls to CLI commands
4. **CLI → File System**: CLI executes commands, creating/modifying files
5. **CLI → MCP Server → Cursor AI Agent**: Results flow back to the agent
6. **Cursor AI Agent → User**: Agent communicates results to the user

## Key Workflows

### Project Initialization

* User requests project creation via Cursor
* Cursor AI agent calls appropriate MCP tools
* MCP server executes CLI commands
* CLI creates directory structure and initial files
* Agent guides user through additional configuration

### Requirements Gathering

* Agent extracts business and product requirements from user conversations
* Agent calls MCP tools to save requirements to standardized templates

### Architecture Design

* Agent proposes and iterates on architectural decisions
* Agent uses MCP tools to save architectural documentation

### Project Planning

* Agent creates structured project plan with milestones
* Agent uses MCP tools to organize planning documents

### Task Management

* Agent breaks down project into atomic tasks
* Each task includes acceptance criteria and checklist
* Agent executes tasks step-by-step using MCP to control CLI

## Benefits


1. **Direct Developer Access**: Developers can use the CLI directly without the agent
2. **AI Integration**: AI agents can access the same functionality via MCP
3. **Reduced Context Window Usage**: External operations handled by CLI
4. **Structured Workflow**: Clear task boundaries and checkpoints
5. **Complete Audit Trail**: Comprehensive logging of all operations
6. **Error Recovery**: Atomic tasks with clear state management
7. **Standardized Outputs**: Consistent template usage
8. **Separation of Concerns**: AI handles reasoning while CLI handles execution

## Implementation Approach


1. Implement the `vibe-tools` CLI with core functionality
2. Create an MCP server that wraps CLI commands as MCP tools
3. Develop standard templates for project artifacts
4. Implement logging and state management
5. Configure Cursor to connect to the MCP server
6. Define Project Rules to control agent behavior

## Next Steps


1. Define detailed CLI command specifications
2. Design MCP tool schemas based on MCP specification
3. Create initial templates for requirements and architecture documents
4. Build prototype focusing on project initialization workflow
5. Configure Cursor to connect to the MCP server
6. Gradually expand to cover the complete development lifecycle


