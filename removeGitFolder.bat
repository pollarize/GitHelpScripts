@echo off
git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch %1%/" --prune-empty --tag-name-filter cat -- --all
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d

rem Ensure all old refs are fully removed
rm -Rf .git/logs .git/refs/original

rem Perform a garbage collection to remove commits with no refs
git gc --prune=all --aggressive

echo %1%/ >> .gitignore
git add .gitignore
rem git commit -m "Removing %1% from git history"