# Stack

- `Ruby 3.2.2`
- This project was generated as an API-only `Rails 7.1` application using `rails new ... --api`
- `PostgreSQL`

# Getting started

To get started, first install all dependencies:

    $ bundle install

Then create and migrate the database:

    $ rails db:create
    $ rails db:migrate

Finally, seed the database:

    $ rails db:seed


## ElasticSearch setup

The API is setup to use ElasticSearch (via the SearchKick gem) on all `#index` actions for each controller (Vertical, Category, Course).

In order for this to work appropriately, you will need to:

- Make sure you have ElasticSearch installed locally - [Instructions here](https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html)
- Make sure you have started the ElasticSearch server: `sudo systemctl start elasticsearch.service`
  - You can check that the server is running by following the nstructions found in the "Check that Elasticsearch is running" section of the ElasticSearch Docs. Example link for [MacOS / Linux](https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html#_check_that_elasticsearch_is_running).
- If needed, save the password to your `elastic` superuser to your environment variables for your current shell session: `export ELASTIC_PASSWORD="your-password"`
    - This password is required to make a secure connection to the ElasticSearch server - See `/config/initializers/elasticsearch.rb`

_Note: I have used the `ssl: {verify: false}` option in the initializer, as a [self-signed certificate](https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html#deb-repo) for local development caused errors on my development system (Windows 11 + WSL2)._

With all the above setup, you can run search queries on each `#index` route using the `?q=` query string. e.g.: `localhost:3000/categories?q=test`
