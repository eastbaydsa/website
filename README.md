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

### S3 Upload

We preconfigure some fields to upload file attachments to
[S3](https://aws.amazon.com/s3/). For this to work you must supply the
following environment variables:

```
AWS_ACCESS_KEY_ID=xxx
AWS_SECRET_ACCESS_KEY=xxx
AWS_BUCKET_NAME=xxx
```

In development, you can set these in a `.env` file at your application root.

The AWS key/secret you use must belong to a user with permission to create S3
objects.

The S3 bucket you use should have the following configuration. First, a bucket
policy that allows objects to be publicly readable.

```
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "AllowPublicRead",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::$AWS_BUCKET_NAME/*"
        }
    ]
}
```

Substitute `$AWS_BUCKET_NAME` for your actual bucket name.

Uploads are done using
[pre-signed URLs](http://docs.aws.amazon.com/AmazonS3/latest/dev/PresignedUrlUploadObject.html)
so no general write permissions should be required.

Next, set a bucket CORS policy that will allow requests coming from the site:

```
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
<CORSRule>
    <AllowedOrigin>$SITE_FQDN</AllowedOrigin>
    <AllowedMethod>GET</AllowedMethod>
    <AllowedMethod>POST</AllowedMethod>
    <AllowedMethod>PUT</AllowedMethod>
    <MaxAgeSeconds>3000</MaxAgeSeconds>
    <AllowedHeader>*</AllowedHeader>
</CORSRule>
</CORSConfiguration>
```

Substitute `$SITE_FQDN` with your actual site FQDN, including protocol
(`http://`, `https://`) and port number, if one is used.

In development you will probably want to use `http://localhost:5000` to allow
requests from your local dev server.

You can add additional `<AllowedOrigin>` lines if needed.

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

### Staging Environment

Visit the stage build at http://eastbaydsa-staging.herokuapp.com to test your changes.

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

### Updating your DB

After pulling main, if you notice changes to `db/schema.rb`, run

```bash
bundle exec rake db:migrate
```

If this command fails, try running `bundle`, and then retry the above command.

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
