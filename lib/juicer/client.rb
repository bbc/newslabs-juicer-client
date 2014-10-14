# @author Karl Sutt

require 'httpi'
require 'json'

class Juicer
  class Client
    # Use HTTPI's nested query builder, which builds the query string in the
    # "correct" format for Rails, i.e param[]=foo&param[]=bar.
    # See https://github.com/savonrb/httpi/pull/126
    HTTPI.query_builder = :nested

    BASE_PATH = "http://data.bbc.co.uk/bbcrd-juicer"

    # @return [String] API key
    #
    attr_reader :api_key

    # Initialize HTTP client
    #
    # @param api_key [String] the API key from Apigee
    # @return [Juicer::Client] HTTP client instance
    #
    def initialize(api_key)
      @api_key = api_key
    end

    # Internal method for constructing API calls to the Juicer public facing
    # API. Automatically handles the API key when provided.
    #
    # @note Internal method, should not be used directly! See {Juicer} docs
    #   instead.
    # @note The Juicer API currently only supports `:get` and `:post` values for
    #   the `method` param.
    # @param method [Symbol] HTTP method.
    # @param path [String] an endpoint path
    # @param query_params [Hash] a hash of query parameters. List values are
    #   handled "correctly" in the sense that values of [Array] type produce
    #   `key[]=foo&key[]=bar` style values, suitable for Rails.
    # @param body [String] body of the request. Makes sense for POST requests.
    # @return [Hash, Array<Hash>] either a list of results or one result.
    #
    def request(method, path, query_params = {}, body = nil)
      req                         = HTTPI::Request.new
      req.url                     = api_url(path)
      req.query                   = { apikey: api_key }.merge(query_params)
      req.body                    = body if body
      req.headers["Accept"]       = "application/json"
      req.headers["Content-Type"] = "application/json"
      JSON.parse(HTTPI.request(method, req).body)
    end

    private

    # Small helper method for sanitizing the `path` for `request` method.
    #
    # @param path [String] a path to an endpoint
    # @return [String] sanitized and fully constructed endpoint URL
    #
    def api_url(path)
      path.sub!(/^\/+/, '')
      path.sub!(/\/+$/, '')
      "#{BASE_PATH}/#{path}.json"
    end
  end
end
