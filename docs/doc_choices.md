# Choices 
We decided to use simple platform that we already used to host our application. 
- backend : We'll use Render to host our backend api. 
- frontend : We'll use netlify to host our frontend. 
- Database : We'll use Neon to host our Postgres db. 
- Storybook : We 'll also use Netlify to host our storybook static website. 


# Dockerisation
Before that we 'll dockerise our app. 
-> So we are going to create a dockerfile for the backend and the frontend, use a postgres image for our db, and gather all these configurations in a docker compose. 


# CI/CD 
## Environments 
We 'll have 2 environments :
- The Prod one 
- The Dev one

We'll have a `main` branch, and `dev/` branchs on the repo. 

### Dev environment 
The `dev/` branch directory 'll contain a `main-dev` branch, and `feature/...` branchs. 
Every merge on the `dev/main-dev` branch 'll trigger a dev CI. This dev CI will do the install, the tests, the builds... and will not deployed anything for real. 
So this `dev/` branch directory 'll represent our dev environment. 

### Prod environment 
Every PR with the `main` branch 'll trigger the same CI as the dev CI (so install, tests, builds...). 
Once the merge is ok on branch main, someone in the team 'll "validate" the main branch andd 'll decide to put put in prod the main branch, he will create a tag, and push this tag. 
The tag push 'll trigger the prod CI/CD with install, tests, builds, github release, deployment of the app's diferent parts on their host platform (backend -> Render, db -> Neon etc.), deploy also the storybook, the images 'll be pushed on dockerhub... 


# Reverse-proxy  
We 'll have 3 diferent proxys. 

## Prod proxy 
For our prod app, as we host our frontend on netlify, it'll be netlify that 'll play the proxy role. 
We'll create a netlify.toml file to configure this proxy. 

## Dev proxy 
This one 'll be for our dev server in local. 
As we use Vite with react, we'll add a proxy-conf part in the vite.config.ts file to put in place this proxy on dev. 

# Docker compose proxy 
This one 'll be useful for organize trafic between our containers. As Docker isolate the services, they are'nt available outside so we need something to route requests into the good container without expose every port manually. 