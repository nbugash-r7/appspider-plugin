require 'appspider/lib/base'
module Appspider
  module Api
    class Blackout < Appspider::Api::Base

      # Blackout Operations
      GETBLACKOUTS   = '/Blackout/GetBlackouts' #
      SAVEBLACKOUT   = '/Blackout/SaveBlackouts' #
      DELETEBLACKOUT = '/Blackout/DeleteBlackout' #

      def self.get_blackouts(params = {})
        api_call,params = get_api_call(GETBLACKOUTS,params)
        get(api_call,params)
      end

      def self.save_blackouts(params = {})
        raise StandardError, "'id' was not specifed in the parameters. Set params[:id]." if params[:id].to_s.empty?
        raise StandardError, "'name' was not specifed in the parameters. Set params[:name]." if params[:name].to_s.empty?
        raise StandardError, "'startTime' was not specifed in the parameters. Set params[:startTime]." if params[:startTime].to_s.empty?
        raise StandardError, "'stopTime' was not specifed in the parameters. Set params[:stopTime]." if params[:stopTime].to_s.empty?
        raise StandardError, "'targetHost' was not specifed in the parameters. Set params[:targetHost]." if params[:targetHost].to_s.empty?
        raise StandardError, "'isRecurring' was not specifed in the parameters. Set params[:isRecurring]." if params[:isRecurring].to_s.empty?
        raise StandardError, "'recurrence' was not specifed in the parameters. Set params[:recurrence]." if params[:recurrence].to_s.empty?
        api_call,params = get_api_call(SAVEBLACKOUT,params)
        post(api_call,params)
      end

      def self.delete_blackouts(params = {})
        raise StandardError, "'blackoutIds' was not specifed in the parameters. Set params[:blackoutIds]." if params[:blackoutIds].to_s.empty?
        api_call,params = get_api_call(DELETEBLACKOUT,params)
        post(api_call,params)
      end
    end
  end
end