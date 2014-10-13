# @author Karl Sutt
class Juicer

  attr_reader :api_key

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
    @api_key = api_key
  end

  def sites
  end

  def sections
  end

  def products
  end

  def formats
  end

  def article(cps_id)
  end

  def articles(opts)
  end

  private

  def make_request
    
  end
end
