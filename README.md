# LeetOps Deploy Challenge

A simple local deployment challenge for learning DevOps fundamentals.

## Overview

This project contains a basic "Hello, World" web page and an automated deployment script that deploys it to a local nginx server.

## Contents

- [index.html](index.html) - Simple static web page
- [DEPLOY.sh](DEPLOY.sh) - Automated deployment script

## Prerequisites

- Linux system with systemd
- nginx installed and configured
- sudo access
- Web root directory at `/var/www/html`

## Usage

### Deploy the application

```bash
./DEPLOY.sh
```

This will:
1. Copy `index.html` to `/var/www/html/`
2. Set appropriate permissions (644)
3. Restart the nginx service
4. Output the local URL: `http://localhost/`

### Dry run mode

Preview the deployment commands without executing them:

```bash
./DEPLOY.sh -d
# or
./DEPLOY.sh --dry
```

## Deployment Logs

All deployment activities are logged to `deploy.log` with timestamps.

## Project Structure

```
leetOps-deploy-challenge/
├── DEPLOY.sh       # Deployment automation script
├── index.html      # Web page to deploy
├── .gitignore      # Git ignore rules
└── README.md       # This file
```
