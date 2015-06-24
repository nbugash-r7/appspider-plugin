require 'spec_helper'
require 'appspider/api_extended'
RSpec.describe Appspider::Api::ScanManagement do
  before(:each) do
    @rest_api_url= 'http://ontesting.ntobjectives.com/ntoe36/rest/v1'
    @name = 'wstclient'
    @password = 'wstclient'
  end
  describe 'Scan Management' do
    before(:each) do
      @auth_token = Appspider::Api::Authentication.login(@rest_api_url,@name,@password)
    end
    context '#get_scans' do
      it 'should retrieve the list of scans' do
        expect {
          scan_lists = Appspider::Api::ScanManagement.get_scans(@rest_api_url,@auth_token)
          expect(scan_lists[:Scans]).not_to eq([])
        }.not_to raise_error
      end
    end
    context '#get_scan_status' do
      before(:each) do
        # (1) Need to trigger a scan
        options = {
            rest_api_url: @rest_api_url,
            auth_token: @auth_token,
            config_name: 'wst3linksXSS_nb'
        }
        response = Appspider::Api::Extended.run_scan options
        # (2) Get scanId of the scan
        @scan_id = response[:Scan][:Id]
      end
      it 'should be able to get the status of a particular scan' do
        expect {
          params = { scanId: @scan_id }
          response = Appspider::Api::ScanManagement.get_scan_status(@rest_api_url,@auth_token,params)
          expect(response[:IsSuccess]).to be_truthy
          expect(response[:Status]).to eq("Running")
        }.not_to raise_error
      end
    end
  end

end