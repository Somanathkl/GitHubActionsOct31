runId=$(gh run list --status "Success" -e "pull_request" --json headSha,number,status,workflowName,conclusion,databaseId | jq -r '.[] | select(.conclusion == "success") | .databaseId' | head -1)

gh run download $runId -D "Artifact/"

mv Artifact/sf-package/destructiveChanges.xml package/