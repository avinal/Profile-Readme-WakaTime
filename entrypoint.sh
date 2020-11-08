#! /bin/bash
if [ -z "${INPUT_GITHUB_TOKEN}" ]; then
    echo "error: not found GITHUB_TOKEN"
    exit 1
fi

clone_repo="https://github.com/${GITHUB_REPOSITORY}.git"
git clone "${clone_repo}"
echo "Repository Cloned"

IFS='/' read -ra reponame <<< "${GITHUB_REPOSITORY}"
repository="${reponame[1]}"
echo "repository name resolved ${repository}"

if [[ ! -f "stat.svg" ]]; then
    echo "error: file lost! existing"
    exit 1
fi

if [[ ! -d "${repository}/images" ]]
then
    mkdir -p "${repository}/images"
    echo "images folder created"
else
    rm "${repository}/images/stat.svg" 
    rm "${repository}/images/stat.png" 
    echo "old images removed"
fi

cp stat.svg "${repository}/images"
cp stat.png "${repository}/images"
echo "copied new images"

cd "${repository}"

remote_repo="https://${GITHUB_ACTOR}:${INPUT_GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git config user.name "GitHub Actions"
echo "git credential added" 

git remote add publisher "${remote_repo}"
git remote -v

git checkout master

git add .
git commit -m "Automated Coding Activity Update :alien:"
git pull
git push publisher master
echo "image update successfull"
