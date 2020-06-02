require "active_support/inflector"

module Authentify
  class Configuration
    attr_accessor :mailer_sent_from
    attr_accessor :redirect_url

    attr_writer :user_model

    def initialize
      @mailer_sent_from = "no_reply@example.com"
      @redirect_url = "/"
    end

    def user_model
      (@user_model || "Authentify::User").to_s.constantize
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(config)
    @configuration = config
  end

  def self.configure
    yield configuration
  end
end
