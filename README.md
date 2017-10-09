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

## Deployment

TBD but probably Heroku

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
