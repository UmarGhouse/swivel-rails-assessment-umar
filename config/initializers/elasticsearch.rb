Searchkick.client = Elasticsearch::Client.new(
  hosts: ["https://elastic:#{ENV['ELASTIC_PASSWORD']}@localhost:9200"],
  retry_on_failure: true, 
  transport_options: {
    request: {
      timeout: 250
    },
    ssl: {
      verify: false,
    }
  },
)
