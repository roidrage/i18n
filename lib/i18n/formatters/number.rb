# encoding: utf-8

require 'i18n//formatters/base'

module I18n
  module Formatters
    class Number < Base
      def format
        case target_format
        when :currency then currency(options)
        when :percentage then percentage(options)
        # when :storage_unit then storage_unit(options)
        else
          delimited(options)
        end
      end

      protected

        def delimited(options = {})
          defaults = I18n.backend.translate(locale, :'number.format')

          precision ||= (options[:precision] || defaults[:precision]).to_i
          separator ||= (options[:separator] || defaults[:separator])
          delimiter ||= (options[:delimiter] || defaults[:delimiter])
          separator   = '' if precision == 0

          rounded_number = BigDecimal.new((Float(object) * (10 ** precision)).to_s).round.to_f / 10 ** precision
          number = "%01.#{precision}f" % rounded_number

          parts = number.to_s.split('.')
          parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{delimiter}")
          parts.join(separator)
        end

        def currency(options = {})
          defaults = defaults_for(:currency)

          precision = (options[:precision] || defaults[:precision])
          unit      = (options[:unit]      || defaults[:unit])
          separator = (options[:separator] || defaults[:separator])
          delimiter = (options[:delimiter] || defaults[:delimiter])
          format    = (options[:format]    || defaults[:format])

          format.gsub(/%n/, delimited(
            :precision => precision,
            :delimiter => delimiter,
            :separator => separator)
          ).gsub(/%u/, unit)
        end

        def percentage(options = {})
          defaults = defaults_for(:percentage)

          precision = (options[:precision] || defaults[:precision])
          separator = (options[:separator] || defaults[:separator])
          delimiter = (options[:delimiter] || defaults[:delimiter])

          delimited(
            :precision => precision,
            :separator => separator,
            :delimiter => delimiter
          ) + '%'
        end

        # STORAGE_UNITS = [:byte, :kb, :mb, :gb, :tb].freeze
        # 
        # def storage_unit(options = {})
        #   defaults = defaults_for(:human)
        # 
        #   precision ||= (options[:precision] || defaults[:precision])
        #   separator ||= (options[:separator] || defaults[:separator])
        #   delimiter ||= (options[:delimiter] || defaults[:delimiter])
        # 
        #   storage_units_format = I18n.backend.translate(locale, :'number.human.storage_units.format')
        # 
        #   if (number = object.to_i) < 1024
        #     unit = I18n.backend.translate(locale, :'number.human.storage_units.units.byte', :count => number)
        #     storage_units_format.gsub(/%n/, number.to_s).gsub(/%u/, unit)
        #   else
        #     number   = Float(object)
        #     max_exp  = STORAGE_UNITS.size - 1
        #     exponent = (Math.log(number) / Math.log(1024)).to_i # Convert to base 1024
        #     exponent = max_exp if exponent > max_exp # we need this to avoid overflow for the highest unit
        #     number  /= 1024 ** exponent
        # 
        #     unit_key = STORAGE_UNITS[exponent]
        #     unit = I18n.backend.translate(locale, :"number.human.storage_units.units.#{unit_key}", :count => number)
        # 
        #     escaped_separator = Regexp.escape(separator)
        #     formatted_number = delimited(
        #       :precision => precision,
        #       :separator => separator,
        #       :delimiter => delimiter
        #     ).sub(/(#{escaped_separator})(\d*[1-9])?0+\z/, '\1\2').sub(/#{escaped_separator}\z/, '')
        #     storage_units_format.gsub(/%n/, formatted_number).gsub(/%u/, unit)
        #   end
        # end

        def defaults_for(format)
          defaults        = I18n.backend.translate(locale, :'number.format')
          format_defaults = I18n.backend.translate(locale, :"number.#{format}.format")
          defaults.merge(format_defaults)
        end
    end
  end
end
