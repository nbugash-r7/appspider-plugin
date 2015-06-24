require 'spec_helper'
RSpec.describe Appspider::Api::EngineGroup do
  before(:each) do
    @login = {
        nto_ent_rest_url: 'http://ontesting.ntobjectives.com/ntoe36/rest/v1',
        name: 'wstclient',
        password: 'wstclient'
    }
  end
  describe "Engine Group" do
    before(:each) do
      auth_hash = Appspider::Api::Authentication.login(@login)
      @auth_token = auth_hash[:Token].to_s
    end
    context "#get_all_engine_groups" do
      before(:each) do
        @params = {
            nto_ent_rest_url: 'http://ontesting.ntobjectives.com/ntoe36/rest/v1',
            auth_token: @auth_token
        }
      end
      it "should be able to get all engine groups" do
        expect(Appspider::Api::EngineGroup.get_all_engine_groups(@params)).not_to be_empty
      end
    end
    context "#save_engine_group" do
      before(:each) do
        @params = {
            nto_ent_rest_url: 'http://ontesting.ntobjectives.com/ntoe36/rest/v1',
            auth_token: @auth_token,
            id: 'randomID',
            name: 'name',
            description: 'description',
            monitoring: 'monitoring'
        }
      end
      it "should raise a StandardError when id is not specified in the parameters" do
        expect{
          @params[:id] = nil
          Appspider::Api::EngineGroup.save_engine_group @params
        }.to raise_error StandardError,"'id' was not specified in the parameters"
      end
      it "should raise a StandardError when name is not specified in the parameters" do
        expect{
          @params[:name] = nil
          Appspider::Api::EngineGroup.save_engine_group @params
        }.to raise_error StandardError,"'name' was not specified in the parameters"
      end
      it "should raise a StandardError when description is not specified in the parameters" do
        expect{
          @params[:description] = nil
          Appspider::Api::EngineGroup.save_engine_group @params
        }.to raise_error StandardError,"'description' was not specified in the parameters"
      end
      it "should raise a StandardError when monitoring is not specified in the parameters" do
        expect{
          @params[:monitoring] = nil
          Appspider::Api::EngineGroup.save_engine_group @params
        }.to raise_error StandardError,"'monitoring' was not specified in the parameters"
      end
    end
  end
end