require 'spec_helper'

describe Juicer::Client do
  let(:client) { described_class.new(api_key) }
  let(:api_key) { "123ABC" }

  describe "#initialize" do
    it "sets the API key" do
      expect(client.api_key).to equal(api_key)
    end
  end

  describe "#api_url" do
    it "drops forward slash" do
      url = client.send(:api_url, "/foobar")
      expect(url).to eq("http://data.bbc.co.uk/bbcrd-juicer/foobar.json")
    end

    it "drops trailing slash" do
      url = client.send(:api_url, "foobar/")
      expect(url).to eq("http://data.bbc.co.uk/bbcrd-juicer/foobar.json")
    end

    it "drops slashes front and back" do
      url = client.send(:api_url, "//foobar/hello/me//")
      expect(url).to eq("http://data.bbc.co.uk/bbcrd-juicer/foobar/hello/me.json")
    end
  end

  describe "#make_request" do
    context "HTTP verb handling" do
      before do
        stub_request(:get, "http://data.bbc.co.uk/bbcrd-juicer/foobar.json")
          .with(query: { apikey: api_key })
          .to_return(body: { foobar: "ok" }.to_json)
      end

      it "constructs the request correctly" do
        response = client.request(:get, "foobar")
        expect(response).to be_an_instance_of(Hash)
      end

      it "throws exception on invalid verb" do
        expect { client.request(:invalid, "doesn't matter") }.to raise_error
      end
    end

    context "params handling" do
      before do
        stub_request(:get, "http://data.bbc.co.uk/bbcrd-juicer/foobar.json")
          .with(query: hash_including({ products: ["NewsWeb", "TheGuardian"] }))
          .to_return(body: { foobar: "ok" }.to_json)
      end
      it "constructs the request correctly" do
        response = client.request(:get, "foobar", { products: ["NewsWeb", "TheGuardian"] })
        expect(response).to be_an_instance_of(Hash)
      end
    end
  end
end
