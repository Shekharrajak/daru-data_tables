require 'date'

module Daru
  module View
    module ParamHelpers
      def js_parameters(options)
        return '' if options.nil?

        attributes = options.collect { |(key, value)| "#{key}: #{typecast(value)}" }
        '{' + attributes.join(', ') + '}'
      end

      # If the column type is 'string'    , the value should be a string.
      # If the column type is 'number'    , the value should be a number.
      # If the column type is 'boolean'   , the value should be a boolean.
      # If the column type is 'date'      , the value should be a Date object.
      # If the column type is 'datetime'  , the value should be a DateTime or
      # Time object.
      # If the column type is 'timeofday' , the value should be an array of
      # three or four numbers: [hour, minute, second, optional milliseconds].
      # Returns an array of strings if given an array
      # Returns 'null' when value is nil.
      # Recursive typecasting when value is a hash.
      #
      # rubocop:disable Metrics/PerceivedComplexity, Metrics/MethodLength
      # rubocop:disable  Metrics/CyclomaticComplexity, Metrics/AbcSize
      def typecast(value, type=nil)
        case
        when value.respond_to?(:js_code) && value.js_code?
          value
        when value.is_a?(String)
          value.to_json
        when value.is_a?(Integer) || value.is_a?(Float)
          value
        when value.is_a?(TrueClass) || value.is_a?(FalseClass)
          value.to_s
        when value.is_a?(DateTime) || value.is_a?(Time)
          if type == 'time'
            "new Date(0, 0, 0, #{value.hour}, #{value.min}, #{value.sec})"
          else
            "new Date(#{value.year}, #{value.month-1}, #{value.day}, #{value.hour}, #{value.min}, #{value.sec})"
          end
        when value.is_a?(Date)
          "new Date(#{value.year}, #{value.month-1}, #{value.day})"
        when value.nil?
          'null'
        when value.is_a?(Array)
          '[' + value.map { |v| typecast(v) }.join(',') + ']'
        when value.is_a?(Hash)
          js_parameters(value)
        else
          value
        end
      end
      # rubocop:enable Metrics/PerceivedComplexity, Metrics/MethodLength
      # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize
    end
  end
end
