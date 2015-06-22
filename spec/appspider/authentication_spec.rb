require 'appspider/lib/authentication'

RSpec.describe Appspider::Api::Authentication do
  before(:each) do
    @nto_ent_rest_url = 'http://ontesting.ntobjectives.com/ntoe36/rest/v1'
    @username = 'wstclient'
    @password = 'wstclient'
  end
  describe '#Authentication' do
    context 'invalid parameters' do
      it 'should not throw an error for nil Appspider URL' do
        expect{
          @nto_ent_rest_url = nil
          Appspider::Api::Authentication.login(@nto_ent_rest_url,@username,@password)
        }.to raise_error
      end
      it 'should not throw an error for nil username' do
        expect{
          @username = nil
          Appspider::Api::Authentication.login(@nto_ent_rest_url,@username,@password)
        }.to raise_error
      end
      it 'should not throw an error for nil password' do
        expect{
          @password = nil
          Appspider::Api::Authentication.login(@nto_ent_rest_url,@username,@password)
        }.to raise_error
      end

    end
  end
end