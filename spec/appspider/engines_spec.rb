require 'rspec'
require 'appspider/lib/authentication'
require 'appspider/lib/engines'

RSpec.describe Appspider::Api::Engines do
  before(:each) do
    @login = {
        nto_ent_rest_url: 'http://ontesting.ntobjectives.com/ntoe36/rest/v1',
        name: 'wstclient',
        password: 'wstclient'
    }
  end
  describe "Engine" do
    before(:each) do
      auth_hash = Appspider::Api::Authentication.login(@login)
      @params = {
          nto_ent_rest_url: 'http://ontesting.ntobjectives.com/ntoe36/rest/v1',
          auth_token: auth_hash[:Token].to_s
      }
    end
    context "#get_scan_engines" do
      it 'should return all the scan engines' do
        expect(
          Appspider::Api::Engines.get_scan_engines(@params)
        ).not_to be_nil
      end
    end

  end
end
