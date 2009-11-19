# encoding: utf-8

require 'i18n//formatters/base'

module I18n
  module Formatters
    class DateTime < Base
      def format
        object.strftime(localized_format)
      end

      protected

        def localized_format
          format = target_format

          if Symbol === format
            key = format
            type = object.respond_to?(:sec) ? 'time' : 'date'
            format = I18n.backend.send(:lookup, locale, :"#{type}.formats.#{key}")
            raise(MissingTranslationData.new(locale, key, options)) if format.nil?
          end

          format = I18n.backend.send(:resolve, locale, object, format, options)
          format.to_s.gsub(/%[aAbBp]/) do |match|
            case match
            when '%a' then I18n.t(:"date.abbr_day_names",                  :locale => locale, :format => format)[object.wday]
            when '%A' then I18n.t(:"date.day_names",                       :locale => locale, :format => format)[object.wday]
            when '%b' then I18n.t(:"date.abbr_month_names",                :locale => locale, :format => format)[object.mon]
            when '%B' then I18n.t(:"date.month_names",                     :locale => locale, :format => format)[object.mon]
            when '%p' then I18n.t(:"time.#{object.hour < 12 ? :am : :pm}", :locale => locale, :format => format) if object.respond_to?(:hour)
            end
          end
        end
    end
  end
end
