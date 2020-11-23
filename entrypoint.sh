#! /bin/bash

# Copyright (c) 2020 Avinal Kumar
#
# Distributed under the terms of MIT License
#
# The full license is in the file LICENSE, distributed with this software.

# constants
RED='\033[0;31m' # Red color output for failed commands
GREEN='\033[1;32m'
clone_repo="https://github.com/${GITHUB_REPOSITORY}.git" # Repository URL
remote_repo="https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" # remote repo address

# Function to check success of a command
function check_success() {
if [ $? -eq 0 ]
then
    echo -e "$1"
else
    echo -e "${RED}$2"
    exit 1
fi
}

# GITHUB_TOKEN check
if [ -z "${INPUT_GITHUB_TOKEN}" ]; then
    echo -e "${RED}error: GITHUB_TOKEN not found"
    exit 1
fi

# Cloning
git clone --single-branch --branch "${INPUT_BRANCH}" "${clone_repo}"
check_success "cloned branch:${INPUT_BRANCH}" "error: cloning failed"

# resolving repository name
IFS='/' read -ra reponame <<< "${GITHUB_REPOSITORY}"
repository="${reponame[1]}"
check_success "repository name resolved ${repository}" "error: repository name resolution failed"

# chek if image is present or not
if [[ ! -f "stat.svg" ]]; then
    echo "${RED}error: file lost! existing"
    exit 1
fi

# images folder creating/updation
if [[ ! -d "${repository}/images" ]]
then
    mkdir -p "${repository}/images"
    check_success "images folder created" "error: cannot create folder"
elif [[ -f "${repository}/images/stat.svg" ]]
then
    rm "${repository}/images/stat.svg" 
    check_success "old images removed" "error: cannot remove images"
fi

# updating images
cp stat.svg "${repository}/images"
check_success "new image copied" "error: cannot replace image"

cd "${repository}"

git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git config user.name "GitHub Actions"
check_success "git credential added" "error: git credential wrong/missing"

git remote add publisher "${remote_repo}"
git remote -v

git checkout ${INPUT_BRANCH}

# push to github
git stage "images/stat.svg"
git commit -m "${INPUT_COMMIT_MSG}"
git pull
git push publisher ${INPUT_BRANCH}
check_success "${GREEN}Successfully updated coding activity" "error: push error"
