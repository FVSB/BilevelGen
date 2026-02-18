# Inject Standards

Inject relevant standards into the current context, formatted appropriately for the situation.

## Usage

```
/inject-standards                    # Auto-suggest mode
/inject-standards global             # All standards in global/
/inject-standards global/tech-stack  # Single file
```

## Process

### Step 1: Detect Context Scenario

Determine which scenario we're in:
1. **Conversation** — Regular chat, implementing code
2. **Creating a Skill** — Building a `.claude/skills/` file
3. **Shaping/Planning** — In plan mode

If unclear, use AskUserQuestion to confirm.

### Step 2: Read the Index

Read `agent-os/standards/index.yml` to get available standards and descriptions.

### Step 3: Analyze Work Context

Look at the current conversation to understand what the user is working on.

### Step 4: Match and Suggest

Match index descriptions against the context. Use AskUserQuestion to present suggestions (typically 2-5 standards).

### Step 5: Inject Based on Scenario

**Conversation:** Read standards fully into chat context.

**Creating a Skill:** Output file references (`@agent-os/standards/...`) or full content based on user preference.

**Shaping/Planning:** Same as skill, based on user preference.

## Output Location

Standards: `agent-os/standards/[folder]/[standard].md`
Index: `agent-os/standards/index.yml`
