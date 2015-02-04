require 'spec_helper'

describe "client" do
  let(:login_uri) { "login/test" }
  let(:api_key) { "api_key_does_not_work" }
  let(:api_secret) { "secret" }
  let(:dummy_email) { "test_user@foobar.com" }
  let(:client) { CompanyCheck::Client.new({login_uri:login_uri, key:api_key, secret:api_secret}) }

  describe "client setup" do
    it "should return the correct base URL" do
      expect(client.base_url).to eql "http://companycheck.co.uk"
    end
    it "should format the api request" do
      url = client.make_request_url("", {zzzz: "foobar"})
      expect(url).to eql "?apiKey=#{api_key}&zzzz=foobar"
    end
  end

  describe "Single Sign On URL generation" do
    it 'Should generate the correct URL' do
      url = client.get_sso_login_url(dummy_email)

      opt = {e:dummy_email,
             d: ::Digest::MD5.hexdigest([api_key,
                                          dummy_email,
                                          Date.today.to_s].join(':')) }

      expect(url).to eql "#{client.base_url}/#{client.login_uri}?#{Faraday::Utils.build_nested_query(opt)}"
    end
  end

  describe "API Authentication" do
    it "API call should return 403 with invalid apiKey" do
      expect{ client.company_search( { name:"Smarta"} ) }.to raise_error(CompanyCheck::AuthenticationError)
    end
  end

end

