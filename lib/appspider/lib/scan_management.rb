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
      def self.get_scans(params = {})
        api_call, params = get_api_call(GETSCANS,params)
        get(api_call, params)
      end

      def self.run_scan(params = {})
        raise StandardError, "'configId' was not specified in the parameters. Set params[:configId]" if params[:configId].to_s.empty?
        api_call, params = get_api_call(RUNSCAN,params)
        post(api_call, params)
      end

      def self.cancel_scan(params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call, params = get_api_call(CANCELSCAN,params)
        post(api_call, params)
      end

      def self.pause_scan(params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call, params = get_api_call(PAUSESCAN,params)
        post(api_call, params)
      end

      def self.resume_scan(params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call, params = get_api_call(RESUMESCAN,params)
        post(api_call, params)
      end

      def self.pause_all_scans(params = {})
        api_call, params = get_api_call(PAUSEALLSCANS,params)
        post(api_call, params)
      end

      def self.stop_all_scans(params = {})
        api_call, params = get_api_call(STOPALLSCANS,params)
        post(api_call, params)
      end

      def self.resume_all_scans(params = {})
        api_call, params = get_api_call(RESUMEALLSCANS,params)
        post(api_call, params)
      end

      def self.cancel_all_scans(params = {})
        api_call, params = get_api_call(CANCELALLSCANS,params)
        post(api_call, params)
      end

      def self.get_scan_status(params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call, params = get_api_call(GETSCANSTATUS,params)
        get(api_call, params)
      end

      def self.is_scan_active?(params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call, params = get_api_call(ISSCANACTIVE,params)
        response = get(api_call, params)
        # TODO: Return the value of response[:Result]
        return true if response[:Result].to_s.match 'true' and not response.nil?
        false
      end


      def self.is_scan_finised?(params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call, params = get_api_call(ISSCANFINISHED,params)
        response = get(api_call, params)
        # TODO: Return the value of response[:Result]
        return true if response[:Result].to_s.match 'true' and not response.nil?
        false
      end

      def self.has_report?(params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call, params = get_api_call(HASREPORT,params)
        response = get(api_call, params)
        # TODO: Return the value of response[:Result]
        return true if response[:Result].to_s.match 'true' and not response.nil?
        false
      end

      def self.get_scan_errros(params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call, params = get_api_call(GETSCANERRORS,params)
        response = get(api_call, params)
        # TODO: Return the value of response[:Result]
        response
      end
    end
  end
end