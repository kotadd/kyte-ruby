# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* commit rule (refer to: https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#type)  

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

