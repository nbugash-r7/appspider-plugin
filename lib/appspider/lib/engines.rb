require 'appspider/lib/base'
module Appspider
  module Api
    class Engines < Appspider::Api::Base
      # Engines
      GETSCANENGINES = '/Engine/GetScanEngines' # Implemented
      # TODO: CREATESCANENGINE    = nil
      SAVEENGINE = '/Engine/SaveEngine' # Implemented
      DELETESCANENGINE = '/Engine/DeleteScanEngines' # Implemented

      # @params = {
      #   nto_ent_rest_url: nto_ent_rest_url,
      #   auth_token: auth_token
      # }
      def self.get_scan_engines(rest_api_url,auth_token)
        api_call = "#{rest_api_url}#{GETSCANENGINES}"
        params = {auth_token:auth_token }
        get(api_call,params)
      end

      #@params = {
      #  nto_ent_rest_url: nto_ent_rest_url,
      #  auth_token: auth_token,
      #  id: id,
      #  url: url,
      #  virtualName: virtual_name,
      #  login: login,
      #  password: password,
      #  notes: notes,
      #  doNotUpdate: do_not_update
      #}
      def self.save_engine(rest_api_url, auth_token, params = {})
        raise StandardError, "'id' was not provided" if params[:id].to_s.empty?
        raise StandardError, "'url' was not provided" if params[:url].to_s.empty?
        raise StandardError, "'virtualName' was not provided" if params[:virtualName].to_s.empty?
        raise StandardError, "'login' was not provided" if params[:login].to_s.empty?
        raise StandardError, "'password' was not provided" if params[:password].to_s.empty?
        raise StandardError, "'notes' was not provided" if params[:notes].to_s.empty?
        raise StandardError, "'doNotUpdate' was not provided" if params[:doNotUpdate].to_s.empty?
        api_call = "#{rest_api_url}#{SAVEENGINE}"
        params[:auth_token] = auth_token
        post(api_call, params)
      end

      # @params = {
      #   id: id
      #   auth_token: auth_token
      # }
      def self.delete_scan_engine(rest_api_url, auth_token, params = {})
        raise StandardError, "'id' was not provided" if params[:id].to_s.empty?
        api_call = "#{rest_api_url}#{DELETESCANENGINE}"
        params[:auth_token] = auth_token
        post(api_call, params)
      end
    end
  end
end