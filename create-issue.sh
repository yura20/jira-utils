#!/bin/bash

# Load values from .env
set -o allexport
source .env
set +o allexport

# Build JSON for labels (optional)
LABELS_JSON="[]"
if [[ -n "$JIRA_ISSUE_LABELS" ]]; then
  IFS=',' read -ra LABELS_ARRAY <<< "$JIRA_ISSUE_LABELS"
  LABELS_JSON=$(printf '"%s", ' "${LABELS_ARRAY[@]}")
  LABELS_JSON="[${LABELS_JSON%, }]"
fi

# Start building the payload
read -r -d '' PAYLOAD <<EOF
{
  "fields": {
    "project": { "key": "$JIRA_PROJECT_KEY" },
    "summary": "$JIRA_ISSUE_TITLE",
    "issuetype": { "name": "Task" }
EOF

# Add description if set
if [[ -n "$JIRA_ISSUE_DESCRIPTION" ]]; then
  PAYLOAD+=", \"description\": \"$JIRA_ISSUE_DESCRIPTION\""
fi

# Add assignee if set
if [[ -n "$JIRA_ISSUE_ASSIGNEE" ]]; then
  PAYLOAD+=", \"assignee\": { \"accountId\": \"$JIRA_ISSUE_ASSIGNEE\" }"
fi

# Add labels if set
if [[ "$LABELS_JSON" != "[]" ]]; then
  PAYLOAD+=", \"labels\": $LABELS_JSON"
fi

# Close JSON
PAYLOAD+=" } }"

# Send request
curl -s -X POST "$JIRA_URL/rest/api/2/issue" \
  -u "$JIRA_USER:$JIRA_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD"