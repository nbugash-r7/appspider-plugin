require 'appspider/lib/base'
module Appspider
  module Api
    class ScanConfiguration < Appspider::Api::Base
      # Scan Configuration Options
      SAVECONFIG     = '/Config/SaveConfig'     #
      DELTECONFIGS   = '/Config/DeleteConfigs'  #
      GETCONFIGS     = '/Config/GetConfigs'     #  Implemented
      GETSCANCONFIG  = '/Config/GetScanConfig'  #
      GETATTACHMENT  = '/Config/GetAttachment'  #
      GETATTACHMENTS = '/Config/GetAttachments' #

      # @params ={
      #   nto_ent_rest_url:nto_ent_rest_url,
      #   auth_token: auth_token
      # }
      def self.get_configs(params = {})
        api_call, params = get_api_call(GETCONFIGS,params)
        get(api_call, params)
      end

      def self.get_scan_config(params = {})
        if params[:id].to_s.empty?
          raise StandardError, "'id' is not specified in the parameters. Set params[:id]"
        end
        api_call, params = get_api_call(GETSCANCONFIG,params)
        get(api_call, params)
      end
    end
  end
end