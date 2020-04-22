require "active_support/inflector"

require_relative "user"

module Authentify
  class Configuration
    # The address that sends the login email
    # Default = no_reply@example.com.
    # @return [String]
    attr_accessor :mailer_sent_from

    # The url used to redirect authenticated users
    # Default = /
    # @return [String]
    attr_accessor :redirect_url

    # The model which represents the user in your system
    # Default = ::User
    attr_writer :user_model

    def initialize
      @mailer_sent_from = "no_reply@example.com"
      @redirect_url = "/"
    end

    def user_model
      @user_model || "User"
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  # Modify Authentify's configuration
  # @yieldparam [Authentify::Configuration] config current Authentiy config
  #
  # Authentify.configure do |config|
  #   config.redirect_url = "/dashboard"
  # end

  def self.configure
    yield configuration
  end
end
