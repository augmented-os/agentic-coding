# Task Creation Prompt Template

Use this prompt template to create a new task definition following the established template structure. This prompt will help guide you through creating a well-structured task with clear steps, context, and verification methods.

## Instructions



 1. Start by copying the task template as a starting point, if the user hasn’t given you a blank file:

    ```bash
    cp .tasks/.templates/task-template.md .tasks/1-now/[task-name].md
    ```

    Note: Use the "1-now" directory by default unless another directory is specifically required for the task.
 2. Make sure to read the following files for appropriate context:
    * `.tasks/.templates/task-template.md` - The base template structure
    * Any existing tasks similar to the one you're creating (especially in `.tasks/5-done/`)
    * Relevant documentation for the component/feature the task involves
 3. When filling out each section, ensure:
    * Each step includes specific files to read for context
    * Each step lists files to create with exact paths
    * Templates to use for each file are clearly specified
    * Verification methods are included for each step
 4. For the **Metadata** section:
    * Generate a unique ID following existing patterns (e.g., TASK-DOC-XX-NNN for documentation tasks)
    * Estimate effort based on similar completed tasks
    * Set creation date to today
    * Set appropriate priority and status
 5. For **Description** and **Context**:
    * Be specific about what is being changed/created and why
    * Include component names, file paths, and relevant architectural context
    * Mention the impact of this task on the overall system
 6. For **Dependencies**:
    * List all tasks that must be completed first
    * Include links to resources needed (documentation, templates, etc.)
 7. For **Acceptance Criteria**:
    * Include specific, measurable outcomes
    * Address both content creation and quality validation
    * Include cross-referencing and consistency checks
 8. For **Implementation Steps**:
    * Break down the task into logical steps (typically 5-8 steps)
    * For each step include:
      * What files to read for context (with full paths)
      * What files to create (with full paths)
      * What templates to use (with full paths)
      * What shell commands to run (if applicable)
      * What verification steps to perform
 9. Include at least one verification step that has specific checks to ensure:
    * All required files have been created
    * Content follows expected patterns
    * Links between documents work correctly
    * No inconsistencies exist between documents
10. In the **Resources** section:
    * Link to all templates mentioned in the implementation steps
    * Link to documentation standards
    * Link to existing examples that should be referenced
11. In the **Notes** section:
    * Include any edge cases or considerations
    * Mention components that should be cross-referenced
    * Add tips for successfully completing the task

## Example Implementation Steps Structure

```markdown
## Implementation Steps

1. **Review and Plan**
   - [ ] Read [file1], [file2] to understand the current implementation
   - [ ] Read [template files] to understand the structure to create
   - [ ] Create a mapping plan for how content will be organized
   - [ ] Verify understanding by [specific verification method]

2. **Set Up Structure**
   - [ ] Run specific commands to create directory structure
   ```bash
   mkdir -p [directory structure]
```

- [ ] Copy template files to appropriate locations:

```bash
cp [template-path] [destination-path]
```

- [ ] Verify structure matches requirements by \[specific verification method\]


3\. **Create Content**

- [ ] Create \[file1\] based on \[template1\] containing \[specific content\]
- [ ] Create \[file2\] based on \[template2\] containing \[specific content\]
- [ ] Ensure all created files adhere to \[specific standard\]
- [ ] Verify content by \[specific verification method\]


4. **Perform Verification**
   - [ ] Run validation checks:
     - [ ] Verify all required files exist: `find [directory] -type f | sort`
     - [ ] Verify all links work correctly
     - [ ] Ensure all templates have been correctly applied
     - [ ] Check for content consistency across files
   - [ ] Document any issues found during verification

```

## Verification Checklist

Before finalizing your task, verify it includes:

- [ ] Clear, specific task title
- [ ] Complete metadata with ID, type, effort, date, priority, and status
- [ ] Concise description of the task's purpose
- [ ] Detailed context explaining why the task matters
- [ ] All dependencies listed with links
- [ ] Specific, measurable acceptance criteria
- [ ] Detailed implementation steps with:
  - [ ] Files to read for context
  - [ ] Files to create with paths
  - [ ] Templates to use with paths
  - [ ] Commands to run
  - [ ] Verification methods
- [ ] At least one dedicated verification step
- [ ] Comprehensive resources section with links
- [ ] Notes with helpful tips and considerations
```


