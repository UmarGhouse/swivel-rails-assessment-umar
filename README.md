# Stack

- `Ruby v3.2.2`
- This project was generated as an API-only `Rails v7.1` application using `rails new ... --api`
- `PostgreSQL`
- `ElasticSearch v7.14`

# Getting started

To get started, first install all dependencies:

    $ bundle install

Then create and migrate the database:

    $ rails db:create
    $ rails db:migrate

Finally, seed the database:

    $ rails db:seed

Seeding the database will create some dummy records for:
- Verticals
- Categories
- Courses
- A test application for OAuth access

All data can be accessed via the appropriate API endpoint. You can run `rails routes` for an overview of the routes.

All endpoints, except the sign-up and OAuth token endpoints, are protected by OAuth and require an `access_token` to be accessed.


## OAuth and User setup
In order to use the OAuth protected endpoints, you will need to create a User account and get an OAuth Token.

### Create a user
This API uses the `Devise` gem to handle authentication. To create a user, you can send a `POST` request to the registrations endpoint:

```ruby
# POST /user
{
    "user": {
        "email": "test@test.com",
        "password": "password",
        "password_confirmation": "password"
    }
}
```

### Get an OAuth Token
This API uses the `doorkeeper` gem to handle OAuth. 

In order to use these endpoints, you will need the `client_id` and `client_secret` of the OAuth application created in the seed file. For convenience, the seed file is setup to print these items to the console after the application is created.

<hr/>
<details>
  <summary>If you didn't use the seed file (Expand section for instructions)</summary>

  You can create a new OAuth application in the rails console (run `rails c` in your console) by:

  ```ruby
  Doorkeeper::Application.create(name: "Test client", redirect_uri: "", scopes: "")
  ```

  Thereafter, you can access the client ID and secret from the database:

  ```sql
  SELECT uid, secret FROM oauth_applications;
  ```

  > `uid` corresponds to `client_id` and `secret` corresponds to `client_secret`
</details>
<hr/>

To get an `access_token`, send a `POST` request to the OAuth Token endpoint, supplying the following information in the request body:

```ruby
# POST /oauth/token
{
  "grant_type": "password",
  "email": "test@test.com",
  "password": "password",
  "client_id": "V3wE4gxkmWtUyy8cXDT0iBUXkTt_-xFT_vtQZBafLOU",
  "client_secret": "t395egp4IfAETETV2BinlfCR3XzTXJGf3FFX_mp_wy4"
}
```

This uses the user's `email` and `password` to acquire a token.

Once the token expires (default of 2 hours), then we can use the refresh token flow to acquire a new token:

```ruby
# POST /oauth/token
{
  "grant_type": "refresh_token",
  "refresh_token": "witYDBQnRcU9f2ArgcB9sQ2yEgAXmTqGX41GkqE3jAQ",
  "client_id": "qtgCY46VupDSSbjqztD2zC1E0A2SOW2MtxJ9w4YlhXg",
  "client_secret": "tsq0GAEPfjxnpIpMZJB6ns4PDDq0yfyJOpGgZJAy4i8"
}
```


## ElasticSearch setup

The API is setup to use ElasticSearch (via the `SearchKick` gem) on all `#index` actions for each controller (Vertical, Category, Course).

In order for this to work appropriately, you will need to:

- Make sure you have ElasticSearch installed locally - [Instructions here](https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html)
- Make sure you have started the ElasticSearch server: For Linux systems use `sudo systemctl start elasticsearch.service`
  - Instructions for how to start the ElasticSearch server can be found in the same docs above.
  - You can check that the server is running by following the nstructions found in the "Check that Elasticsearch is running" section of the ElasticSearch Docs. Example link for [MacOS / Linux](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html#_check_that_elasticsearch_is_running).
- If not done already, save the password to your `elastic` superuser to your environment variables for your current shell session: `export ELASTIC_PASSWORD="your-password"`
    - This password is required to make a secure connection to the ElasticSearch server - See `/config/initializers/elasticsearch.rb`

_Note: I have used the `ssl: {verify: false}` option in the initializer, as a [self-signed certificate](https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html#deb-repo) for local development caused errors on my development system (Windows 11 + WSL2)._

With all the above setup, you can run search queries on each `#index` route using the `?q=` query string. e.g.: `localhost:3000/categories?q=test`
