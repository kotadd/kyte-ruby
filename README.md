# README

* The way to develop on this project.  

[remote(GitLab)]
1. Create issues first on GitLab.  
2. Create merge request with specified name on the issue page.  

[local]
1. `git fetch origin` on your local Kyte project. 
2. `git checkout <your issue branch>`.
3. develop your feature. 
4. `git add <your featured files>`. 
5. `git cz`. *1
6. `git push origin <your issue branch>` . 

[remote(GitLab)]
1. remove "WIP:" from your issue's merge request if your implementation finished. 


*1 commit rule (refer to: https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#type)  

Please conduct the below commands in your local environment. (https://github.com/commitizen/cz-cli)

```
npm install commitizen -g
commitizen init cz-conventional-changelog --save-dev --save-exact
```
Then you can use `git cz` instead of `git commit` to write the commit sentence. 
The types are like below. 

feat: A new feature  
fix: A bug fix  
docs: Documentation only changes  
style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)  
refactor: A code change that neither fixes a bug nor adds a feature  
perf: A code change that improves performance  
test: Adding missing or correcting existing tests  
chore: Changes to the build process or auxiliary tools and libraries such as documentation generation  


