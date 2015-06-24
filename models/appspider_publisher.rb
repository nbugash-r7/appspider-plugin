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

  CHECK_INTERVAL = 60 # Check scan status every 'CHECK_INTERVAL' seconds
  SCAN_IN_PROGRESS_REGEX = /ing/i # Any status with '..ing' ending

  # Invoked with the form parameters when this extension point
  # is created from a configuration screen.
  def initialize(attrs = {})
    @rest_api_url = attrs['rest_api_url']
    @username = attrs['username']
    @password = attrs['password']
    @config_name = attrs['config_name']
    @startscan = attrs['startscan']
    @monitor = attrs['monitor']
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
