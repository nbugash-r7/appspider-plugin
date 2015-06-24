require_relative 'api_v1'
module Appspider
    class ApiExtended
      attr_accessor :build ,
                    :launcher,
                    :listener,
                    :publisher

      def initialize(build, listener, publisher)
        # @build = options[:build]
        # @launcher = options[:launcher]
        # @listener = options[:listener]
        @build = build
        @listener = listener
        @api_ext = publisher
      end

      def self.get_all_scans(options = {})
        appspider_instance = Appspider::Api.new(options)
        all_configs ||= []
        appspider_instance.get_configs[:Configs].each do |config|
          all_configs << config[:Name]
        end
        all_configs
      end

      def self.get_all_scan_status(options = {})
        appspider_instance = Appspider::Api.new(options)
        all_scans = appspider_instance.get_scans
        scans = all_scans[:Scans]
        all_scans_status ||= {}
        scans.each do |scan|
          status = (appspider_instance.get_scan_status scan[:Id])[:Status].to_s.to_sym
          if all_scans_status[status].nil?
            all_scans_status[status] ||= []
          end
          all_scans_status[status] << scan[:Id]
        end
        all_scans_status
      end

      def self.run_scan_config(options = {})
        raise StandardError, "Config name is not specified" if options[:config_name].to_s.empty?
        config_name = options[:config_name]
        appspider_instance = Appspider::Api.new(options)
        appspider_instance.get_configs[:Configs].each do |config|
          if config[:Name].to_s.match config_name
            appspider_instance.run_scan config[:Id]
            return true
          end
        end
        false
      end

      # @returns all the scan ids of the specified status
      # @usage:
      # get_scan_status_of({
      #   url: <url>,
      #   username: <username>,
      #   password: <password>.
      #   status: <status>#
      # })#
      def self.get_scan_status_of(options = {})
        raise StandardError, "Need to specify the status" if options[:status].to_s.empty?
        status = options[:status].to_s.to_sym
        all_scans_status = get_all_scan_status(options)
        all_scans_status[status]
      end

    end
end
