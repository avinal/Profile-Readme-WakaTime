<p align=center><img src="/waka.png"></p>
<p align=center><a href="https://github.com/avinal/Profile-Readme-WakaTime/blob/master/LICENSE"><img src="https://img.shields.io/github/license/avinal/Profile-Readme-WakaTime" alt="License"></a> <a href="https://github.com/avinal/Profile-Readme-WakaTime/releases"><img src="https://img.shields.io/github/v/release/avinal/Profile-Readme-WakaTime" alt="Releases"></a> <a href="https://github.com/avinal/lark"><img src="https://img.shields.io/badge/uses-avinal%2Flark-blueviolet"></a> <img src="https://github.com/avinal/avinal/workflows/Build%20Graph/badge.svg" alt="Build"> <img src="https://wakatime.com/badge/github/avinal/Profile-Readme-WakaTime.svg" alt="Time Tracked"> <a href="https://github.com/avinal/Profile-Readme-WakaTime/discussions"><img src="https://img.shields.io/badge/QnA-Discussions-blueviolet"></a></p>

If you use WakaTime to track your coding activity. You can add that to your README as a bar graph or embed in your blog/portfolio. Just add this action to any of your repository and there you have it. See mine below. 

## My WakaTime Coding Activity
<img src="https://github.com/avinal/avinal/blob/main/images/stat.svg" alt="Avinal WakaTime Activity"/>

## How to add one to your README.md
1. First get your WakaTime API Key. You can get it from your [WakaTime](https://wakatime.com) account settings. 
2. Save WakaTime API Key to Repository Secret. Find that by clicking the Settings tab. Keep the name of secret as **WAKATIME_API_KEY**.
3. Add following line in your README.md of your repo.
  ```html
  <img src="https://github.com/<username>/<repository-name>/blob/<branch-name>/images/stat.svg" alt="Alternative Text"/>
  Example: <img src="https://github.com/avinal/avinal/blob/main/images/stat.svg" alt="Avinal WakaTime Activity"/>
  ```
  You can use this method to embed in web pages too. *Do not use markdown method of inserting images. It does not work some times.*
  
4. Click **Action** tab and **choose set up a workflow yourself**.
5. Copy the following code into the opened file, you can search for **WakaTime Stat** in marketplace tab for assistance.
```yml
name: WakaTime status update 

on:
  schedule:
    # Runs at 12 am  '0 0 * * *'  UTC
    - cron: '1 0 * * *'

jobs:
  update-readme:
    name: Update the WakaTime Stat
    runs-on: ubuntu-latest
    steps:
      # Use avinal/Profile-Readme-WakaTime@<latest-release-tag> for latest stable release
      # Do not change the line below until you have forked this repository
      # If you have forked this project you can use <username>/Profile-Readme-WakaTime@master instead
      - uses: avinal/Profile-Readme-WakaTime@master
        with:
          # WakaTime API key stored in secrets, do not directly paste it here
          WAKATIME_API_KEY: ${{ secrets.WAKATIME_API_KEY }}
          # Automatic github token
          GITHUB_TOKEN: ${{ github.token }}
          # Branch - newer GitHub repositories have "main" as default branch, change to main in that case, default is master
          BRANCH: "master"
          # Manual Commit messages - write your own messages here
          COMMIT_MSG: "Automated Coding Activity Update :alien:"

```
6. Please wait till 12 AM UTC to run this workflow automatically. Or you can force run it by going to Action tab. Or you can add following lines under `on:` to run with every push. Search for 12 AM UTC to find equivalent time in your time zone. 
```yml
on:
  push:
    branches: [ master ]
  schedule:
    - cron: '1 0 * * *' 
```

