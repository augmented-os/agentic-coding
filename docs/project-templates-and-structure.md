# Project Templates and Structure

## Overview

This document details the standard directory structure created by the `vibe-tools` project initialization process and provides the specifications for the various template files included. These templates serve as starting points for essential project documentation and configuration.

For details on the workflow that generates this structure and populates these templates, please see the [Project Initialization Workflow](./project-initialization-workflow.md) documentation.

## Standard Directory Structure

When a new project is created using `vibe-tools create [project-name]`, the following directory structure is typically generated (specific templates like `webapp`, `api`, etc., might add further directories):

```
[project-name]/
  ├── requirements/                 # Business and product requirements
  │   ├── README.md
  │   ├── business-requirements-template.md
  │   └── product-requirements-template.md
  │
  ├── architecture/                 # System design and architecture documents
  │   ├── README.md
  │   ├── architecture-overview-template.md
  │   └── system-design-template.md
  │
  ├── planning/                     # Project plans, timelines, roadmaps
  │   ├── README.md
  │   ├── project-plan-template.md
  │   └── timeline-template.md
  │
  ├── tasks/                        # Individual task definitions
  │   ├── README.md
  │   └── task-template.md
  │
  ├── technical_guides/             # Guides for setup, development, operations
  │   ├── README.md
  │   └── guide-template.md
  │
  ├── project_rules.md              # Rules governing agent behavior, coding standards, etc.
  └── README.md                     # Main project README
```

Each subdirectory contains a `README.md` briefly explaining its purpose and includes relevant template files.

## Template Specifications

The following templates are provided as starting points within the generated project structure. They are typically applied and potentially customized by the MCP server during the `vibe-tools create` process based on user input.

### Project Rules (`project_rules.md`)

This file defines the operational guidelines for the project, particularly when interacting with AI agents via MCP.

```markdown
# Project Rules

## Agent Behavior
- [Define constraints and permissions for the AI agent, e.g., file access, tool usage limitations]
- [Specify preferred communication style or information density]

## Task Management
- [Define how tasks should be created (e.g., from requirements, user requests)]
- [Specify task state transitions (e.g., ToDo, In Progress, Review, Done)]
- [Outline expected content for task descriptions and acceptance criteria]

## Implementation Standards
- [Reference or define coding standards, naming conventions]
- [Specify testing requirements (unit, integration, e2e)]
- [Preferred libraries or frameworks, version constraints]

## Review Process
- [Define how completed work (code, documentation) should be reviewed]
- [Specify reviewer roles (e.g., peer review, lead review, agent review)]
- [Criteria for approving or requesting changes]
```

### Business Requirements (`requirements/business-requirements-template.md`)

Captures the high-level goals and context for the project from a business perspective.

```markdown
# Business Requirements

## Project Overview
[Brief description of the project and its purpose. What problem does it solve?]

## Business Objectives
*   [Primary measurable business goal, e.g., Increase user engagement by 15%]
*   [Secondary business goal, e.g., Reduce support tickets related to X by 10%]
*   [...]

## Stakeholders
*   [Stakeholder 1 (e.g., Product Manager)]: [Interest/Role]
*   [Stakeholder 2 (e.g., Marketing Lead)]: [Interest/Role]
*   [...]

## Success Criteria
*   [Define measurable criteria tied to objectives, e.g., Achieve 1000 active users within 6 months post-launch]
*   [KPI 2]

## Constraints
*   Budget: [e.g., Max $50,000 for Phase 1]
*   Timeline: [e.g., MVP launch by Q4 2024]
*   Resources: [e.g., Team size, specific skill availability]
*   Compliance: [e.g., GDPR, HIPAA]

## Assumptions
*   [List key assumptions, e.g., Required third-party API will be available]
*   [Assumption 2]
```

### Product Requirements (`requirements/product-requirements-template.md`)

Details the features and functionality of the product, often derived from business requirements.

```markdown
# Product Requirements

## User Stories
*   As a [User Type], I want to [Perform Action] so that [Benefit/Value].
*   As a [Registered User], I want to [Reset My Password] so that [I can log in if I forget it].
*   [...]

## Functional Requirements
1.  The system shall allow users to register for an account using email and password.
2.  The system shall encrypt user passwords at rest.
3.  [...]

## Non-Functional Requirements
*   **Performance:**
    *   Page load time for main dashboard must be under 2 seconds.
    *   API response time for core actions must be under 500ms (p95).
*   **Security:**
    *   Must pass OWASP Top 10 vulnerability checks.
    *   User authentication must use industry-standard protocols (e.g., OAuth2/OIDC).
*   **Usability:**
    *   The interface should follow [Design System Name/Link] guidelines.
    *   Key workflows should be completable by novice users without external help.
*   **Scalability:**
    *   The system should support 10,000 concurrent users.
*   [...]

## User Flow Example (e.g., Password Reset)
1.  User clicks "Forgot Password" link on login page.
2.  User enters their registered email address.
3.  System sends a password reset link to the email.
4.  User clicks the link.
5.  User is prompted to enter and confirm a new password.
6.  System updates the password and confirms success.

## Out of Scope (for this version/phase)
*   [List features explicitly not being built, e.g., Two-factor authentication]
*   [e.g., Mobile application]
```

### Architecture Overview (`architecture/architecture-overview-template.md`)

Provides a high-level view of the system's structure and technology choices.

