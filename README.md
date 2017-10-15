# East Bay DSA website

This project aims to replace the existing NationBuilder-backed site with a
new website built in Rails, that gives us an easy platform for technical
volunteers to join, and a solid foundation for building advanced features
going forward.

## Getting Started

Dependencies:

* Ruby >= 2.4.0
* Postgres
  * [postgresapp.com](https://postgresapp.com) is a great option here
  * Alternatively, you can install with [homebrew](https://brew.sh/)
* bundler (gem install bundler)
* foreman (gem install foreman)

### First time setup

Clone the repository source to local machine:

```sh
git clone git@github.com:eastbaydsa/website.git ebdsa-website
cd ebdsa-website
```

In the cloned directory, install your gem dependencies with `bundler`:

```sh
bundle install
```

Create your database and run migrations:

```sh
bin/rake db:setup
```

And start your local server with `foreman`:

```sh
foreman start
```

Your site will be available at http://localhost:5000

### NationBuilder Data

Events are loaded from NationBuilder via its API. To connect to the API,
you must supply the following three environment variables:

```
NATION_NAME=xxx
NATION_API_TOKEN=xxx
NATION_SITE_SLUG=xxx
```

In development, you can set these in a `.env` file at your application root.

## Deployment

### Setup

Some helpful info can be found
[here](https://devcenter.heroku.com/articles/getting-started-with-rails5).

You'll need to be added as a collaborator on any Heroku apps you want to
deploy to.

Install [the Heroku Toolbelt](https://devcenter.heroku.com/articles/heroku-cli).
You can use Homebrew to do this:

```sh
brew install heroku/brew/heroku
```

Hook your local repo up to the Heroku app by adding a Git remote:

```sh
heroku git:remote -a eastbaydsa-website-staging
```

### Deploy

Use Git to push the code to Heroku:

```sh
git push heroku main:master
```

You can name any local branch you want, but if should be pushed to the `master`
branch on Heroku.

TODO(bcipriano) This is fine for the staging app, but once a prod app is
running we should ensure only `main` can be pushed there.

Next, run db migrations:

```sh
heroku run rake db:migrate
```

You can use the Heroku CLI to open the app in your browser:

```sh
heroku open
```

## Troubleshooting

### Postgres issues

If you encounter this error while working with the database:

```
psql: could not connect to server: No such file or directory
    Is the server running locally and accepting
    connections on Unix domain socket "/var/pgsql_socket/.s.PGSQL.5432"?
```

This can be fixed by adding the following environment variable to your shell
profile (`~/.bash_profile` or `~/.zshrc`):

```bash
export PGHOST=localhost
```

This works because if `PGHOST` is not defined, Postgres will attempt to connect
to a Unix domain socket instead.
