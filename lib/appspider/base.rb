require 'rest-client'
require 'json'
module Appspider
  module Api
    class Base
      def post(api_call,params={})
        auth_token = params[:auth_token]
        if auth_token
          # User is not yet authenticated
          response = RestClient::Request.execute(
                        method:   :post,
                        url:      api_call,
                        headers:  {
                            Authorization: "Basic #{auth_token}"
                        },
                        payload: params
          )
        else
          # Need to be authenticated
          response = RestClient::Request.execute(
                       method:  :post,
                       url:     api_call,
                       payload: params
          )
        end
        JSON.parse(response, symbolize_names: true)
      end

      def get

      end
    end
  end
end