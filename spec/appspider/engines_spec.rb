require 'spec_helper'
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
    context "#save_engine" do
      before(:each) do
        @params[:id] = 'temp id'
        @params[:url] = 'temp url'
        @params[:virtualName] = 'temp virtualname'
        @params[:login] = 'login'
        @params[:password] = 'password'
        @params[:notes] = 'Notes'
        @params[:doNotUpdate] = 'Yes'
      end
      it "should raise a StandardError when an id is not provided" do
        expect {
          @params[:id] = nil
          Appspider::Api::Engines.save_engine(@params)
        }.to raise_error StandardError,"'id' was not provided"
      end
      it "should raise a StandardError when an url is not provided" do
        expect {
          @params[:url] = nil
          Appspider::Api::Engines.save_engine(@params)
        }.to raise_error StandardError,"'url' was not provided"
      end
      it "should raise a StandardError when a virtualName is not provided" do
        expect {
          @params[:virtualName] = nil
          Appspider::Api::Engines.save_engine(@params)
        }.to raise_error StandardError,"'virtualName' was not provided"
      end
      it "should raise a StandardError when a login is not provided" do
        expect {
          @params[:login] = nil
          Appspider::Api::Engines.save_engine(@params)
        }.to raise_error StandardError,"'login' was not provided"
      end
      it "should raise a StandardError when a password is not provided" do
        expect {
          @params[:password] = nil
          Appspider::Api::Engines.save_engine(@params)
        }.to raise_error StandardError,"'password' was not provided"
      end
      it "should raise a StandardError when a notes is not provided" do
        expect {
          @params[:notes] = nil
          Appspider::Api::Engines.save_engine(@params)
        }.to raise_error StandardError,"'notes' was not provided"
      end
      it "should raise a StandardError when a doNotUpdate is not provided" do
        expect {
          @params[:doNotUpdate] = nil
          Appspider::Api::Engines.save_engine(@params)
        }.to raise_error StandardError,"'doNotUpdate' was not provided"
      end
    end
    context "#delete_scan_engine" do
      before(:each) { @params[:id] = 'randomID' }

      it "should raise a StandardError when id was not provided" do
        expect{
          @params[:id] = nil
          Appspider::Api::Engines.delete_scan_engine(@params)
        }.to raise_error StandardError, "'id' was not provided"
      end
    end
  end
end

