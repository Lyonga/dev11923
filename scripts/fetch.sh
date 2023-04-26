#!/bin/sh

ECHO='echo '
for branch in $(git branch -a | sed 's/^\s*//' | sed 's/^remotes\///' | grep -v 'master$'); do
  if [[ "$(git log $branch --since "Jan 01, 2022" | wc -l)" -eq 0 ]]; then
    if [[ "$DRY_RUN" = "false" ]]; then
      ECHO=""
    fi
    local_branch_name=$(echo "$branch" | sed 's/remotes\/origin\///')
    $ECHO ${local_branch_name} >> branchesList.txt
  fi
done
