module AhoyEmail
  module Mailer
    extend ActiveSupport::Concern

    included do
      attr_accessor :ahoy_options
      class_attribute :ahoy_options
      self.ahoy_options = {}
      after_action :ahoy_track_message
    end

    class_methods do
      def track(options = {})
        self.ahoy_options = ahoy_options.merge(message: true).merge(options)
      end
    end

    def track(options = {})
      self.ahoy_options = (ahoy_options || {}).merge(message: true).merge(options)
    end

    def ahoy_track_message
      AhoyEmail::Processor.new(message, self).process
    end
  end
end
