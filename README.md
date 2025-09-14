# Jira Bash Scripts

Bash utilities for automating Jira tasks via the REST API.
Currently includes a script to create Jira issues.


## 🔧 Setup

1. Clone the repo:

   ```bash
   git clone https://github.com/yura20/jira-utils.git
   cd jira-bash-scripts
   ```

2. 🔑 Get your Jira API token:

    Visit [Atlassian API Tokens](https://id.atlassian.com/manage-profile/security/api-tokens)

    Click Create API token → give it a name → copy it

3. Add a `.env` file:

   ```env
   JIRA_URL=https://your-domain.atlassian.net
   JIRA_USER=your-email@example.com
   JIRA_API_TOKEN=your-api-token
   JIRA_PROJECT_KEY=PROJ
   JIRA_ISSUE_TITLE="Sample issue"
   # Optional
   JIRA_ISSUE_DESCRIPTION="Created via bash script"
   JIRA_ISSUE_ASSIGNEE=accountId-from-jira
   JIRA_ISSUE_LABELS=bug,automation,shell
   ```


## ▶️ Usage

Make the script executable (once):

```bash
chmod +x create-issue.sh
```

Run it:

```bash
./create-issue.sh
```


## 📌 Roadmap

* Subtask creation
* Transition statuses
* Add comments & attachments

