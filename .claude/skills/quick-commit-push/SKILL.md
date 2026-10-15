---
name: quick-commit-push
description: Use when asked to commit and push, ship changes, save work, or send code upstream. Stages all working tree changes, creates a conventional commit, and pushes.
---

# Quick Commit & Push

Stage all changes, create a conventional commit message, and push.

## Workflow

0. **Resolve working directory:**
   - Check the current working directory (`pwd`).
   - If you are in the top-level `work` directory (i.e. `/Users/omercohen/Desktop/work` — not inside any sub-project), you must determine **which project** needs committing based on the current conversation context (files discussed, edits made, topics covered).
   - `cd` into that project's directory before running any git commands. All subsequent steps operate inside the resolved project directory.
   - If context is ambiguous and multiple projects could apply, ask the user which project to commit.

1. **Safety check — never push to `main`:**
   - Run `git branch --show-current` to get the current branch.
   - If the branch is `main` or `master`, **stop immediately** and tell the user: *"You are on the `main` branch. Create or switch to a feature branch before committing."* Do **not** stage, commit, or push.

2. **Gather context** (run in parallel):
   - `git status` — to see what changed
   - `git diff --staged` and `git diff` — to understand the changes

3. **Determine commit message components:**

   **Type** — infer from the nature of the changes:
   | Type | When |
   |------|------|
   | `feat` | New functionality or capability |
   | `fix` | Bug fix |
   | `refactor` | Code restructuring without behavior change |
   | `chore` | Tooling, config, dependencies, cleanup |
   | `test` | Adding or updating tests |

   **Scope** — only **apps** (from the `apps/` directory) whose runtime behavior is **directly and meaningfully changed** by this commit:
   - Examine the diff to identify which files under `apps/` were modified.
   - Only include an app if the change **actually affects its behavior** — e.g., modified source code, new routes, changed logic, updated templates.
   - **Do NOT include an app** if the only reason it's "affected" is a transitive dependency change (package.json bump, shared lib update, tsconfig change, etc.) that doesn't alter the app's own code.
   - **Never include libs in the scope** — only apps matter.
   - If exactly one app qualifies → `(orchid-webapp)`
   - If multiple apps qualify → comma-separated: `(orchid-webapp,backoffice-bff)`
   - If no apps qualify (only libs, root config, or transitive changes) → omit scope entirely.
   - **When in doubt, omit.** A missing scope is better than a wrong one.

   **Description** — concise, lowercase, imperative mood. Describe *what* the change does.

4. **Stage everything:**
   ```bash
   git add -A
   ```

5. **Commit:**
   ```bash
   git commit -m "type(scope): description"
   ```

6. **Push** (with `--no-verify` to skip pre-push hooks):
   ```bash
   git push --no-verify
   ```
   If no upstream is set:
   ```bash
   git push --no-verify -u origin $(git branch --show-current)
   ```

7. **Report** the commit hash and pushed branch to the user.

## Rules

- **Never push to `main` or `master`** — if the current branch is `main` or `master`, refuse and tell the user to switch branches. No exceptions.
- **Resolve project from context when in `work` dir** — if cwd is the top-level `work` directory, infer which sub-project to operate on from the conversation context (files edited, topics discussed). Ask the user only if ambiguous.
- **Commits must run hooks** — never use `--no-verify` on `git commit`. Pushes use `--no-verify` to skip pre-push hooks.
- **Always `git add -A`** — include all working tree changes (staged, unstaged, untracked).
- **Never ask** the user to confirm the commit message — just do it. If the message is wrong, they'll say so.
- **Never skip the push** — commit and push are one atomic action in this skill.
- **No co-author line** — do not add `Co-Authored-By` to commit messages.
