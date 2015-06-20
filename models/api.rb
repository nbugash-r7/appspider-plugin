require 'net/http'
require 'rest-client'
require 'json'
require 'openssl'
module Appspider

  class Api

    attr_accessor :url
    attr_accessor :auth_token


    # Authentication Options
    AUTHENTICATION = '/Authentication/Login'

    # Engines
    GETSCANENGINES = '/Engine/GetScanEngines' # Implemented
    # TODO:
    # CREATESCANENGINE    = nil
    SAVEENGINE = '/Engine/SaveEngine' # Implemented
    DELETESCANENGINE = '/Engine/DeleteScanEngines' # Implemented


    # EngineGroup
    GETALLENGINEGROUPS = '/EngineGroup/GetAllEngineGroups' # Implemented
    GETENGINEGROUPSFORCLIENT = '/EngineGroup/GetEngineGroupsForClient' #
    SAVEENGINEGROUP = '/EngineGroup/SaveEngineGroup' # Implemented
    DELETESCANENGINEGROUP = '/EngineGroup/DeleteScanEngineGroup'
    ADDENGINETOGROUP = '/EngineGroup/AddEngineToGroup'
    DELETEENGINEFROMGROUP = '/EngineGroup/DeleteEngineFromGroup'

    # Scan Configuration Options
    SAVECONFIG = '/Config/SaveConfig' #
    DELTECONFIGS = '/Config/DeleteConfigs' #
    GETCONFIGS = '/Config/GetConfigs' #  Implemented
    GETSCANCONFIG = '/Config/GetScanConfig' #
    GETATTACHMENT = '/Config/GetAttachment' #
    GETATTACHMENTS = '/Config/GetAttachments' #

    # Blackout Operations
    GETBLACKOUTS = '/Blackout/GetBlackouts' #
    SAVEBLACKOUT = '/Blackout/SaveBlackouts' #
    DELETEBLACKOUT = '/Blackout/DeleteBlackout' #

    # Scan Management
    GETSCANS = '/Scan/GetScans' # Implemented
    RUNSCAN = '/Scan/RunScan'
    CANCELSCAN = '/Scan/CancelScan' # Implemented
    PAUSESCAN = '/Scan/PauseScan' # Implemented
    RESUMESCAN = '/Scan/ResumeScan' # Implemented
    PAUSEALLSCANS = '/Scan/PauseAllScans' # Implemented
    STOPALLSCANS = '/Scan/StopAllScans' # Implemented
    RESUMEALLSCANS = '/Scan/ResumeAllScans' # Implemented
    CANCELALLSCANS = '/Scan/CancelAllScans' # Implemented
    GETSCANSTATUS = '/Scan/GetScanStatus' # Implemented
    ISSCANACTIVE = '/Scan/IsScanActive' # Implemented
    ISSCANFINISHED = '/Scan/IsScanFinished' # Implemented
    HASREPORT = '/Scan/HasReport' # Implemented
    GETSCANERRORS = '/Scan/GetScanErrors' # Implemented


    def initialize(options = {})
      @build = options[:build]
      @launcher = options[:launcher]
      @listener = options[:listener]
      raise StandardError, "Invalid AppSpider Url" if options[:url].to_s.empty?
      raise StandardError, "Invalid username" if options[:username].to_s.empty?
      raise StandardError, "Invalid password" if options[:password].to_s.empty?
      @url = options[:url].to_s
      response = authentication_login(options[:username].to_s, options[:password].to_s)
      raise StandardError, "Invalid authentication." unless response[:IsSuccess].to_s.match /true/
      @auth_token = response[:Token]
    end

    # @params: username and password
    # @return: authentication token
    def authentication_login(username, password)
      params = {
          name: username,
          password: password
      }
      post(AUTHENTICATION, params)
    end

    # Engines
    def get_scan_engines
      get(GETSCANENGINES)
    end

    # TODO:
    # Implement the create_scan_engine method
    # def create_scan_engine()
    #
    # end

    def save_engine(id, url, virtual_name, login, password, notes, do_not_update)
      params = {
          id: id,
          url: url,
          virtualName: virtual_name,
          login: login,
          password: password,
          notes: notes,
          doNotUpdate: do_not_update
      }
      post(SAVEENGINE, params)
    end

    def delete_scan_engine(id)
      params = {
          id: id
      }
      post(DELETESCANENGINE, params)
    end

    # Engine Groups
    def get_all_engine_groups
      get(GETALLENGINEGROUPS)
    end

    def save_engine_group(id, name, description, monitoring)
      params = {
          id: id,
          name: name,
          description: description,
          monitoring: monitoring
      }
      post(SAVEENGINEGROUP, params)
    end

    # Scan Configuration
    def get_configs
      get(GETCONFIGS)
    end

    # Scan Management
    def get_scans
      get(GETSCANS)
    end

    def run_scan(config_id)
      params = {
          configId: config_id # Scan config ID
      }
      post(RUNSCAN, params)
    end

    def cancel_scan(scan_id)
      params = {
          scanId: scan_id
      }
      post(CANCELSCAN, params)
    end

    def pause_scan(scan_id)
      params = {
          scanId: scan_id
      }
      post(PAUSESCAN, params)
    end

    def resume_scan(scan_id)
      params = {
          scanId: scan_id
      }
      post(RESUMESCAN, params)
    end

    def pause_all_scans
      post(PAUSEALLSCANS)
    end

    def stop_all_scans
      post(STOPALLSCANS)
    end

    def resume_all_scans
      post(RESUMEALLSCANS)
    end

    def cancel_all_scans
      params(CANCELALLSCANS)
    end

    def get_scan_status(scan_id)
      params = {
          scanId: scan_id
      }
      get(GETSCANSTATUS, params)
    end

    def is_scan_active?(scan_id)
      params = {
          scanId: scan_id
      }
      response = get(ISSCANACTIVE, params)
      # TODO:
      # Return the value of response[:Result]
      return true if response[:Result].to_s.match 'true' and not response.nil?
      false
    end


    def is_scan_finised?(scan_id)
      params = {
          scanId: scan_id
      }
      response = get(ISSCANFINISHED, params)
      return true if not respose.nil? and response[:Result].to_s.match 'true'
      false
    end

    def has_report?(scan_id)
      params = {
          scanId: scan_id
      }
      response = get(HASREPORT, params)
      return true if not response.nil? and response[:Result].to_s.match 'true'
      false
    end

    def get_scan_errros(scan_id)
      params = {
          scanId: scan_id
      }
      get(GETSCANERRORS, params)
      # TODO: Handle Response code 400 (InvalidJSONSchema, ScanNotFound, ScanIsNotAllowed)
    end


    private
    def post(api_call, params = {})
      full_url = "#{@url}#{api_call}"
      params[:content]
      if @auth_token
        response = RestClient::Request.execute(
            method: :post,
            url: full_url,
            headers: {Authorization: "Basic #{@auth_token}"},
            payload: params
        )
      else
        # Not Authenticated
        response = RestClient::Request.execute(
            method: :post,
            url: full_url,
            payload: params
        )
      end
      JSON.parse(response, symbolize_names: true)
    end

    def get(api_call, params = {})
      JSON.parse(
          RestClient::Request.execute(
              method: :get,
              url: "#{@url}#{api_call}",
              headers: {
                  Authorization: "Basic #{@auth_token}",
                  params: params
              },
          ),
          symbolize_names: true
      )
    end

  end
end
