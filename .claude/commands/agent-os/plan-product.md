# Plan Product

Establish foundational product documentation through an interactive conversation. Creates mission, roadmap, and tech stack files in `agent-os/product/`.

## Process

### Step 1: Check for Existing Product Docs

Check if `agent-os/product/` exists with `mission.md`, `roadmap.md`, `tech-stack.md`. If found, ask whether to update or replace.

### Step 2: Gather Product Vision (mission.md)

Use AskUserQuestion to ask:
- What problem does this product solve?
- Who is this product for?
- What makes your solution unique?

### Step 3: Gather Roadmap (roadmap.md)

Use AskUserQuestion to ask:
- What are the must-have features for launch (MVP)?
- What features are planned for after launch?

### Step 4: Establish Tech Stack (tech-stack.md)

Check if `agent-os/standards/global/tech-stack.md` exists. If so, confirm whether this project uses the same stack. Otherwise ask for tech stack details.

### Step 5: Generate Files

Create `agent-os/product/` with:
- `mission.md` — Problem, target users, solution
- `roadmap.md` — Phase 1 MVP, Phase 2 post-launch
- `tech-stack.md` — Technologies organized by layer

### Step 6: Confirm Completion

Report files created and remind user they can edit directly or re-run this command.
