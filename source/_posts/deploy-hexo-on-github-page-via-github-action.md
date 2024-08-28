---
title: Deploy Your Hexo Blog on GitHub Pages via GitHub Actions
---

Deploying a Hexo blog to GitHub Pages using GitHub Actions is a powerful way to automate the deployment process and keep your blog up to date with minimal effort. In this tutorial, we'll walk you through the steps to set up continuous deployment for your Hexo blog using GitHub Actions.

## Prerequisites

- A Hexo blog set up on your local machine.
- A GitHub repository to host your blog.
- Basic knowledge of Git and GitHub.

## Step 1: Prepare Your Hexo Blog

Before deploying, ensure your Hexo blog is ready. If you haven’t created a Hexo blog yet, follow the [official Hexo documentation](https://hexo.io/docs/) to set it up.

Run the following command to generate the static files for your blog:

```bash
hexo generate
```

## Step 2: Initialize GitHub Repository and Configure Local Repository

### if you already Configure, you can skip this step

1. Create a new repository on GitHub. You can name it as `username.github.io` if you want to host it as a user page.
2. Run the following command to connect your GitHub repository

```bash
git init
git remote add origin <REMOTE_URL>
git remote -v
```

## Step 3: Generate GitHub PTA and Configure

1. To automate the deployment, we must generate a [GitHub Personal Access Token](https://github.com/settings/tokens).

![Generate Personal Access Token](https://raw.githubusercontent.com/Phenix-G/image-hosting/main/2024-08-14-01-11-50.png)

2. Now, going back to your GitHub Repository `Settings` -> `Secrets and variables` -> `Actions`, click the `New repository secret` buttom, and add a named `TOKEN`.

![Settings Secret](https://raw.githubusercontent.com/Phenix-G/image-hosting/main/2024-08-28-17-53-34.png)

![Add Token](https://raw.githubusercontent.com/Phenix-G/image-hosting/main/2024-08-28-17-55-11.png)

3. Then go to the `Pages`, click `Deploy from a branch` buttom and select `GitHub Actions`

![Deploy from Actions](https://raw.githubusercontent.com/Phenix-G/image-hosting/main/2024-08-28-18-02-09.png)

## Step 4: Configure GitHub Actions Workflow

1. In your hexo blog folder, create a new directory named `.github/workflows`.

2. Inside the `workflows` directory, create a new file named `deploy.yml`.

3. Open `deploy.yml` and add the following content to set up the GitHub Actions workflow:

```yaml
name: Deploy Hexo Blog

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          token: ${{ secrets.TOKEN }}
          # If your repository depends on submodule, please see: https://github.com/actions/checkout
          submodules: recursive
      - name: Use Node.js 18
        uses: actions/setup-node@v4
        with:
          # Examples: 20, 18.19, >=16.20.2, lts/Iron, lts/Hydrogen, *, latest, current, node
          # Ref: https://github.com/actions/setup-node#supported-version-syntax
          node-version: "18"
      - name: Cache Yarn dependencies
        uses: actions/cache@v4
        with:
          path: node_modules
          key: ${{ runner.OS }}-yarn-cache-${{ hashFiles('**/yarn.lock') }}
          restore-keys: |
            ${{ runner.OS }}-yarn-cache
      - name: Install Dependencies
        run: yarn install
      - name: Build
        run: yarn run build
      - name: Upload Pages artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./public
  deploy:
    needs: build
    permissions:
      pages: write
      id-token: write
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

## Step 5: Commit and Push the Workflow File

1. Save the `deploy.yml` file.
2. Commit and push the changes to your GitHub repository:

```bash
git add .
git commit -m "Add GitHub Actions workflow for Hexo deployment"
git push origin main
```

## Step 5: Test Your Deployment

1. Go to the "Actions" tab in your GitHub repository to see the workflow running. If everything is set up correctly, you should see a successful run of your deployment workflow.
2. After the deployment is complete, the link will be indicated in `Settings` -> `Pages`. Now, go to <`https://yourusername.github.io`> to see your Hexo blog live.

![Blog link](https://raw.githubusercontent.com/Phenix-G/image-hosting/main/2024-08-28-18-11-21.png)

## Troubleshooting Tips

If your deployment fails, check the following:

- Ensure your `deploy.yml` file is correctly formatted.
- Make sure all required secrets (like `TOKEN`) are set up correctly.
- Check the logs in the GitHub Actions tab for any specific errors.

## Conclusion

Deploying your Hexo blog to GitHub Pages using GitHub Actions provides a seamless and automated deployment process. By following this tutorial, you can easily set up a continuous deployment workflow, ensuring your blog is always up to date with your latest content changes.

Now you can focus more on creating content for your blog while GitHub Actions takes care of the deployment for you!

## Additional Resources

- [Hexo Deployment](https://hexo.io/docs/github-pages)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
