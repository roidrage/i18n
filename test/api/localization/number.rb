# encoding: utf-8

module Tests
  module Backend
    module Api
      module Localization
        module Number
          def test_localizes_a_given_number_with_delimiter_and_separator
            assert_equal '1.999,99', I18n.backend.localize('de', 1999.99, :delimiter)
          end

          def test_localizes_a_given_number_with_delimiter_and_separator_and_precision_rounding_up
            assert_equal '2.000,0', I18n.backend.localize('de', 1999.99, :delimiter, :precision => 1)
          end

          def test_localizes_a_given_number_with_delimiter_and_separator_and_precision_rounding_down
            assert_equal '1.999,9', I18n.backend.localize('de', 1999.94, :delimiter, :precision => 1)
          end

          def test_localizes_a_given_number_with_custom_delimiter_and_separator
            assert_equal "1'999.99", I18n.backend.localize('de', 1999.99, :delimiter, :delimiter => "'", :separator => '.')
          end

          # currency
          def test_localizes_a_given_number_as_currency
            assert_equal '1.999,99€', I18n.backend.localize('de', 1999.99, :currency)
          end

          def test_localizes_a_given_number_as_currency_with_precision_rounding_up
            assert_equal '2.000,0€', I18n.backend.localize('de', 1999.99, :currency, :precision => 1)
          end

          def test_localizes_a_given_number_as_currency_with_precision_rounding_down
            assert_equal '1.999,9€', I18n.backend.localize('de', 1999.94, :currency, :precision => 1)
          end

          def test_localizes_a_given_number_as_currency_with_custom_symbol
            assert_equal '1.999,99 EUR', I18n.backend.localize('de', 1999.99, :currency, :unit => ' EUR')
          end

          def test_localizes_a_given_number_as_currency_with_custom_format
            assert_equal '€1.999,99', I18n.backend.localize('de', 1999.99, :currency, :format => '%u%n')
          end

          def test_localizes_a_given_number_as_currency_with_custom_delimiter_and_separator
            assert_equal "1'999.99€", I18n.backend.localize('de', 1999.99, :currency, :delimiter => "'", :separator => '.')
          end

          # percentage
          def test_localizes_a_given_number_as_percentage
            assert_equal '99,99%', I18n.backend.localize('de', 99.99, :percentage)
          end

          def test_localizes_a_given_number_as_percentage_with_precision_rounding_up
            assert_equal '100,0%', I18n.backend.localize('de', 99.99, :percentage, :precision => 1)
          end

          def test_localizes_a_given_number_as_percentage_with_precision_rounding_down
            assert_equal '99,9%', I18n.backend.localize('de', 99.94, :percentage, :precision => 1)
          end

          def test_localizes_a_given_number_as_percentage_with_custom_delimiter_and_separator
            assert_equal "1'999.99%", I18n.backend.localize('de', 1999.99, :percentage, :delimiter => "'", :separator => '.')
          end

          # storage_unit
          # def test_localizes_a_given_number_as_storage_unit
          #   assert_equal '0 Bytes',   I18n.backend.localize('de', 0, :storage_unit)
          #   assert_equal '1 Byte',    I18n.backend.localize('de', 1, :storage_unit)
          #   assert_equal '3 Bytes',   I18n.backend.localize('de', 3.14159265, :storage_unit)
          #   assert_equal '123 Bytes', I18n.backend.localize('de', 123.0, :storage_unit)
          #   assert_equal '123 Bytes', I18n.backend.localize('de', 123, :storage_unit)
          #   assert_equal '1.2 KB',    I18n.backend.localize('de', 1234, :storage_unit)
          #   assert_equal '12.1 KB',   I18n.backend.localize('de', 12345, :storage_unit)
          #   assert_equal '1.2 MB',    I18n.backend.localize('de', 1234567, :storage_unit)
          #   assert_equal '1.1 GB',    I18n.backend.localize('de', 1234567890, :storage_unit)
          #   assert_equal '1.1 TB',    I18n.backend.localize('de', 1234567890123, :storage_unit)
          #   assert_equal '1025 TB',   I18n.backend.localize('de', terabytes(1025), :storage_unit)
          #   assert_equal '444 KB',    I18n.backend.localize('de', kilobytes(444), :storage_unit)
          #   assert_equal '1023 MB',   I18n.backend.localize('de', megabytes(1023), :storage_unit)
          #   assert_equal '3 TB',      I18n.backend.localize('de', terabytes(3), :storage_unit)
          #   assert_equal '1.18 MB',   I18n.backend.localize('de', 1234567, :storage_unit, :precision => 2)
          #   assert_equal '3 Bytes',   I18n.backend.localize('de', 3.14159265, :storage_unit, :precision => 4)
          #   assert_equal '123 Bytes', I18n.backend.localize('de', '123', :storage_unit)
          #   assert_equal '1.01 KB',   I18n.backend.localize('de', kilobytes(1.0123), :storage_unit, :precision => 2)
          #   assert_equal '1.01 KB',   I18n.backend.localize('de', kilobytes(1.0100), :storage_unit, :precision => 4)
          #   assert_equal '10 KB',     I18n.backend.localize('de', kilobytes(10.000), :storage_unit, :precision => 4)
          #   assert_equal '1 Byte',    I18n.backend.localize('de', 1.1)
          #   assert_equal '10 Bytes',  I18n.backend.localize('de', 10)
          # end
          # 
          # protected
          # 
          #   def kilobytes(number)
          #     1024 * number
          #   end
          # 
          #   def megabytes(number)
          #     1024 * kilobytes(number)
          #   end
          # 
          #   def gigabytes(number)
          #     1024 * megabytes(number)
          #   end
          # 
          #   def terabytes(number)
          #     1024 * gigabytes(number)
          #   end
        end
      end
    end
  end
end
