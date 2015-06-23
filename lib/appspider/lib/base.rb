require 'rest-client'
require 'json'
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
        auth_token = params.delete(:auth_token) # POP the auth_token
        JSON.parse(
          RestClient::Request.execute(
            method:   :get,
            url:      api_call,
            headers:  {
              Authorization:  "Basic #{auth_token.to_s}",
              params: params
            }
          )
        )
      end

      def self.get_api_call(rest_api_url, params = {})
        if params[:nto_ent_rest_url].to_s.empty?
          raise StandardError, "NTO URL was not set"
        end
        nto_ent_rest_url = params.delete(:nto_ent_rest_url)
        api_call = "#{nto_ent_rest_url}#{rest_api_url}"
        return api_call,params
      end
    end
  end
end