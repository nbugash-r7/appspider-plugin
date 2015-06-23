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
      def self.login(params = {})
        raise StandardError, "Name parameter was not set" if params[:name].to_s.empty?
        raise StandardError, "Password parameter was not set" if params[:password].to_s.empty?
        api_call, params = get_api_call(AUTHENTICATION,params)
        post(api_call,params)
      end
    end
  end
end
