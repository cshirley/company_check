require 'spec_helper'

describe "Search" do
  let(:client) { CompanyCheck::Client.new({login_uri:"test/login",
                                           key:"dummy_api_key",
                                           secret:"not_used"}) }
  describe "Company" do
    let(:search_result_fields) { ["number","name","status","sic","address","country"]}
    let(:result_fields) { ["name","number","sicCode","registeredAddress","postcode"]}

    it "should return a list of companies" do
      VCR.use_cassette("company_search_results") do
        results = client.company_search({name:"Smarta"})
        expect(results.count).to be > 0
        validate_fields results, search_result_fields
      end
    end

    it "should not return a result list due to invalid params" do
      VCR.use_cassette("company_invalid_search_results") do
        expect{ client.company_search({n:"Smarta"}) }.to raise_error(CompanyCheck::InvalidParameterError)
      end
    end

    it "should return details" do
      VCR.use_cassette("company_details") do
        results = client.company_search({name:"Smarta"})
        company_result = client.company(results.first["number"])
        validate_fields [company_result], result_fields

      end
    end

    describe "Document" do
      it "should raise a quota exceeded error" do
        VCR.use_cassette("company_documents_results_quota_exceeded") do
          results = client.company_search({name:"Smarta"})
          expect { client.company_documents(results.first["number"])}.to raise_error(CompanyCheck::QuotaExceededError)
        end
      end
    end


  end


  describe "Director" do
    let(:search_result_fields) { ["number","name", "registeredPostcodes"]}
    let(:result_fields) { ["number","firstName","title","surname","middleNames",
                           "postalTitle","suffix","honours","dateOfBirth",
                           "nationality","numberOfAppointments",
                           "numberOfCurrentAppointments",
                           "numberOfHistoricalAppointments"]}

    it "should return a list of directors" do
      VCR.use_cassette("director_search_results") do
        results = client.director_search({name:"Clive Shirley"})
        expect(results.count).to be > 0
        validate_fields results, search_result_fields
      end
    end
    it "should not return a result list due to invalid params" do
      VCR.use_cassette("director_invalid_search_results") do
        expect{ client.director_search({n:"Clive Shirley"}) }.to raise_error(CompanyCheck::InvalidParameterError)
      end
    end

    it "should return details" do
      VCR.use_cassette("director_details") do
        results = client.director_search({name:"Clive Shirley"})
        director_result = client.director(results.first["number"])
        validate_fields [director_result], result_fields
      end
    end

  end

  def validate_fields(results, expected_fields)
    results.first.keys.each { |k|
      expect( expected_fields.include?(k) ).to eql true }
  end
end

