require_relative 'param_helpers'
require_relative '../core_ext/string'

module Daru
  module View
    module JsHelpers
      include Daru::View::ParamHelpers

      # @param id [String] The ID of the DIV element that the DataTable
      #   should be rendered in
      # @return [String] Generates JavaScript function for rendering the Table.
      def draw_js(element_id)
        if options[:data] && options[:data].length >= 50_000
          data_array = extract_data_array
          draw_ajax_option
        end
        js = ''
        js << "\n$(document).ready(function() {"
        js << "\n"
        js << "\n\tvar data_array = #{data_array};" unless options[:data]
        js << "\n\t$('##{element_id}').DataTable("
        js << "\n\t\t#{js_parameters(@options)}"
        js << "\n\t);"
        js << "\n"
        js << "\n});"
        js
      end

      # @param id [String] The ID of the DIV element that the DataTable
      #   should be rendered in
      # @return [String] Generates JavaScript function for rendering the Table
      #   in IRuby notebook
      def draw_js_iruby(element_id)
        if options[:data] && options[:data].length >= 50_000
          data_array = extract_data_array
          draw_ajax_option
        end
        js = ''
        js << "\n$( function () {"
        js << "\n\tvar data_array = #{data_array};" unless options[:data]
        js << "\n\tvar table = $('##{element_id}').DataTable("
        js << "\n\t\t#{js_parameters(@options)}"
        js << "\n\t);"
        js << "\n"
        js << "\n});"
        js
      end

      # @return [Array, void] returns data Array if present in the options
      def extract_data_array
        options.delete(:data) unless options[:data].nil?
      end

      # @return [void] adds serverSide and ajax options
      def draw_ajax_option
        ajax_str = ''
        ajax_str << "\nfunction ( data, callback, settings ) {"
        ajax_str << "\n\tvar out = [];"
        ajax_str << "\n\tfor (var i=data.start; i<data.start+data.length; i++) {"
        ajax_str << "\n\t\tif (i < data_array.length) {"
        ajax_str << "\n\t\t\tout.push( data_array[i] );"
        ajax_str << "\n\t\t}"
        ajax_str << "\n\t}"
        ajax_str << "\n\tsetTimeout( function () {"
        ajax_str << set_callback_ajax
        ajax_str << "\n\t}, 50 );"
        ajax_str << "\n}"
        @options[:serverSide] = true
        @options[:ajax] = ajax_str.js_code
      end

      # @return [String] returns the callback js from the server
      def set_callback_ajax
        callback_js = ''
        callback_js << "\n\t\tcallback( {"
        callback_js << "\n\t\t\tdraw: data.draw,"
        callback_js << "\n\t\t\tdata: out,"
        callback_js << "\n\t\t\trecordsTotal: data_array.length,"
        callback_js << "\n\t\t\trecordsFiltered: data_array.length,"
        callback_js << "\n\t\t} );"
        callback_js
      end
    end
  end
end
