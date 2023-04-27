
#!/bin/bash

set -e
set -x

git fetch
for branch in $(git branch -a | sed 's/^\s*//' | sed 's/^remotes\///' | grep -v 'master$'); do
  if [[ "$(git log --since "April 02, 2023" $branch | wc -l)" -eq 0 ]]; then
    local_branch_name=$(echo "$branch" | sed 's/remotes\/origin\///')
    if git rev-parse --quiet --verify "origin/$local_branch_name" > /dev/null; then
    echo "Deleting branch $local_branch_name..."
    git push --delete origin "$local_branch_name" || true
    fi
  fi
done
