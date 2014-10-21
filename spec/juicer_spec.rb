require 'spec_helper'

describe Juicer do
  let(:juicer) { Juicer.new(api_key) }
  let(:api_key) { "123ABC" }

  describe "#initialize" do
    it "creates a HTTP client" do
      expect(juicer.client).to be_an_instance_of(Juicer::Client)
    end
  end

  describe "#sites" do
    let(:body) { { "sites" => ["site1", "site2", "site3"] } }
    before do
      stub_request(:get, "http://data.bbc.co.uk/bbcrd-juicer/sites.json")
        .with(query: { apikey: api_key })
        .to_return(body: body.to_json)
    end

    it "queries the `sites` endpoint" do
      response = juicer.sites
      expect(response).to eq(body["sites"])
    end
  end

  describe "#sections" do
    let(:body) { { "sections" => ["section1", "section2", "section3"] } }
    before do
      stub_request(:get, "http://data.bbc.co.uk/bbcrd-juicer/sections.json")
        .with(query: { apikey: api_key })
        .to_return(body: body.to_json)
    end

    it "queries the `sections` endpoint" do
      response = juicer.sections
      expect(response).to eq(body["sections"])
    end
  end

  describe "#products" do
    let(:body) { { "products" => ["product1", "product2", "product3"] } }
    before do
      stub_request(:get, "http://data.bbc.co.uk/bbcrd-juicer/products.json")
        .with(query: { apikey: api_key })
        .to_return(body: body.to_json)
    end

    it "queries the `products` endpoint" do
      response = juicer.products
      expect(response).to eq(body["products"])
    end
  end

  describe "#formats" do
    let(:body) { { "formats" => ["format1", "format2", "format3"] } }
    before do
      stub_request(:get, "http://data.bbc.co.uk/bbcrd-juicer/formats.json")
        .with(query: { apikey: api_key })
        .to_return(body: body.to_json)
    end

    it "queries the `formats` endpoint" do
      response = juicer.formats
      expect(response).to eq(body["formats"])
    end
  end

  describe "#articles" do
    let(:body) do
      { "articles" => [{"title" => "Article title 1" },
                       {"title" => "Article title 2" },
                       {"title" => "Article title 3" }] }
    end

    before do
      stub_request(:get, "http://data.bbc.co.uk/bbcrd-juicer/articles.json")
        .with(query: {
                apikey: api_key,
                text: "London",
                product: ["TheGuardian", "NewsWeb"],
                content_format: ["TextualFormat"],
                published_after: "2014-09-13",
                published_before: "2014-10-13" })
        .to_return(body: body.to_json)
    end

    it "queries the `articles` endpoint" do
      response = juicer.articles(text: "London",
                                 product: ["TheGuardian", "NewsWeb"],
                                 content_format: ["TextualFormat"],
                                 published_after: "2014-09-13",
                                 published_before: "2014-10-13")
      expect(response).to eq(body["articles"])
    end
  end

  describe "#article" do
    let(:body) do
      { "article" => { "title" => "Article title" } }
    end
    let(:cps_id) { "ABCD1234" }

    before do
      stub_request(:get, "http://data.bbc.co.uk/bbcrd-juicer/articles/#{cps_id}.json")
        .with(query: { apikey: api_key })
        .to_return(body: body.to_json)
    end

    it "queries the `article` endpoint" do
      response = juicer.article(cps_id)
      expect(response).to eq(body["article"])
    end
  end

  describe "#similar_articles" do
    let(:body) do
      { "results" => [{ "title" => "Article title 1" },
                      { "title" => "Article title 2" }] }
    end
    let(:cps_id) { "ABCD1234" }

    before do
      stub_request(:get, "http://data.bbc.co.uk/bbcrd-juicer/articles/#{cps_id}/similar.json")
        .with(query: { apikey: api_key })
        .to_return(body: body.to_json)
      stub_request(:get, "http://data.bbc.co.uk/bbcrd-juicer/articles/#{cps_id}/similar.json")
        .with(query: { apikey: api_key, size: 5 })
        .to_return(body: body.to_json)
      stub_request(:get, "http://data.bbc.co.uk/bbcrd-juicer/articles/#{cps_id}/similar.json")
        .with(query: { apikey: api_key, product: ["NewsWeb"] })
        .to_return(body: body.to_json)
    end

    it "queries the `similar` endpoint with defaults" do
      response = juicer.similar_articles(cps_id)
      expect(response).to eq(body["results"])
    end

    it "queries the `similar` endpoint with `size`" do
      response = juicer.similar_articles(cps_id, size: 5)
      expect(response).to eq(body["results"])
    end

    it "queries the `similar` endpoint with `product`" do
      response = juicer.similar_articles(cps_id, product: ["NewsWeb"])
      expect(response).to eq(body["results"])
    end
  end

  describe "#similar_to" do
    let(:body) do
      { "results" => [{ "title" => "Article title 1" },
                      { "title" => "Article title 2" }] }
    end
    let(:text) { "Some cool text here" }

    before do
      stub_request(:post, "http://data.bbc.co.uk/bbcrd-juicer/similar_to.json")
        .with(query: { apikey: api_key },
              body: { like_text: URI.encode(text) }.to_json)
        .to_return(body: body.to_json)
      stub_request(:post, "http://data.bbc.co.uk/bbcrd-juicer/similar_to.json")
        .with(query: { apikey: api_key, size: 5 },
              body: { like_text: URI.encode(text) }.to_json)
        .to_return(body: body.to_json)
      stub_request(:post, "http://data.bbc.co.uk/bbcrd-juicer/similar_to.json")
        .with(query: { apikey: api_key, product: ["NewsWeb"] },
              body: { like_text: URI.encode(text) }.to_json)
        .to_return(body: body.to_json)
    end

    it "queries the `similar_to` endpoint with defaults" do
      response = juicer.similar_to(text)
      expect(response).to eq(body["results"])
    end

    it "queries the `similar_to` endpoint with `size`" do
      response = juicer.similar_to(text, size: 5)
      expect(response).to eq(body["results"])
    end

    it "queries the `similar_to` endpoint with `product`" do
      response = juicer.similar_to(text, product: ["NewsWeb"])
      expect(response).to eq(body["results"])
    end
  end
end
