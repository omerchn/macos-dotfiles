---
name: kanban-start-pr-review
description: Use when asked to review a PR, start a PR review, or kick off a code review for a pull request. Fetches PR details, resolves Jira ticket from branch name, creates a Vibe Kanban issue and workspace to run the review in.
user_invocable: true
allowed-tools: Bash(gh *), Bash(git *), mcp__claude_ai_Atlassian__getJiraIssue, mcp__claude_ai_Atlassian__searchJiraIssuesUsingJql, mcp__claude_ai_Atlassian__getAccessibleAtlassianResources, mcp__vibe_kanban__create_issue, mcp__vibe_kanban__start_workspace, mcp__vibe_kanban__list_repos, mcp__vibe_kanban__list_projects, mcp__vibe_kanban__list_organizations, Read, Glob, Grep
---

# Assisted PR Review

Gather PR context, resolve the Jira ticket, create a Vibe Kanban issue, and start a workspace that will perform the full review.

## Steps

### 1. Get PR Details

The user provides a PR number or URL. Extract the PR number and determine the GitHub repo (`OWNER/REPO`).

- If the user provides a **full GitHub URL**, extract `OWNER/REPO` from it.
- If the user provides **just a PR number**, detect the current repo:
  ```bash
  gh repo view --json nameWithOwner -q .nameWithOwner
  ```

Fetch PR details:
```bash
gh pr view <PR_NUMBER> --repo <GITHUB_REPO> --json title,author,headRefName,baseRefName,body,files
```

Extract the **title**, **author login**, **head branch**, **base branch**, **body/description**, and **list of changed files** (with additions/deletions per file).

### 2. Resolve Jira Ticket from Branch Name

Extract the Jira ticket key from the branch name prefix. The pattern is typically `<PROJECT>-<NUMBER>` at the start of the branch name (e.g., `CORE-1234-add-feature` → ticket is `CORE-1234`).

Use the regex pattern: first match of `[A-Z]+-\d+` in the branch name.

If a ticket key is found, fetch the Jira issue using `mcp__claude_ai_Atlassian__getJiraIssue` (you may need to call `mcp__claude_ai_Atlassian__getAccessibleAtlassianResources` first to get the cloud ID).

Collect the **Jira Ticket Summary**:
- Ticket key and title
- Status
- Description (first 500 chars)
- Acceptance criteria if present

If no ticket key can be extracted from the branch name, note this and move on.

### 3. Create Vibe Kanban Issue & Start Workspace

Create a Vibe Kanban issue to track this PR review, then start a workspace that will perform the entire review.

1. **List organizations** using `mcp__vibe_kanban__list_organizations` to get the org ID.
2. **List projects** using `mcp__vibe_kanban__list_projects` with the org ID.
3. **Create an issue** using `mcp__vibe_kanban__create_issue`:
   - `title`: `"PR Review: <PR_TITLE> (#<PR_NUMBER>)"`
   - `description`: Include the PR URL, author, branch, and Jira ticket key (if found). Example:
     ```
     Review PR #<NUMBER> by <AUTHOR>
     Branch: <HEAD_BRANCH> → <BASE_BRANCH>
     Repo: <OWNER/REPO>
     Jira: <TICKET_KEY or "N/A">
     ```
   - `project_id`: Use the project ID from step 2
   - `priority`: `"medium"`
4. **List repos** using `mcp__vibe_kanban__list_repos` to find the matching repo ID. Match the repo name from the GitHub `OWNER/REPO` against the available Vibe Kanban repos (case-insensitive). If no match is found, pick the closest match or use "core" as default.
5. **Start a workspace** using `mcp__vibe_kanban__start_workspace`:
   - `name`: `"PR Review #<PR_NUMBER>"`
   - `executor`: `"CLAUDE_CODE"`
   - `issue_id`: The issue ID from step 3
   - `repositories`: Use the matched repo ID with branch `"main"`
   - `prompt`: Build the prompt by filling in all `<PLACEHOLDER>` values below with the actual data gathered in steps 1-2. The prompt must be the **entire text below** (from `--- BEGIN PROMPT ---` to `--- END PROMPT ---`), with placeholders replaced:

