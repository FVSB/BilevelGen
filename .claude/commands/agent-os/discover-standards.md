# Discover Standards

Extract tribal knowledge from your codebase into concise, documented standards.

## Important Guidelines

- **Always use AskUserQuestion tool** when asking the user anything
- **Write concise standards** — Use minimal words. Standards must be scannable by AI agents without bloating context windows.
- **Offer suggestions** — Present options the user can confirm, choose between, or correct. Don't make them think harder than necessary.

## Process

### Step 1: Determine Focus Area

Check if the user specified an area when running this command. If they did, skip to Step 2.

If no area was specified:

1. Analyze the codebase structure (folders, file types, patterns)
2. Identify 3-5 major areas. Examples:
   - **Frontend areas:** UI components, styling/CSS, state management, forms, routing
   - **Backend areas:** API routes, database/models, authentication, background jobs
   - **Cross-cutting:** Error handling, validation, testing, naming conventions, file structure
3. Use AskUserQuestion to present the areas:

```
I've identified these areas in your codebase:

1. **API Routes** (src/api/) — Request handling, response formats
2. **Database** (src/models/, src/db/) — Models, queries, migrations
3. **React Components** (src/components/) — UI patterns, props, state
4. **Authentication** (src/auth/) — Login, sessions, permissions

Which area should we focus on for discovering standards? (Pick one, or suggest a different area)
```

Wait for user response before proceeding.

### Step 2: Analyze & Present Findings

Once an area is determined:

1. Read key files in that area (5-10 representative files)
2. Look for patterns that are:
   - **Unusual or unconventional** — Not standard framework/library patterns
   - **Opinionated** — Specific choices that could have gone differently
   - **Tribal** — Things a new developer wouldn't know without being told
   - **Consistent** — Patterns repeated across multiple files

3. Use AskUserQuestion to present findings and let user select:

```
I analyzed [area] and found these potential standards worth documenting:

1. **API Response Envelope** — All responses use { success, data, error } structure
2. **Error Codes** — Custom error codes like AUTH_001, DB_002 with specific meanings
3. **Pagination Pattern** — Cursor-based pagination with consistent param names

Which would you like to document?

Options:
- "Yes, all of them"
- "Just 1 and 3"
- "Add: [your suggestion]"
- "Skip this area"
```

Wait for user selection before proceeding.

### Step 3: Ask Why, Then Draft Each Standard

**IMPORTANT:** For each selected standard, you MUST complete this full loop before moving to the next standard:

1. **Ask 1-2 clarifying questions** about the "why" behind the pattern. Use your AskUserQuestion tool for this.
2. **Wait for user response**
3. **Draft the standard** incorporating their answer
4. **Confirm with user** before creating the file
5. **Create the file** if approved

**Do NOT batch all questions upfront.** Process one standard at a time through the full loop.

### Step 4: Create the Standard File

For each standard (after completing Step 3's Q&A):

1. Determine the appropriate folder (create if needed):
   - `api/`, `database/`, `javascript/`, `css/`, `backend/`, `testing/`, `global/`

2. Check if a related standard file already exists — append to it if so

3. Draft the content and use AskUserQuestion to confirm

4. Create or update the file in `agent-os/standards/[folder]/`
5. **Then repeat Steps 3-4 for the next selected standard**

### Step 5: Update the Index

After all standards are created, update `agent-os/standards/index.yml`.

### Step 6: Offer to Continue

Ask if the user wants to discover standards in another area.

## Output Location

All standards: `agent-os/standards/[folder]/[standard].md`
Index file: `agent-os/standards/index.yml`
