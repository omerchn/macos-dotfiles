---
name: kanban-start-pr
description: Use when asked to start a PR from a Vibe Kanban issue. Pushes changes to a branch prefixed with the Jira ticket key (extracted from the issue description), creates a draft PR, and spawns code-review and code-simplifier workspaces under the current issue.
user_invocable: true
allowed-tools: Bash(git *), Bash(gh *), mcp__vibe_kanban__list_organizations, mcp__vibe_kanban__list_projects, mcp__vibe_kanban__list_repos, mcp__vibe_kanban__list_issues, mcp__vibe_kanban__get_issue, mcp__vibe_kanban__start_workspace, mcp__vibe_kanban__update_issue, Read, Glob, Grep
---

# Kanban Start PR

Push changes, create a draft PR, and spawn review + simplifier workspaces under the current Vibe Kanban issue.

## Inputs

The user provides a **Vibe Kanban issue ID** (or you detect it from context). If not provided, ask the user.

## Steps

### 1. Get the Vibe Kanban Issue

Fetch the issue using `mcp__vibe_kanban__get_issue` with the provided issue ID.

Extract the **Jira ticket key** from the issue description. Look for a pattern matching `[A-Z]+-\d+` (e.g., `CORE-3007`, `INTEG-142`).

If no Jira ticket key is found in the description, **stop and ask the user** for the Jira ticket key.

### 2. Safety Checks

- Run `git branch --show-current` to get the current branch.
- If already on a branch that starts with the Jira ticket key, use it as-is.
- If on `main` or `master`, create a new branch (see step 3).
- If on a different feature branch that does **not** start with the Jira ticket key, rename it to match the required format (see step 3).

### 3. Create or Rename to the Jira-prefixed Branch

Generate the target branch name: `<JIRA_KEY>-<slugified-issue-title>` (lowercase, hyphens, no special chars, max 60 chars).

**If on `main`/`master`** — create and switch to the new branch:
```bash
git checkout -b <BRANCH_NAME>
```

**If on a non-matching feature branch** — rename it in place:
```bash
git branch -m <BRANCH_NAME>
   ```

### 4. Stage and Commit Changes

1. Run `git status` and `git diff` to understand changes.
2. Stage all changes:
   ```bash
   git add -A
   ```
3. Create a conventional commit (same conventions as quick-commit-push):
   - Infer type: `feat`, `fix`, `refactor`, `chore`, `test`
   - Concise, lowercase, imperative description
   - **No co-author line**
   - **Never use `--no-verify`**
   ```bash
   git commit -m "type(scope): description"
   ```

If there are no changes to commit (clean working tree), skip staging/committing and proceed to push.

### 5. Push the Branch

```bash
git push --no-verify -u origin $(git branch --show-current)
```

### 6. Create a Draft PR

Use conventional commit format for the PR title — **must match the commit message style exactly**: `type(scope): description`
- `type`: `feat`, `fix`, `refactor`, `chore`, `perf`, `test`
- `scope`: the affected package/service name(s), comma-separated if multiple (e.g., `orchid-webapp`, `app,orchid-bff`)
- `description`: lowercase, imperative, concise
- Examples: `feat(orchid-webapp): add identity flow filtering`, `fix(app): remove duplicate column from upsert`

```bash
gh pr create --draft --title "type(scope): description" --body "$(cat <<'EOF'
## Summary

<Brief description of what this PR does>

## Jira Ticket

[<JIRA_KEY>](https://orchid-security.atlassian.net/browse/<JIRA_KEY>)

## Test Plan

- [ ] TBD
EOF
)"
```

Capture the **PR URL** from the output.

### 7. Add PR URL to Issue Description

Update the Vibe Kanban issue description to include the PR URL using `mcp__vibe_kanban__update_issue`:
- `issue_id`: The current Vibe Kanban issue ID
- `description`: Append `PR <PR_URL>` to the existing description (e.g., `"PR https://github.com/Orchid-Security/core/pull/1234"`)
- Preserve the existing description content — only append the PR line.

### 8. Move Issue to "In PR Review Cycle"

Update the Vibe Kanban issue's column to **"In PR review cycle"** using `mcp__vibe_kanban__update_issue`:
- `issue_id`: The current Vibe Kanban issue ID
- `column`: `"In PR review cycle"`

### 9. Resolve Vibe Kanban Repo and Org

1. **List organizations** using `mcp__vibe_kanban__list_organizations` to get the org ID.
2. **List projects** using `mcp__vibe_kanban__list_projects` with the org ID.
3. **List repos** using `mcp__vibe_kanban__list_repos` to find the matching repo ID.
   - Detect the current GitHub repo: `gh repo view --json nameWithOwner -q .nameWithOwner`
   - Match against available Vibe Kanban repos (case-insensitive).

### 10. Spawn Two Workspaces

Start **both workspaces** under the current issue, using `origin/main` as the base branch.

**Workspace 1 — Code Review:**

Use `mcp__vibe_kanban__start_workspace`:
- `name`: `"Code Review: PR <PR_URL>"`
- `executor`: `"CLAUDE_CODE"`
- `issue_id`: The current Vibe Kanban issue ID
- `repositories`: Use the matched repo ID with branch `"main"`
- `prompt`: `/code-review:code-review <PR_URL>`

**Workspace 2 — Code Simplifier:**

Use `mcp__vibe_kanban__start_workspace`:
- `name`: `"Code Simplifier: PR <PR_URL>"`
- `executor`: `"CLAUDE_CODE"`
- `issue_id`: The current Vibe Kanban issue ID
- `repositories`: Use the matched repo ID with branch `"main"`
- `prompt`: `start code-simplifier agent in the current workspace`

### 11. Report to User

Present a summary:
- Branch name and commit hash
- Draft PR URL
- Kanban issue ID
- Both workspace names and their status
- Let the user know the review and simplifier are running

## Rules

- **Never push to `main` or `master`** — refuse if on main with no way to create a branch.
- **Never use `--no-verify`** — all commits must run hooks.
- **Never ask to confirm the commit message** — just do it.
- **No co-author line** in commits.
- **Always create a draft PR** — never a ready-for-review PR.
- **Both workspaces must use `origin/main` as the base branch.**
