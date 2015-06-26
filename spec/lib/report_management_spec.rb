require 'spec_helper'
RSpec.describe Appspider::Api::ReportManagement do
  before(:each) do
    @rest_api_url= 'http://ontesting.ntobjectives.com/ntoe36/rest/v1'
    @name = 'wstclient'
    @password = 'wstclient'
  end
  describe 'Report Management' do
    before(:each) do
      @auth_token = Appspider::Api::Authentication.login(@rest_api_url,@name,@password)
    end

    context '#get_vul_summary_xml' do

      it 'should get an xml file back' do
        expect {
          params = {
              scanId: '9a9309e9-3ede-43a9-9edb-7fab5031003c',
              type: 'xml'
          }
          xml_report = Appspider::Api::ReportManagement.get_vul_summary_xml(
              @rest_api_url, @auth_token, params
          )
          expect(xml_report).not_to be_nil
        }.not_to raise_error
      end
    end

  end

end