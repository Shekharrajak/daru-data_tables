require_relative 'param_helpers'

module Daru
  module DataTables
    module JsHelpers
      include Daru::DataTables::ParamHelpers

      # Generates JavaScript function for rendering the Table.
      #
      # Parameters:
      #  *element_id            [Required] The ID of the DIV element that the DataTable should be rendered in.
      def draw_js(element_id)
        js = ''
        # js << "\n$(function() {"
        js << "\n$(document).ready(function() {"
        js << "\n"
        # js << "\n  $('##{element_id}').DataTable("
        js << "\n  $('##{element_id}').DataTable("
        js << "\n    #{js_parameters(@options)}"
        js << "\n  );"
        js << "\n"
        js << "\n});"
        js
      end

      def draw_js_iruby(element_id)
        js = ''
        js << "\n$( function () {"
        js << "\n  var table = $('##{element_id}').DataTable("
        js << "\n    #{js_parameters(@options)}"
        js << "\n  );"
        js << "\n"
        js << "\n});"
        js
      end
    end
  end
end
