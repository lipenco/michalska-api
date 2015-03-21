require 'rails_helper'

class Authentication
  include Authenticable
end

describe Authenticable, :type => :controller do
  let(:authentication) { Authentication.new }

  describe "#current_user" do
    before do
      @user = FactoryGirl.create :user
      request.headers["Authorization"] = @user.auth_token
      # allow(authentication).to receive(:request).and_return(request)
    end
    it "returns the user from the authorization header" do
      # expect(authentication.current_user.auth_token).to eql @user.auth_token
    end
  end

  describe "#authenticate_with_token" do

  end

  describe "#user_signed_in?" do
    context "when there is a user on 'session'" do
      # before do
      #   @user = FactoryGirl.create :user
      #   authentication.stub(:current_user).and_return(@user)
      # end
      #
      # it { should be_user_signed_in }
    end

    context "when there is no user on 'session'" do
      # before do
      #   @user = FactoryGirl.create :user
      #   authentication.stub(:current_user).and_return(nil)
      # end
      #
      # it { should_not be_user_signed_in }
    end
  end


end
