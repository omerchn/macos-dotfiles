---
name: get-dev-tickets
description: Use when the user asks to see tickets in dev, check what's in dev, or review dev/staging status.
user_invocable: true
---

# Get Dev Tickets

Query Jira for all tickets currently in dev or ready for staging across Orchid projects.

## Steps

1. Use the `mcp__claude_ai_Atlassian__searchJiraIssuesUsingJql` tool with:
   - cloudId: `152e73e7-0167-4a3d-a1bc-330c41b8225e`
   - jql: `project in ("Core & Applications","Orchid Console",Backoffice, APP) and status in ("Testing In Dev", "Ready For Staging") ORDER BY status`
   - fields: `["summary", "status", "assignee", "issuetype", "priority"]`
   - maxResults: `50`

2. Display results as a table with columns: Key, Summary, Status, Assignee, Priority. Include the Jira link for each ticket.
