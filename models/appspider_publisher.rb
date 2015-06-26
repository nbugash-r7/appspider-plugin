require 'publisher'
# A single build step that run after the build is complete
class AppspiderPublisher < Jenkins::Tasks::Publisher

  display_name "Start Appspider Scan"

  attr_accessor :rest_api_url
  attr_accessor :username
  attr_accessor :password
  attr_accessor :config_name
  attr_accessor :startscan
  attr_accessor :monitor
  attr_accessor :save_file_to_location

  CHECK_INTERVAL = 120 # Check scan status every 'CHECK_INTERVAL' seconds
  SCAN_IN_PROGRESS_REGEX = /ing/i # Any status with '..ing' ending
  SCAN_COMPLETED = /completed/i

  # Invoked with the form parameters when this extension point
  # is created from a configuration screen.
  def initialize(attrs = {})
    @rest_api_url = attrs['rest_api_url']
    @username = attrs['username']
    @password = attrs['password']
    @config_name = attrs['config_name']
    @startscan = attrs['startscan']
    @monitor = attrs['monitor']
    @save_file_to_location = attrs['save_file_to_location']
  end

  ##
  # Runs before the build begins
  #
  # @param [Jenkins::Model::Build] build the build which will begin
  # @param [Jenkins::Model::Listener] listener the listener for this build.
  def prebuild(build, listener)
    # do any setup that needs to be done before this build runs.
  end

  ##
  # Runs the step over the given build and reports the progress to the listener.
  #
  # @param [Jenkins::Model::Build] build on which to run this step
  # @param [Jenkins::Launcher] launcher the launcher that can run code on the node running this build
  # @param [Jenkins::Model::Listener] listener the listener for this build.
  def perform(build, launcher, listener)
    # actually perform the build step
    # (1) Get build url for AppSpider to scan
    listener.info "AppSpider Url: '#{@rest_api_url}'"
    listener.info "Username: '#{@username}'"
    listener.info "Password: '[FILTERED]'"
    listener.info "Config name: '#{@config_name}'"
    listener.info "Start Scan: '#{@startscan}'"
    listener.info "Monitor Scan: '#{@monitor}'"
    listener.info "Report Location: '#{@save_file_to_location}'"

    if @startscan
      listener.info "Starting AppSpider Scan"
      # builder = Appsider::Publisher::MessageBuilderFactory.create(build.native)
      # message = builder.build_message
      auth_token = Appspider::Api::Authentication.login(@rest_api_url,@username,@password)
      run_scan_params = {
          rest_api_url: @rest_api_url,
          auth_token: auth_token,
          config_name: @config_name
      }
      listener.info "Scanning #{@config_name}..."
      response = Appspider::Api::Extended.run_scan run_scan_params
      if @monitor
        scanId = response[:Scan][:Id]
        scan_status = Appspider::Api::ScanManagement.get_scan_status(@rest_api_url,auth_token,{ scanId:scanId })
        status = scan_status[:Status]
        while status =~ SCAN_IN_PROGRESS_REGEX do
          listener.info "Status for #{@config_name} is '#{status}'"
          listener.info "Checking again in #{CHECK_INTERVAL} seconds."
          sleep CHECK_INTERVAL
          listener.info 'Renewing authentication token...'
          auth_token = Appspider::Api::Authentication.login(@rest_api_url,@username,@password)
          scan_status = Appspider::Api::ScanManagement.get_scan_status(@rest_api_url,auth_token,{ scanId:scanId })
          status = scan_status[:Status]
        end
        listener.info "Scan is finished!!!"
        # Scan is finished
        # (1) Wait until scanid status is complete
        unless status =~ SCAN_IN_PROGRESS_REGEX
          # (2) Get response of the results
          # P.O.C to see that the api works!!
          scanId = '9a9309e9-3ede-43a9-9edb-7fab5031003c'
          # End of P.O.C
          listener.info "Generating results."
          auth_token = Appspider::Api::Authentication.login(@rest_api_url,@username,@password)
          xml_report = Appspider::Api::ReportManagement.get_vul_summary_xml(rest_api_url,auth_token,{ scanId:scanId })
          f = File.open("#{@config_name}_xml_report.xml","w")
          f.write xml_report
          f.close
          listener.info "The file #{@config_name}_xml_report.xml was generated See #{f.path}"
        end

        listener.info "Status for #{@config_name} is '#{status}'"
      else
        listener.info "Monitoring is not enabled. For a full detail of the scan go to the Appspider Enterprise link"
      end
      listener.info "Scanning '#{config_name}' is done!!"
    else
      listener.info "AppSpider was not enabled."
    end
    listener.info "Finished Scanning scan id: #{@config_name}"
  end

end
