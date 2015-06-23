require 'spec_helper'
RSpec.describe Appspider::Api::ScanConfiguration do
  before(:each) do
    @login = {
        nto_ent_rest_url: 'http://ontesting.ntobjectives.com/ntoe36/rest/v1',
        name: 'wstclient',
        password: 'wstclient'
    }
  end
  describe "Scan Configuration" do
    before(:each) do
      auth_hash = Appspider::Api::Authentication.login @login
      @auth_token = auth_hash[:Token]
    end
    context "#get_configs" do
      before(:each) do
        @params = {
            nto_ent_rest_url: 'http://ontesting.ntobjectives.com/ntoe36/rest/v1',
            auth_token: @auth_token
        }
      end
      it 'should retrive all the scan configurations' do
        expect{
            configs = Appspider::Api::ScanConfiguration.get_configs @params
            configs
            expect(configs[:Configs]).not_to be_empty
        }
      end
    end
    context "#get_scan_config" do
      before(:each) do
        @params = {
            nto_ent_rest_url: 'http://ontesting.ntobjectives.com/ntoe36/rest/v1',
            auth_token: @auth_token
        }
      end
      it 'should retrive all the scan configurations' do
        @params[:id] = ''
        expect(Appspider::Api::ScanConfiguration.get_scan_config @params).not_to be_empty
      end
    end
  end
end