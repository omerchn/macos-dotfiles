---
name: get-staging-tickets
description: Use when the user asks to see tickets in staging, check what's in staging, or review staging/production readiness status.
user_invocable: true
---

# Get Staging Tickets

Query Jira for all tickets currently in staging or ready for production across Orchid projects.

## Steps

1. Use the `mcp__claude_ai_Atlassian__searchJiraIssuesUsingJql` tool with:
   - cloudId: `152e73e7-0167-4a3d-a1bc-330c41b8225e`
   - jql: `project in ("Core & Applications","Orchid Console",Backoffice, APP) and status in ("Testing in Staging", "Ready For Production") ORDER BY status`
   - fields: `["summary", "status", "assignee", "issuetype", "priority"]`
   - maxResults: `50`

2. Display results as a table with columns: Key, Summary, Status, Assignee, Priority. Include the Jira link for each ticket.
