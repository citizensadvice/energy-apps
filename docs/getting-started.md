# Getting started

The following guide runs you through getting the application set up and working with the application in development.

## Prerequisites

Running the project locally requires a few dependencies.

### Ruby

Ruby version 3.2+ is required. We include a `.ruby-version` file in the root of the project so if you are using a version manager like [rvm](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv) it should pick this up.

### Node and Yarn

Node 20+ is required. We include a `.nvmrc` file in the root of the project so if you are using [nvm](https://github.com/nvm-sh/nvm) it should pick this up.

The project uses `yarn`. Recent versions of node include a tool called `corepack` which [includes yarn](https://nodejs.org/tr/blog/release/v14.19.0#corepack). You can enable yarn on your system by running the following:

```
corepack enable
```

## Setup

All example commands should be run from the root of the project directory once you have installed the pre-requisites above.

### Run the Rails setup script

Running the following from the root of the project will install all ruby and client-side dependencies. This can be run at any time.

```sh
./bin/setup
```

### Pre-compile assets

When running the specs for the first time you may need to pre-compile assets using:

```sh
./bin/rails assets:precompile
```

### Running the specs

A good way to quickly check that the local setup is working correctly is to run the specs. This can be done with:

```sh
./bin/rails spec
```

### Run the application

You can run the application along with asset compilation using the following dev script:

```sh
./bin/dev
```

If all is working you should be able to access the application at `http://localhost:3300/`
