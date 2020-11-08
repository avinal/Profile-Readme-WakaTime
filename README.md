**This repository has been archived and won't be updated in future. Please fork a copy if you liked this project and want to modify or keep using.**

# Profile-Readme-WakaTime
![LICENSE](https://img.shields.io/github/license/avinal/Profile-Readme-WakaTime?style=flat-square)

If you use WakaTime to track your coding activity. You can add that to your README as a picture or embed in your website. Just add this action to any of your repository and there you have it. 

## How to add one to your README.md
1. First get your WakaTime API Key. You can get it from your [WakaTime](https://wakatime.com) account settings. 
2. Save WakaTime API Key to Repository Secret. Find that by clicking the Settings tab. Keep the name of secret as **WAKATIME_API_KEY**.
3. Add following line in your README.md of your repo.
  ```html
  <img src="https://github.com/<username>/<repository-name>/blob/master/images/stat.svg" alt="Alternative Text"/>
  ```
  You can use this method to embed in web pages too. 
  
4. Click **Action** tab and **choose set up a workflow yourself**.
5. Copy the following code into the opened file, you can search for **WakaTime Stat** in marketplace tab for assistance.
```yml
name: WakaTime stat update in README.md

on:
  schedule:
    # Runs at 12 am  '0 0 * * *'  UTC
    - cron: '1 0 * * *'

jobs:
  update-readme:
    name: Update the WakaTime Stat
    runs-on: ubuntu-latest
    steps:
      # If you have forked this repo then you can use <username>/Profile-Readme-WakaTime@master
      - uses: avinal/Profile-Readme-WakaTime@master
        with:
          WAKATIME_API_KEY: ${{ secrets.WAKATIME_API_KEY }}
          GITHUB_TOKEN: ${{ github.token }}
```
6. Please wait till 12 AM UTC to run this workflow automatically. Or you can force run it by going to Action tab. Or you can add following lines under `on:` to run with every push. Search for 12 AM UTC to find equivalent time in your time zone. 
```yml
on:
  push:
    branches: [ master ]
  schedule:
    - cron: '1 0 * * *' 
```
Thanks!