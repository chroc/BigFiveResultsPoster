# Sergio Rojas
# 19052017

require 'net/http'
require 'uri'
require 'json'

class BigFiveResultsPoster

  attr_accessor :results_hash, :response_code, :token

  def initialize (results_hash, email)
    @results_hash = results_hash
    @email = email
  end

  def post
    # posts a JSON representation of the result hash (as the request body) to
    # https://recruitbot.trikeapps.com/api/v1/roles/mid-senior-web-developer/big_five_profile_submissions

    @results_hash["EMAIL"] = @email

    uri = URI.parse("http://recruitbot.trikeapps.com/api/v1/roles/mid-senior-web-developer/big_five_profile_submissions")

    header = {'Content-Type': 'text/json'}

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = @results_hash.to_json
    # binding.pry

    # post the request
    response = http.request(request)

    if response.to_s.include? "HTTPCreated"
      @token = response.body.to_s
      return true
    else
      @response_code = "#{response.to_s} - #{response.body.to_s}"
      return false
    end
  end

end
