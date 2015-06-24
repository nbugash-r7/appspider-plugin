require 'spec_helper'
require 'appspider/api_extended'
RSpec.describe Appspider::ApiExtended do
  before(:each) do
    @options = {
        url: 'http://ontesting.ntobjectives.com/ntoe36/rest/v1',
        username: 'wstclient',
        password: 'wstclient'
    }
  end

  describe "Scan Configuration" do
    it 'should be able to list all the scans config by name' do
      expect{
        config_names = Appspider::ApiExtended.get_all_scans @options
        expect(config_names).not_to be_empty
      }.not_to raise_error
    end

  end

  describe "Scan Management" do
    # Commenting this to avoid running multiple scans
    it 'should be able to start a scan given a scan config name' do
      config_name = 'wst3linksXSS_nb'
      expect{
        @options[:config_name] = config_name
        Appspider::ApiExtended.run_scan_config @options
      }.not_to raise_error
    end
  end

  describe "Scan Status" do
    it 'should be able to get all the scan status' do
      expect(Appspider::ApiExtended.get_all_scan_status @options).not_to be_empty
    end
    it 'should be able to get all scans with "Running" status' do
      expect{
        @options[:status] = "Running"
        # TODO:
        # (1) Need to start a scan
        # (2) Wait for a few mins for status to go from Starting.. to Running

        # (3) Check to see if there's a "Running" scan
        running_status = Appspider::ApiExtended.get_scan_status_of @options
        running_status
      }.not_to raise_error
    end
  end
end