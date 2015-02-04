require 'spec_helper'
class CompanyCheck::MockCommand < CompanyCheck::BaseCommand;end

describe "Command" do
  let(:command) { CompanyCheck::MockCommand.new(CompanyCheck::Client.new({login_uri:"login/test",
                                                                          key:"foo",
                                                                          secret:"bar"})) }

  describe "methods" do
    it "should convert to underscore case" do
      expect(command.underscore(command.class.name)).to eql "company_check/mock_command"
    end
    it "should convert to underscore case" do
      expect(command.lower_camel_case("MockCommand")).to eql "mockCommand"
    end
    it "should return correct case endpoint" do
      expect(command.endpoint).to eql "mockCommand"
    end
  end
end
