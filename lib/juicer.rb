# @author Karl Sutt
class Juicer

  attr_reader :client

  # Initialize the Juicer API client.
  #
  # == Parameters:
  # api_key::
  #   Your API key that you got from Apigee.
  #
  # == Returns:
  # The API client.
  #
  def initialize(api_key)
    @client = Juicer::Client.new(api_key)
  end

  def sites
    @client.request(:get, "sites")["sites"]
  end

  def sections
    @client.request(:get, "sections")["sections"]
  end

  def products
    @client.request(:get, "products")["products"]
  end

  def formats
    @client.request(:get, "formats")["formats"]
  end

  def articles(opts)
    @client.request(:get, "articles", opts)["articles"]
  end

  def article(cps_id)
    @client.request(:get, "articles/#{cps_id}")["article"]
  end

  def similar_articles(cps_id)
    @client.request(:get, "articles/#{cps_id}/similar")["results"]
  end

  def similar_to(text)
    body = { like_text: URI.encode(text) }.to_json
    @client.request(:post, "similar_to", {}, body)["results"]
  end
end
