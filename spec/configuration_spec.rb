require "spec_helper"

RSpec.describe Authentify::Configuration do
  subject(:config) { Authentify.configuration }

  describe "configuring the mailer sent from" do
    subject(:mailer_sent_from) { config.mailer_sent_from }

    context "when no value is specified" do
      it "defaults to 'no_reply@example.com'" do
        expect(mailer_sent_from).to eq("no_reply@example.com")
      end
    end

    context "when a custom value is specified" do
      let(:custom_sent_from) { "custom@example.com" }

      before { Authentify.configure { |config| config.mailer_sent_from = custom_sent_from } }

      it "uses the custom value" do
        expect(mailer_sent_from).to eq(custom_sent_from)
      end
    end
  end

  describe "configuring the user model" do
    subject(:user_model) { config.user_model }

    context "when no user model is specified" do
      it "defaults to User" do
        expect(user_model).to eq(Authentify::User)
      end
    end

    context "when a custom user model is specified" do
      before(:each) { CustomUser = Class.new }

      after(:each) { Object.send(:remove_const, :CustomUser) }

      before { Authentify.configure { |config| config.user_model = CustomUser } }

      it "uses the custom user model" do
        expect(user_model).to eq(CustomUser)
      end
    end
  end

  describe "configuring the redirect url" do
    subject(:redirect_url) { config.redirect_url }

    let(:default_url) { "/" }

    context "when no redirect url is specified" do

      it "defaults to '/'" do
        expect(redirect_url).to eq(default_url)
      end
    end

    context "when a custom redirect url is specified" do
      let(:custom_url) { "/dashboard" }

      before { Authentify.configure { |config| config.redirect_url = custom_url } }

      it "uses the custom url" do
        expect(redirect_url).to eq(custom_url)
      end
    end
  end
end
