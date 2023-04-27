#! /bin/bash

# Set the repository owner and name
OWNER=Lyonga
REPO=dev11923

# Set the number of days after which a branch is considered old
OLD_DAYS=30

# Get the current date in ISO-8601 format
CURRENT_DATE=$(date -I)

# Calculate the date X days ago in ISO-8601 format
OLD_DATE=$(date -I -d "$CURRENT_DATE-$OLD_DAYS days")

# Get the list of branches that were last updated before the old date
BRANCHES=$(curl -s -H "Authorization: token DEL_GITHUB_TOKEN" \
  "https://api.github.com/repos/$OWNER/$REPO/branches?per_page=100" | \
  jq -r '.[] | select(.commit.commit.committer.date < "'$OLD_DATE'") | select(.name != "'$DEFAULT_BRANCH'") | select(.protected != true) | .name'

# Delete each branch
for BRANCH in $BRANCHES; do
  echo "Deleting branch: $BRANCH"
  curl -X DELETE -H "Authorization: token DEL_GITHUB_TOKEN" \
    "https://api.github.com/repos/$OWNER/$REPO/git/refs/heads/$BRANCH"
done
