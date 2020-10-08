# DevSecOps-Labs
Labs repository for the Security Mountaineering Pathway


ToDo: 
- Paste your GitHub repo path in the Jenkinsfile. This will need to be a public repo
- We have Poll SCM enabled for * * * * * 
- This is because I don't want to spend time working on linking personal access tokens to your GitHubs from my Jenkins. 
- It's not perfect, but it'll query once per minute and will detect changes. If any changes (i.e.: commits) exist, it'll build that. 
- You can disable this by removing the * * * * * in Configure -> Poll SCM. You'll have to build manually or put your tokens in. Not responsible for anything that happens. 



