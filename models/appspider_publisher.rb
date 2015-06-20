# require_relative '../lib/publisher'
require_relative 'api_extended'
# A single build step that run after the build is complete
class AppspiderPublisher < Jenkins::Tasks::Publisher

  display_name "Appspider"

  attr_accessor :appspider_url
  attr_accessor :username
  attr_accessor :password
  attr_accessor :config_name
  attr_accessor :startscan

  # Invoked with the form parameters when this extension point
  # is created from a configuration screen.
  def initialize(attrs = {})
    @appspider_url = attrs['appspider_url']
    @username = attrs['username']
    @password = attrs['password']
    @config_name = attrs['config_name']
    @startscan = attrs['startscan']
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
    listener.info "AppSpider Url: '#{@appspider_url}'"
    listener.info "Username: '#{@username}'"
    listener.info "Password: '#{@password}'"
    listener.info "Config name: '#{@config_name}'"
    listener.info "Start Scan: '#{@startscan}'"

    if @startscan
      listener.info "Starting AppSpider Scan"
      # builder = Appsider::Publisher::MessageBuilderFactory.create(build.native)
      # message = builder.build_message
      options = {
          url: @appspider_url,
          username: @username,
          password: @password,
          config_name: @config_name,
          build: build,
          launcher: launcher,
          listener: listener
      }

      # api_ext = Appspider::ApiExtended.new options
      # api_ext.run_scan_config options
    else
      listener.info "AppSpider was not enabled."
    end
    listener.info "Finished Scanning scan id: #{@config_name}"
  end

end