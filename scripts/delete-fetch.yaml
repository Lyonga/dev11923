#!/bin/bash
input="./branchesList.txt"
while IFS= read -r line
do
  echo "About to delete branch name :: $line" >> deletedBranches.txt
  git push origin --delete "${line}"
done < "$input"
