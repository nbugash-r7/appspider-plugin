require 'appspider/lib/base'
module Appspider
  module Api
    class ReportManagement < Appspider::Api::Base

      IMPORTSTANDARDREPORT = "/Report/ImportStandardReport"
      IMPORTCHECKMARKREPORT= "/Report/ImportCheckmarkReport"
      GETREPORTALLFILES= "/Report/GetReportAllFiles"
      GETVULNERABILITIESSUMMARY= "/Report/GetVulnerabilitiesSummaryXml"
      GETCRAWLEDLINKS= "/Report/GetCrawledLinksXml"

      def self.import_standard_report(rest_api_url,auth_token,params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        raise StandardError, "'reportData' was not specified in the parameters. Set params[:scanId]" if params[:reportData].to_s.empty?
        raise StandardError, "'configId' was not specified in the parameters. Set params[:scanId]" if params[:configId].to_s.empty?
        api_call = "#{rest_api_url}#{IMPORTSTANDARDREPORT}"
        params[:auth_token] = auth_token
        port(api_call,params)
      end

      def self.import_checkmark_report(rest_api_url,auth_token,params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        raise StandardError, "'file' was not specified in the parameters. Set params[:file]" if params[:reportData].to_s.empty?
        api_call = "#{rest_api_url}#{IMPORTCHECKMARKREPORT}"
        params[:auth_token] = auth_token
        post(api_call, params)
      end

      def self.get_report_all_files(rest_api_url,auth_token,params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call = "#{rest_api_url}#{GETREPORTALLFILES}"
        params[:auth_token] = auth_token
        get(api_call,params)
      end

      def self.get_vul_summary_xml(rest_api_url,auth_token,params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call = "#{rest_api_url}#{GETVULNERABILITIESSUMMARY}"
        params[:auth_token] = auth_token
        params[:type] = 'xml'
        get(api_call,params)
      end

      def self.get_crawled_links_xml(rest_api_url,auth_token,params = {})
        raise StandardError, "'scanId' was not specified in the parameters. Set params[:scanId]" if params[:scanId].to_s.empty?
        api_call = "#{rest_api_url}#{GETCRAWLEDLINKS}"
        params[:auth_token] = auth_token
        params[:type] = 'xml'
        get(api_call,params)
      end

    end
  end
end