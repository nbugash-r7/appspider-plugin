require 'rest-client'
require 'json'
require 'nokogiri'
module Appspider
  module Api
    class Base
      def self.post(api_call,params={})
        if params[:auth_token].to_s.empty?
          # Need to be authenticated
          response = RestClient::Request.execute(
              method:  :post,
              url:     api_call,
              payload: params
          )
        else
          # User is authenticated
          auth_token = params.delete(:auth_token) # POP the auth_token
          response = RestClient::Request.execute(
              method:   :post,
              url:      api_call,
              headers:  {
                  Authorization: "Basic #{auth_token.to_s}"
              },
              payload: params
          )
        end
        JSON.parse(response, symbolize_names: true)
      end

      def self.get(api_call, params = {})
        raise StandardError, "Invalid authorization token" if params[:auth_token].to_s.empty?
        type = 'XML' if not params[:type].to_s.empty? and params[:type].to_s.downcase == 'xml'
        auth_token = params.delete(:auth_token) # POP the auth_token
        response = RestClient::Request.execute(
            method:   :get,
            url:      api_call,
            headers:  {
              Authorization:  "Basic #{auth_token.to_s}",
              params: params
            }
          )
        if type == 'XML'
          return Nokogiri::XML(response)
        else
          return JSON.parse(response, symbolize_names: true)
        end
      end

    end
  end
end