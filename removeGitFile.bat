@echo off
git rm %1%
git commit --amend --no-edit
git reflog expire --expire=now --all rem && git gc --prune=now --aggressive