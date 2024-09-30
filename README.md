# AWS ClamAV Layer & a service using it to scan files

## Getting started

1. Clone this repo

    ```bash
    git clone git@github.com:clicktechnology/serverless-clamav-lambda-layer.git
    ```

2. Install the node packages

    ```bash
    npm install
    ```

3. Build the Clamav Lambda layer

    ```bash
    bash ./build
    ```

## Deployment

Deployment can be done through your CI/CD process, or via command line:

1. Install the serverless framework, if you don't already have it installed.  You _may_ need `sudo` privs.

    ```bash
    npm i serverless -g
    ```

2. Deploy the application using the `sls` command..

    ```bash
    sls deploy --aws-profile skorelabs
    ```

## Unit Tests

There's only one unit test for our handler, but to run it you'll need to install the `devDependencies`

1. run `npm i`
2. run `npm run test`
