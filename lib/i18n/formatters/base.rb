# encoding: utf-8

module I18n
  module Formatters
    class Base
      attr_reader :locale, :object, :target_format, :options

      def initialize(locale, object, target_format = :default, options = {})
        @locale, @object, @target_format, @options = locale.to_sym, object, target_format, options
      end

      def format
        raise "You must override this method"
      end
    end
  end
end
