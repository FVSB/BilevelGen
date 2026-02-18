# Index Standards

Rebuild and maintain the standards index file (`agent-os/standards/index.yml`).

## Process

1. Scan all `.md` files in `agent-os/standards/` and subfolders
2. Compare with existing `index.yml`
3. For new files: propose a one-sentence description via AskUserQuestion
4. For deleted files: remove stale entries automatically
5. Write updated `index.yml` (alphabetized by folder, then filename)

## Output Format

```yaml
global:
  tech-stack:
    description: Brief description here

api:
  response-format:
    description: Brief description here
```

## When to Run

- After manually creating or deleting standards files
- If `/inject-standards` suggestions seem out of sync
