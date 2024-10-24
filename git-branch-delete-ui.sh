#!/usr/bin/env bash
#
# git-branch-delete-ui script uses an user interface to delete branches

readonly CURRENT_BRANCHES_MSG='Current Branches to remove, select them:'

readonly DIDNT_SELECT_BRANCH_MSG='You did not select any branch'
readonly NO_BRANCHES_ERROR_MSG='No branches'

readonly SUCCESS_MSG='Selected branches were removed'
readonly ERROR_REPO="Current directory is not a git repository"

warning_unselected_msg=

git rev-parse --is-inside-work-tree >/dev/null 2>&1 \
  || { error ${ERROR_REPO}; return 1; }

current_branches=$(git for-each-ref --format='%(refname:short)' refs/heads/ \
  | cut -d " " -f 1)

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
  date_format='%Y-%m-%dT%H:%M:%S%'
  echo "[🟡 $(date +${date_format})]: $*" >&2
}

clean_branches() {
  current_branches=$1
  current_branch=$(git rev-parse --abbrev-ref HEAD \
    | sed 's;/;\\/;g')
  current_branches=$(echo ${current_branches} \
    | sed '/master/d' \
    | sed '/main/d' \
    | sed "/${current_branch}/d")
}

are_you_sure_msg() {
  selected_branches=$1
  dialog --title "Are you sure you want to delete these branches?: ${selected_branches}" \
    --yesno "continue?" 0 0
}

clean_branches ${current_branches}

if [[ ${current_branches} ]]; then
  echo ${current_branches}
  let counter=0
  line=$(echo ${current_branches} \
    | while read branch; do 
        let "counter+=1"
        echo "\"${branch}\" \"${counter}\" off"
      done)
  selected_branches=$(echo "${line}" \
    | xargs dialog --stdout --checklist ${CURRENT_BRANCHES_MSG} 0 0 0)
  [[ -n "${selected_branches}" ]] \
    && areYouSureMsg ${selected_branches} \
    && echo ${selected_branches} | xargs git branch -D \
    && echo "🟢 ${selected_branches} ${SUCCESS_MSG}" \
    || warning_unselected_msg=${DIDNT_SELECT_BRANCH_MSG}
else
  error ${NO_BRANCHES_ERROR_MSG}
fi

[[ -n "${warning_unselected_msg}" ]] && warning ${warning_unselected_msg}
