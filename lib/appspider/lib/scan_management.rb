require 'appspider/lib/base'
module Appspider
  module Api
    class ScanManagement < Appspider::Api::Base

      # Scan Management
      GETSCANS = '/Scan/GetScans'             # Implemented
      RUNSCAN = '/Scan/RunScan'               # Implemented
      CANCELSCAN = '/Scan/CancelScan'         # Implemented
      PAUSESCAN = '/Scan/PauseScan'           # Implemented
      RESUMESCAN = '/Scan/ResumeScan'         # Implemented
      PAUSEALLSCANS = '/Scan/PauseAllScans'   # Implemented
      STOPALLSCANS = '/Scan/StopAllScans'     # Implemented
      RESUMEALLSCANS = '/Scan/ResumeAllScans' # Implemented
      CANCELALLSCANS = '/Scan/CancelAllScans' # Implemented
      GETSCANSTATUS = '/Scan/GetScanStatus'   # Implemented
      ISSCANACTIVE = '/Scan/IsScanActive'     # Implemented
      ISSCANFINISHED = '/Scan/IsScanFinished' # Implemented
      HASREPORT = '/Scan/HasReport'           # Implemented
      GETSCANERRORS = '/Scan/GetScanErrors'   # Implemented


      # Scan Management
      def self.get_scans(rest_api_url, auth_token)
        api_call = "#{rest_api_url}#{GETSCANS}"
        params = {auth_token: auth_token}
        get(api_call, params)
      end

      def self.run_scan(rest_api_url, auth_token, params = {})
        raise StandardError, "'configId' was not specified in the parameters. Set params[:configId]" if params[:configId].to_s.empty?
        api_call = "#{rest_api_url}#{RUNSCAN}"
        params[:auth_token] = auth_token
        post(api_call, params)
      end

      def self.cancel_scan(rest_api_url, auth_token,params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call = "#{rest_api_url}#{CANCELSCAN}"
        params[:auth_token] = auth_token
        post(api_call, params)
      end

      def self.pause_scan(rest_api_url, auth_token,params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call = "#{rest_api_url}#{PAUSESCAN}"
        params[:auth_token] = auth_token
        post(api_call, params)
      end

      def self.resume_scan(rest_api_url, auth_token,params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call = "#{rest_api_url}#{RESUMESCAN}"
        params[:auth_token] = auth_token
        post(api_call, params)
      end

      def self.pause_all_scans(rest_api_url, auth_token)
        api_call = "#{rest_api_url}#{PAUSEALLSCANS}"
        params = { auth_token:auth_token }
        post(api_call, params)
      end

      def self.stop_all_scans(rest_api_url, auth_token)
        api_call = "#{rest_api_url}#{STOPALLSCANS}"
        params = { auth_token:auth_token }
        post(api_call, params)
      end

      def self.resume_all_scans(rest_api_url, auth_token)
        api_call = "#{rest_api_url}#{RESUMEALLSCANS}"
        params = { auth_token:auth_token }
        post(api_call, params)
      end

      def self.cancel_all_scans(rest_api_url, auth_token)
        api_call = "#{rest_api_url}#{CANCELALLSCANS}"
        params = { auth_token:auth_token }
        post(api_call, params)
      end

      def self.get_scan_status(rest_api_url, auth_token, params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call = "#{rest_api_url}#{GETSCANSTATUS}"
        params[:auth_token] = auth_token
        get(api_call, params)
      end

      def self.is_scan_active?(rest_api_url, auth_token, params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call = "#{rest_api_url}#{ISSCANACTIVE}"
        params[:auth_token] = auth_token
        response = get(api_call, params)
        # TODO: Return the value of response[:Result]
        return true if response[:Result].to_s.match 'true' and not response.nil?
        false
      end


      def self.is_scan_finised?(rest_api_url, auth_token, params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call = "#{rest_api_url}#{ISSCANFINISHED}"
        params[:auth_token] = auth_token
        response = get(api_call, params)
        # TODO: Return the value of response[:Result]
        return true if response[:Result].to_s.match 'true' and not response.nil?
        false
      end

      def self.has_report?(rest_api_url, auth_token,params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call = "#{rest_api_url}#{HASREPORT}"
        params[:auth_token] = auth_token
        response = get(api_call, params)
        # TODO: Return the value of response[:Result]
        return true if response[:Result].to_s.match 'true' and not response.nil?
        false
      end

      def self.get_scan_errros(rest_api_url, auth_token,params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call = "#{rest_api_url}#{GETSCANERRORS}"
        params[:auth_token] = auth_token
        response = get(api_call, params)
        # TODO: Return the value of response[:Result]
        response
      end
    end
  end
end