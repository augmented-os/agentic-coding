# Project Initialization Workflow

## Overview

This document outlines the process for creating a new project using the `vibe-tools` CLI. The CLI provides direct command-line functionality for developers, while also offering Model Context Protocol (MCP) integration that enables AI agents (like those in Cursor) to access the same functionality.

For details on the standard project structure and the content of the templates used during this process, please see the [Project Templates and Structure](./project-templates-and-structure.md) documentation.

## Project Creation Process 

### Direct CLI Usage

The project initialization is initiated via the `vibe-tools` command-line interface (CLI), which developers can use directly in their terminal.

#### Command Execution

```bash
vibe-tools create [project-name] [--template=standard|webapp|api|mobile]
```

*   `[project-name]`: The desired name for your project directory.
*   `--template`: (Optional) Specifies a predefined project template. Defaults to `standard` if omitted.

#### Workflow Steps (CLI Direct Usage)

1. **Initial Setup**
   * The CLI validates the project name and ensures the target location is suitable.
   * The CLI creates the base project directory structure.
   * The CLI may prompt the user for additional information via interactive prompts.

2. **Template Application**
   * The CLI applies the selected template's files and structure.
   * The CLI customizes the template content based on user inputs.

3. **Project Configuration**
   * The CLI generates necessary configuration files based on the template and user inputs.
   * The CLI creates the initial `project_rules.md` file.
   * If requested, the CLI initializes a Git repository.

4. **Documentation Setup**
   * The CLI creates an initial `README.md` with a project overview.
   * The CLI places templates for future documentation in their respective directories.

### MCP Integration for AI Agents

For AI assistants like the Cursor agent to interact with the `vibe-tools` CLI, an MCP server wraps the CLI functionality, making it accessible through the Model Context Protocol.

#### MCP Server Setup

To enable AI agents to use the `vibe-tools` CLI, you need to:

1. Create an MCP server that wraps the CLI functionality
2. Configure your AI agent (e.g., Cursor) to connect to this MCP server
3. Restart the AI agent to establish the connection

#### MCP Tools Exposed by the Server

The MCP server would expose the CLI's functionality as MCP tools:

1. **`project:create`**: Wraps the CLI's project creation functionality.
   * *Parameters*: `projectName`, `templateType` (optional)
   * *Returns*: Confirmation of creation

2. **`project:configure`**: Wraps the CLI's configuration functionality.
   * *Parameters*: `configOptions` (JSON containing configuration details)
   * *Returns*: Confirmation of configuration application

3. **`template:apply`**: Wraps the CLI's template application functionality.
   * *Parameters*: `templateName`, `destinationPath`, `templateVariables` (for customization)
   * *Returns*: Confirmation of template application

4. **`git:initialize`**: Wraps the CLI's Git initialization functionality.
   * *Parameters*: `repositoryUrl` (Optional: URL for remote repository)
   * *Returns*: Confirmation of Git initialization

#### AI Agent-User Interaction Flow via MCP

When an AI agent like Cursor uses the MCP server to access the CLI:

1. The user asks the AI agent to create a project
2. The agent calls the appropriate MCP tool (e.g., `project:create`)
3. The MCP server executes the corresponding CLI command
4. Results are returned to the agent via MCP
5. The agent communicates these results to the user

Example interaction:

```
User → Cursor Agent: "Create a web application project called MyWebApp"

Agent → MCP Server: [Calls project:create tool with parameters {projectName: "MyWebApp", templateType: "webapp"}]

MCP Server → CLI: [Executes `vibe-tools create MyWebApp --template=webapp`]

CLI: [Creates project structure and applies templates]

MCP Server → Agent: [Returns confirmation that project was created successfully]

Agent → User: "I've created a new web application project called MyWebApp using the webapp template. The project structure has been set up with the standard directories."
```

## Example CLI Usage (Direct Terminal Interaction)

This example shows how a developer might directly use the CLI:

```bash
$ vibe-tools create MyWebApp --template=webapp

Creating project 'MyWebApp' with template 'webapp'...

? Primary business objectives: Help users manage personal finances and track expenses
? Target timeline for first release: 3 months (beta)

Applying 'webapp' template...
Configuring requirements...
Initializing Git repository...

Project 'MyWebApp' created successfully.
Initial files and documentation have been set up.

Next steps:
1. Review project_rules.md and adjust as needed
2. Complete the business-requirements.md document
3. Begin defining specific product requirements
```

## Creating an MCP Server for vibe-tools

To enable AI agents to use the `vibe-tools` CLI via MCP, you'll need to create an MCP server. Here's a simplified approach:

1. **Create a new project** for your MCP server
2. **Install required dependencies** (`mcp` SDK and any CLI dependencies)
3. **Implement an MCP server** that wraps `vibe-tools` CLI commands
4. **Register tools** corresponding to CLI commands
5. **Configure your AI agent** to connect to this server

A simplified example of an MCP server implementation:

```typescript
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { execSync } from "child_process";

// Create MCP server
const server = new Server({
  name: "vibe-tools-server",
  version: "1.0.0"
}, {
  capabilities: {
    tools: {
      "project:create": {
        description: "Create a new project with specified name and template"
      },
      // ...other tools
    }
  }
});

// Handle project:create tool
server.setRequestHandler(/* tool schema */, async (request) => {
  const { projectName, templateType } = request;
  
  // Call the CLI command
  try {
    const result = execSync(
      `vibe-tools create ${projectName} ${templateType ? `--template=${templateType}` : ''}`,
      { encoding: 'utf8' }
    );
    
    return {
      success: true,
      message: result
    };
  } catch (error) {
    return {
      success: false,
      error: error.message
    };
  }
});

// Connect transport
const transport = new StdioServerTransport();
await server.connect(transport);
```

### Configuring Cursor to Use the MCP Server

To configure an AI agent like Cursor to use your MCP server, follow the agent's MCP integration documentation. This typically involves:

1. Specifying the MCP server executable path
2. Setting any required environment variables
3. Restarting the agent to establish the connection

Once configured, the AI agent will be able to execute `vibe-tools` CLI commands through the MCP server, providing a seamless experience for users interacting with the agent.


