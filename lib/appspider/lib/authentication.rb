require 'appspider/base'
module Appspider
  module Api
    class Authentication < Appspider::Api::Base
      # Authentication Options
      AUTHENTICATION = '/Authentication/Login'
      def self.login(nto_ent_rest_url,username,password)
        raise StandardError, "Invalid Appspider url" if nto_ent_rest_url.to_s.empty?
        raise StandardError, "Invalid Username" if username.to_s.empty?
        raise StandardError, "Invalid Password" if password.to_s.empty?
        params = {
            username: username,
            password: password
        }
        api_call = "#{nto_ent_rest_url}#{AUTHENTICATION}"
        post(api_call,params)
      end
    end
  end
end
