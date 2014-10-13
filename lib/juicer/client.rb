require 'httpi'
require 'json'

class Juicer
  class Client
    # Use HTTPI's nested query builder, which builds the query string in the
    # "correct" format for Rails, i.e param[]=foo&param[]=bar.
    # See https://github.com/savonrb/httpi/pull/126
    HTTPI.query_builder = :nested

    BASE_PATH = "http://data.bbc.co.uk/bbcrd-juicer"

    attr_reader :api_key

    # Initialize HTTP client
    #
    # == Parameters:
    # api_key::
    #   API key from Apigee.
    #
    # == Returns:
    # HTTP client instance.
    #
    def initialize(api_key)
      @api_key = api_key
    end

    # Internal method for constructing requests
    #
    # == Parameters:
    # method::
    #   A valid HTTP method. One of :get, :post, :put, :delete.
    #   Note thet currently only :get and :post are supported by the Juicer API.
    # path::
    #   The `endpoint` to which to make the request.
    # query_params::
    #   Any query string params
    # params::
    #   Any params
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

    def api_url(path)
      path.sub!(/^\/+/, '')
      path.sub!(/\/+$/, '')
      "#{BASE_PATH}/#{path}.json"
    end
  end
end
