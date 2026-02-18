# Shape Spec

Gather context and structure planning for significant work. **Run this command while in plan mode.**

## Prerequisites

Must be in plan mode. If not, stop and tell the user to enter plan mode first.

## Process

### Step 1: Clarify What We're Building

Use AskUserQuestion: "What are we building? Describe the feature or change."

### Step 2: Gather Visuals

Ask if there are mockups, screenshots, or examples to reference.

### Step 3: Identify Reference Implementations

Ask if there is similar code in the codebase to reference.

### Step 4: Check Product Context

Read `agent-os/product/` if it exists. Confirm alignment with product goals.

### Step 5: Surface Relevant Standards

Read `agent-os/standards/index.yml`. Use AskUserQuestion to confirm which standards apply.

### Step 6: Generate Spec Folder Name

Format: `YYYY-MM-DD-HHMM-{feature-slug}/` under `agent-os/specs/`

### Step 7: Structure the Plan

Task 1 is always "Save spec documentation". Build remaining implementation tasks based on feature scope, reference implementations, and standards.

### Step 8: Complete the Plan

Fill in all implementation tasks with specific, actionable steps.

## Output Structure

```
agent-os/specs/{YYYY-MM-DD-HHMM-feature-slug}/
├── plan.md       # Full plan
├── shape.md      # Shaping decisions and context
├── standards.md  # Relevant standards content
├── references.md # Pointers to similar code
└── visuals/      # Mockups (if any)
```
