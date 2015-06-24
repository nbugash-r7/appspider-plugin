require 'appspider/lib/base'
module Appspider
  module Api
    class Authentication < Appspider::Api::Base
      # Authentication Options
      AUTHENTICATION = '/Authentication/Login'
      # @params = {
      #   nto_ent_rest_url: nto_ent_rest_url,
      #   name: name,
      #   password: password
      # }
      # @return: Return the authorization token
      def self.login(rest_api_url,name,password)
        raise StandardError, "Name parameter was not set" if name.to_s.empty?
        raise StandardError, "Password parameter was not set" if password.to_s.empty?
        api_call = "#{rest_api_url}#{AUTHENTICATION}"
        params = {
            name: name,
            password: password
        }
        response = post(api_call,params)
        response[:Token]
      end
    end
  end
end
