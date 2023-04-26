#!/bin/bash

# Get the current timestamp
now=$(date +%s)

# Loop through all remote branches
for branch in $(git branch -r --no-merged); do
  # Check if the branch matches the excluded patterns
  if [[ $branch == origin/main* || $branch == origin/dev* || $branch == origin/prod* ]]; then
    continue
  fi
  # Check if the branch is older than 90 days
  last_commit=$(git log --format="%ct" -n 1 $branch)
  if (( now - last_commit > 15*24*60*60 )); then
    # Delete the branch if it has no logs or commits in the last 15 days
    if [[ $(git log $branch) == "" ]]; then
      git push origin --delete $branch
      echo "Deleted branch $branch"
    fi
  fi
done
