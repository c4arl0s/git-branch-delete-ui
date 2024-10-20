# [go back to overview](https://github.com/c4arl0s#bash-scripts)

`git-delete-branches-ui.sh` scripts helps you to delele interactively branches from the current git repository.

<img width="400" alt="Screenshot 2024-10-20 at 3 11 12 p m" src="https://github.com/user-attachments/assets/ab33d8bc-e216-44c5-9429-ff92e2646204">

# Code

```bash
#!/usr/bin/env bash
#
# git-delete-branches-ui script uses an user interface to delete branches

readonly CURRENT_BRANCHES_MSG='Current Branches to remove, select them:'

readonly DIDNT_SELECT_BRANCH_MSG='You did not select any branch'
readonly NO_BRANCHES_ERROR_MSG='No branches'

readonly SUCCESS_MSG='Selected branches were removed'
readonly ERROR_REPO="Current directory is not a git repository"

warning_unselected_msg=

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || { error ${ERROR_REPO}; return 1; }

current_branches=$(git for-each-ref --format='%(refname:short)' refs/heads/ | cut -d " " -f 1)

#######################################
# A function to print out error messages 
# Globals:
#   
# Arguments:
#   None
#######################################
error() {
  echo "[🔴 $(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

#######################################
# A function to print out warning messages 
# Globals:
#   
# Arguments:
#   None
#######################################
warning() {
  echo "[🟡 $(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

if [[ -n ${current_branches} ]]; then
  let counter=0
  line=$(echo ${current_branches} \
    | while read current_branch; do 
        let "counter+=1"
        echo "\"${current_branch}\" \"${counter}\" off"
      done)
  selected_branches=$(echo "${line}" | xargs dialog --stdout --checklist ${CURRENT_BRANCHES_MSG} 0 0 0)
  [[ -n "${selected_branches}" ]] \
    && echo ${selected_branches} | xargs git branch -D \
    && echo "🟢 ${selected_branches} ${SUCCESS_MSG}" \
    || warning_unselected_msg=${DIDNT_SELECT_BRANCH_MSG}
else
  error ${NO_BRANCHES_ERROR_MSG}
fi

[[ -n "${warning_unselected_msg}" ]] && warning ${warning_unselected_msg}
```

<img width="400" alt="Screenshot 2024-10-20 at 3 11 12 p m" src="https://github.com/user-attachments/assets/ab33d8bc-e216-44c5-9429-ff92e2646204">
