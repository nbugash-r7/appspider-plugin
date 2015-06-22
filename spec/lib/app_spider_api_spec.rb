require 'rspec'
require 'app_spider_api'
RSpec.describe AppSpiderApi do
  before(:each) do
    @options = {
        url: 'http://ontesting.ntobjectives.com/ntoe36/rest/v1',
        username: 'wstclient',
        password: 'wstclient'
    }
  end

  describe 'creating a new instance of AppSpiderAPI Object' do
    context "when valid options are passed" do
      before(:each) do
        @appspider_instance = AppSpiderApi.new(@options)
      end
      it 'should be able to login' do
        expect{
          auth = @appspider_instance.auth_token
          auth
        }.not_to raise_error
      end
      it 'should be able to get all engine groups' do
        expect{
          enginegroups = @appspider_instance.get_all_engine_groups
          enginegroups
        }.not_to raise_error
      end
      it 'should be able to get all configs' do
        expect{
          configs = @appspider_instance.get_configs
          configs
        }.not_to raise_error
      end
      it 'should be able to get all scans' do
        expect{
          all_scans = @appspider_instance.get_scans
          all_scans
        }.not_to raise_error
      end
      it 'should be able to get the scan status of a single scan' do
        expect {
          all_scans = @appspider_instance.get_scans
          scan = all_scans[:Scans].first
          @appspider_instance.get_scan_status scan[:Id]
        }.not_to raise_error
      end
    end
  end

  describe 'retrieve scan -> pause scan -> resume scan' do
    it 'should be able to retrieve a scan' do
      expect{
        appspider_instance = AppSpiderApi.new(@options)
        all_scan = appspider_instance.get_scans
        scan = all_scan[:Scans].first
        scan_id = scan[:Id]
        if appspider_instance.is_scan_active? scan_id
          puts "Scan #: #{scan_id} is active"
        else
          puts "Scan #: #{scan_id} is inactive"
        end
        response = appspider_instance.get_scan_status scan_id
        response
      }.not_to raise_error
    end

  end

  describe 'Scans' do
    before(:each) do
      @all_scan_status = AppSpiderApi.get_all_scan_status @options
      @appspider_instance = AppSpiderApi.new(@options)
    end
    it 'should return all the status for each scan' do
      expect(@all_scan_status).not_to be_empty
    end
    it 'should be able to run the scan "wst3linksXSS_nb"' do
      expect{
        @options[:config_name] = "wst3linksXSS_nb"
        AppSpiderApi.run_scan_config @options
      }.not_to raise_error
    end
  end
end