--- BEGIN PROMPT ---

# PR Review: <PR_TITLE> (#<PR_NUMBER>)

## Context

- **Repo:** <OWNER/REPO>
- **PR:** #<PR_NUMBER>
- **Author:** <AUTHOR>
- **Branch:** <HEAD_BRANCH> → <BASE_BRANCH>
- **PR Description:** <PR_BODY>
- **Jira Ticket:** <JIRA_SUMMARY or "No Jira ticket found">

## Changed Files

<LIST_OF_CHANGED_FILES with additions/deletions per file>

## Instructions

You are reviewing PR #<PR_NUMBER> in <OWNER/REPO>. Perform a thorough code review following the steps below.

### Step 1: Changed Files Overview

List all changed files grouped by category. Determine the order for drill-down:

1. **Configuration files** — `*.json`, `*.yaml`, `*.yml`, `*.toml`, `*.env*`, `Dockerfile*`, `*.config.*`, `tsconfig*`, `nx.json`, `project.json`, `package.json`, `helm/**`, etc.
2. **Contracts / Types / DTOs** — files containing types, interfaces, contracts, DTOs, schemas, Zod definitions, `*.dto.ts`, `*.contract.ts`, `*.types.ts`, `*.schema.ts`, etc.
3. **Database / Migrations** — Prisma schemas, migrations, entity files
4. **Logic / Services / Controllers** — `*.service.ts`, `*.controller.ts`, `*.resolver.ts`, `*.handler.ts`, business logic files
5. **Tests** — `*.spec.ts`, `*.test.ts`, `*.e2e-spec.ts`
6. **Other** — everything else

Present a summary table showing each file, its category, and lines added/removed.

### Step 2: File-by-File Drill-Down

Go through each changed file **in the category order above**. For each file:

1. Show the **full diff** of the file:
   ```bash
   gh pr diff <PR_NUMBER> --repo <OWNER/REPO> -- <FILE_PATH>
   ```
   If the above doesn't support per-file filtering, get the full diff and extract the relevant file's hunk:
   ```bash
   gh pr diff <PR_NUMBER> --repo <OWNER/REPO>
   ```

2. Provide **analysis** of the changes:
   - What changed and why (infer from context, PR description, and Jira ticket)
   - Any concerns about correctness, edge cases, or architectural fit
   - How this file's changes relate to other changed files in the PR

Present each file with a clear header showing the file path and category.

### Step 3: Suggested Review Comments

After completing the file-by-file analysis, identify potential issues. Specifically, look for:

- Bugs and correctness issues
- Architectural concerns
- Missing edge cases
- Contract/type mismatches across changed files
- CLAUDE.md compliance issues

**CRITICAL RULES for suggested comments:**
- **NEVER post or leave any comments on the PR** — only present suggestions to the user
- **Every suggested comment MUST be phrased as a question** — since these are comments the user (who didn't write them) would leave, they should be inquisitive rather than declarative
- For example, instead of "This should handle the null case", write "Should this also handle the null case? What happens if `value` is undefined here?"
- Instead of "Missing error handling", write "What happens if this call fails? Should we add error handling here?"

Present suggested comments in this format:

## Suggested Review Comments

### Comment 1 — [Severity: Critical/Important/Minor]
**File:** `path/to/file.ts` L42-45
**Question:** Could this lead to a race condition if two requests arrive simultaneously? What ensures mutual exclusion here?

### Comment 2 — [Severity: Critical/Important/Minor]
**File:** `path/to/other-file.ts` L18
**Question:** Should this new field also be added to the DTO validation schema? It seems like the contract and the handler expect different shapes — is that intentional?

After presenting all suggestions, ask the user: **"Would you like me to refine any of these comments, or are there any you'd like to drop?"**

Do NOT post anything to GitHub. This is purely advisory.

--- END PROMPT ---

Present a summary to the user:
- Kanban issue title and ID
- Workspace name and status
- Let them know the review is running in the workspace
