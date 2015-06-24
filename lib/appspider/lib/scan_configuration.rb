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
      def self.get_configs(rest_api_url,auth_token)
        api_call = "#{rest_api_url}#{GETCONFIGS}"
        params = { auth_token: auth_token }
        get(api_call, params)
      end

      def self.get_scan_config(rest_api_url, auth_token, params = {})
        raise StandardError, "'id' is not specified in the parameters. Set params[:id]" if params[:id].to_s.empty?
        api_call = "#{rest_api_url}#{GETSCANCONFIG}"
        params[:auth_token] = auth_token
        get(api_call, params)
      end
    end
  end
end