require 'appspider/api'
module Appspider
  module Api
    class Extended
      def self.get_all_scans(options = {})
        configs ||= []
        rest_api_url = options.delete(:rest_api_url)
        auth_token = options.delete(:auth_token)
        all_scans = Appspider::Api::ScanConfiguration.get_configs(rest_api_url,auth_token)
        all_scans[:Configs].each do |config|
          configs << config[:Name]
        end
        configs
      end

      def self.get_all_scan_status(options = {})
        rest_api_url = options.delete(:rest_api_url)
        auth_token = options.delete(:auth_token)
        all_scans = Appspider::Api::ScanManagement.get_scans(rest_api_url,auth_token)
        all_scan_status ||= {}
        all_scans[:Scans].each do |scan|
          params = { scanId: scan[:Id] }
          status = (Appspider::Api::ScanManagement.get_scan_status(rest_api_url,auth_token,params))[:Status]
          if all_scan_status[status.to_s.to_sym].nil?
            all_scan_status[status.to_s.to_sym] ||= []
          end
          all_scan_status[status.to_s.to_sym] << scan[:Id]
        end
        all_scan_status
      end

      def self.run_scan(options = {})
        rest_api_url = options.delete(:rest_api_url)
        auth_token = options.delete(:auth_token)
        raise StandardError, "Config name is not specified" if options[:config_name].to_s.empty?
        config_name = options[:config_name]
        configs = Appspider::Api::ScanConfiguration.get_configs(rest_api_url,auth_token)
        configs[:Configs].each do |config|
          if config[:Name].to_s.match /#{config_name}/i
            params = {
                configId: config[:Id]
            }
            Appspider::Api::ScanManagement.run_scan(rest_api_url, auth_token, params)
            return true
          end
        end
        false
      end

      def self.get_scan_status_of(options = {})
        status = options[:status].to_s.to_sym
        all_scan_status = get_all_scan_status(options)
        all_scan_status[status]
      end
    end
  end
end