```markdown
# Architecture Overview

## System Context
[Insert a high-level diagram (e.g., C4 Context Diagram) or description showing how the system fits into its environment, including key external dependencies and user interactions.]

## Design Principles
*   [List key principles guiding design decisions, e.g., Modularity, Scalability, Security by Design, Observability]
*   [Principle 2]

## Component Architecture
[Insert a component diagram (e.g., C4 Component Diagram) or list major components/services and their responsibilities.]
*   **Web Frontend:** [Description: e.g., React SPA handling user interface and interaction]
*   **API Gateway:** [Description: e.g., Manages external API requests, authentication, routing]
*   **Auth Service:** [Description: e.g., Handles user authentication and authorization]
*   **Core Service:** [Description: e.g., Implements primary business logic]
*   **Database:** [Description: e.g., Stores application data]
*   [...]

## Technology Stack
*   **Frontend:** [e.g., React, TypeScript, Vite, Tailwind CSS]
*   **Backend:** [e.g., Node.js, Express, TypeScript]
*   **Database:** [e.g., PostgreSQL, Redis (for caching)]
*   **Deployment:** [e.g., Docker, Kubernetes, AWS EKS]
*   **Observability:** [e.g., Prometheus, Grafana, OpenTelemetry]

## Interfaces & Communication
*   [Describe key communication patterns between components, e.g., REST APIs between frontend and gateway, gRPC between internal services, asynchronous messaging via Kafka]
*   [API Gateway <-> Auth Service (REST)]
*   [API Gateway <-> Core Service (REST)]
*   [Core Service <-> Database (SQL)]

## Security Considerations
*   Authentication & Authorization: [e.g., JWT for API requests, role-based access control]
*   Data Protection: [e.g., Encryption at rest and in transit, PII handling]
*   Infrastructure Security: [e.g., Network policies, secrets management]

## Scalability & Performance Considerations
*   [e.g., Stateless services for horizontal scaling, database indexing strategy, caching mechanisms, CDN usage]

## Deployment Strategy
*   [e.g., CI/CD pipeline using GitHub Actions, blue/green deployment, infrastructure as code (Terraform)]
```

### Task Definition (`tasks/task-template.md`)

Used to define individual units of work.

```markdown
# Task: [Concise Task Name, e.g., Implement Password Reset API Endpoint]

## Objective
[Brief description of what this task aims to achieve. Link to relevant User Story or Requirement if applicable.]

## Acceptance Criteria
*   [ ] A POST request to `/api/auth/reset-password` with a valid email triggers a password reset email.
*   [ ] The reset email contains a unique, time-limited token.
*   [ ] A POST request to `/api/auth/set-new-password` with a valid token and new password updates the user's password.
*   [ ] Invalid or expired tokens result in an appropriate error response.
*   [ ] Unit tests cover the success and error paths.
*   [ ] [...] Add other specific, verifiable criteria.

## Implementation Steps (Optional Guidance)
1.  [ ] Define API route and request/response models.
2.  [ ] Implement logic to generate and store reset token.
3.  [ ] Implement email sending functionality.
4.  [ ] Implement logic to validate token and update password.
5.  [ ] Write unit tests.
6.  [ ] [...] Add further steps if needed.

## Dependencies
*   [List any other tasks or external factors this task depends on, e.g., Task #123 (Setup Email Service)]

## Estimated Effort
[Assign a relative size, e.g., 3 Story Points]

## Notes
[Any additional context, considerations, potential challenges, or links to relevant documentation.]
```

### Technical Guide (`technical_guides/guide-template.md`)

For documenting specific technical processes, setups, or concepts related to the project.

```markdown
# Technical Guide: [Topic, e.g., Local Development Setup]

## Overview
[Briefly describe the purpose of this guide, e.g., How to set up and run the project locally for development.]

## Prerequisites
*   [Software required, e.g., Node.js v18+, Docker, pnpm]
*   [Access needed, e.g., GitHub repository access]
*   [Credentials needed, e.g., Environment variables for third-party services]

## Setup Steps
1.  **Clone Repository:** `git clone [repository-url]`
2.  **Install Dependencies:** `cd [project-name]` && `pnpm install`
3.  **Configure Environment:** Copy `.env.example` to `.env` and fill in required values (see `.env.example` for details).
4.  **Start Services:** `docker-compose up -d` (if using Docker for dependencies like database)
5.  **Run Migrations:** `pnpm run db:migrate`
6.  **Start Application:** `pnpm run dev`

## Detailed Implementation (If Applicable)
[Provide more in-depth explanations for complex steps or configurations.]

## Best Practices
*   [List relevant best practices, e.g., Keep your local branch up-to-date with `main`]
*   [e.g., Run linters/formatters before committing]
*   [...]

## Examples (If Applicable)
```bash
# Example: Running tests for a specific component
pnpm test src/components/MyComponent.test.tsx
```

## Troubleshooting

* **Problem:** `pnpm install` fails.
  * **Solution:** Ensure you are using the correct Node.js version (v18+). Try removing `node_modules` and `pnpm-lock.yaml` and running `pnpm install` again.
* **Problem:** Cannot connect to the database.
  * **Solution:** Verify Docker container is running (`docker ps`). Check `.env` file for correct database credentials and host (`localhost` or Docker service name).
* \[...\]

## References

* \[Link to relevant external documentation, e.g., React Docs\]
* \[Link to related internal documents, e.g., Architecture Overview\]
* \[...\]

``` 
```


