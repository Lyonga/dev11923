#!/bin/bash

set -e

for branch in $(git branch -a | sed 's/^\s*//' | sed 's/^remotes\///' | grep -v 'master$'); do
  if [[ "$(git log $branch --since "April 02, 2023" | wc -l)" -eq 0 ]]; then
    local_branch_name=$(echo "$branch" | sed 's/remotes\/origin\///')
    echo "Deleting branch $local_branch_name..."
    git push --delete origin "$local_branch_name"
  fi
done
