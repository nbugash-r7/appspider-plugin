require 'appspider/lib/base'
module Appspider
  module Api
    class EngineGroup < Appspider::Api::Base
      # EngineGroup
      GETALLENGINEGROUPS       = '/EngineGroup/GetAllEngineGroups'       # Implemented
      GETENGINEGROUPSFORCLIENT = '/EngineGroup/GetEngineGroupsForClient' #
      SAVEENGINEGROUP          = '/EngineGroup/SaveEngineGroup'          # Implemented
      DELETESCANENGINEGROUP    = '/EngineGroup/DeleteScanEngineGroup'    #
      ADDENGINETOGROUP         = '/EngineGroup/AddEngineToGroup'         #
      DELETEENGINEFROMGROUP    = '/EngineGroup/DeleteEngineFromGroup'    #

      def self.get_all_engine_groups(rest_api_url,auth_token)
        params = { auth_token: auth_token }
        api_call = "#{rest_api_url}#{GETALLENGINEGROUPS}"
        get(api_call, params)
      end

      def self.save_engine_group(rest_api_url,auth_token, params = {})
        raise StandardError,"'id' was not specified in the parameters" if params[:id].to_s.empty?
        raise StandardError,"'name' was not specified in the parameters" if params[:name].to_s.empty?
        raise StandardError,"'description' was not specified in the parameters" if params[:description].to_s.empty?
        raise StandardError,"'monitoring' was not specified in the parameters" if params[:monitoring].to_s.empty?
        api_call = "#{rest_api_url}#{GETSCANENGINES}"
        params[:auth_token] = auth_token
        post(api_call, params)
      end
    end
  end
end