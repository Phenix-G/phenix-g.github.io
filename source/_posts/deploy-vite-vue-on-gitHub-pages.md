---
title: How to Deploy Your Vite/Vue 3 Application on GitHub Pages
---

Deploying a Vite/Vue 3 application on GitHub Pages is a straightforward process that allows you to showcase your web application easily. In this tutorial, we'll guide you through the steps to deploy your Vite/Vue 3 app on GitHub Pages.

## Prerequisites

- A Vite/Vue 3 project set up on your local machine.
- A GitHub account.
- Basic knowledge of Git and GitHub.

## Step 1: Create Your Vite/Vue 3 Application

If you haven't already created a Vite/Vue 3 application, you can do so with the following command:

```bash
npm create vue@latest
```

This command will install and execute [create-vue](https://github.com/vuejs/create-vue), the official Vue project scaffolding tool. You will be presented with prompts for several optional features such as TypeScript and testing support:

```bash
✔ Project name: … <your-project-name>
✔ Add TypeScript? … No / Yes
✔ Add JSX Support? … No / Yes
✔ Add Vue Router for Single Page Application development? … No / Yes
✔ Add Pinia for state management? … No / Yes
✔ Add Vitest for Unit testing? … No / Yes
✔ Add an End-to-End Testing Solution? … No / Cypress / Nightwatch / Playwright
✔ Add ESLint for code quality? … No / Yes
✔ Add Prettier for code formatting? … No / Yes
✔ Add Vue DevTools 7 extension for debugging? (experimental) … No / Yes

Scaffolding project in ./<your-project-name>...
Done.
```

If you are unsure about an option, simply choose No by hitting enter for now. Once the project is created, follow the instructions to install dependencies:

```bash
cd <your-project-name>
npm install
```

This will create a new Vue 3 application using Vite.

## Step 2: Configure `vite.config.js`

To ensure that your Vite app can be deployed to GitHub Pages, you'll need to update your `vite.config.js` file to set the base path. Open the `vite.config.js` file and add the `base` option with the name of your repository:

```js
import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';

export default defineConfig({
  plugins: [vue()],
  base: '/your-repo-name/', // Replace 'your-repo-name' with the name of your repository
});
```

## Step 3: Initialize a GitHub Repository

[Create a new blank repository on GitHub](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository).
![Create a new blank repository](https://raw.githubusercontent.com/Phenix-G/image-hosting/main/2024-08-28-02-42-10.png)

let's move to <your-project-name> location with ```cd <your-project-name>```

check if there is a ```.git``` dictionary, use ```ls -la```, this will show all the file and dictionary (including item) in current location.
   ![Project dictionary](https://raw.githubusercontent.com/Phenix-G/image-hosting/main/2024-08-28-02-51-46.png)

if the ```.git``` don't exist, use ```git init``` to initialize a repository

After you have it set up, grab the remote URL

```bash
git remote add origin <REMOTE_URL>
git remote -v
```

## Step 4: Install `gh-pages`

Install the `gh-pages` package to handle deploying your application to GitHub Pages:

```bash
npm install gh-pages --save-dev
```

## Step 5: Update `package.json` for Deployment

Add the following scripts to your `package.json` to handle the build and deployment process:

```json
"scripts": {
  "build": "vite build",
  "deploy": "gh-pages -d dist"
}
```

These scripts will build your application and deploy the `dist` folder to GitHub Pages.

## Step 6: Commit and Push Changes

Commit and push all your changes to the GitHub repository:

```bash
git add .
git commit -m "Set up Vite/Vue app for deployment"
git branch -M main
git push origin main
```

## Step 7: Deploy Your Application

Now in your ```package.json```, we add scripts before.

  ```json
  "scripts": {
    "build": "vite build",
    "deploy": "gh-pages -d dist"
  }
  ```

Then all you need to do to deploy your app to GitHub pages is run the command:

```bash
npm run build
npm run deploy
```

It will take your latest /dist folder push it into the gh-pages branch!

![Commit log](https://raw.githubusercontent.com/Phenix-G/image-hosting/main/2024-08-12-18-37-12.png)

![GitHub gh-pages branch](https://raw.githubusercontent.com/Phenix-G/image-hosting/main/2024-08-12-18-25-07.png)

## Step 8: Check Your Website

Go to your Github Repository, and click the ```Settings``` buttom, then click the ```Pages``` on the left.

you should see a URL at the top by now indicating your website is live at that location.
![Settings](https://raw.githubusercontent.com/Phenix-G/image-hosting/main/2024-08-12-18-34-48.png)
 Visit `https://<username>.github.io/your-repo-name/` to see your Vite/Vue 3 application live!

![Website](https://raw.githubusercontent.com/Phenix-G/image-hosting/main/2024-08-28-04-04-50.png)

Congratulations you did it!

## Troubleshooting Tips

If your deployment fails, check the following:

- Ensure that your `vite.config.js` is correctly set up with the `base` path.

## Additional Resources

- [Vite Documentation](https://vitejs.dev/guide/)
- [Vue 3 Documentation](https://vuejs.org/guide/introduction.html)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
