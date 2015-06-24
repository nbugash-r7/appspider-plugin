require 'appspider/lib/base'
module Appspider
  module Api
    class Blackout < Appspider::Api::Base

      # Blackout Operations
      GETBLACKOUTS   = '/Blackout/GetBlackouts' #
      SAVEBLACKOUT   = '/Blackout/SaveBlackouts' #
      DELETEBLACKOUT = '/Blackout/DeleteBlackout' #

      def self.get_blackouts(rest_api_url,auth_token)
        api_call = "#{rest_api_url}#{GETBLACKOUTS}"
        params = { auth_token: auth_token }
        get(api_call,params)
      end

      def self.save_blackouts(rest_api_url,auth_token,params = {})
        raise StandardError, "'id' was not specifed in the parameters." if params[:id].to_s.empty?
        raise StandardError, "'name' was not specifed in the parameters." if params[:name].to_s.empty?
        raise StandardError, "'startTime' was not specifed in the parameters." if params[:startTime].to_s.empty?
        raise StandardError, "'stopTime' was not specifed in the parameters." if params[:stopTime].to_s.empty?
        raise StandardError, "'targetHost' was not specifed in the parameters." if params[:targetHost].to_s.empty?
        raise StandardError, "'isRecurring' was not specifed in the parameters." if params[:isRecurring].to_s.empty?
        raise StandardError, "'recurrence' was not specifed in the parameters." if params[:recurrence].to_s.empty?
        api_call = "#{rest_api_url}#{SAVEBLACKOUT}"
        params[:auth_token] = auth_token
        post(api_call,params)
      end

      def self.delete_blackouts(rest_api_url,auth_token, params={})
        raise StandardError, "'blackoutIds' was not specifed in the parameters. Set params[:blackoutIds]." if params[:blackoutIds].to_s.empty?
        api_call = "#{rest_api_url}#{DELETEBLACKOUT}"
        params[:auth_token] = auth_token
        post(api_call,params)
      end
    end
  end
end