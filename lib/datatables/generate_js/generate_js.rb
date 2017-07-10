require_relative 'param_helpers'

module DataTables
  module JsHelpers
    include DataTables::ParamHelpers

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
      js << "\n  $('#example').DataTable("
      js << "\n    #{js_parameters(@options)}"
      js << "\n  );"
      js << "\n"
      js << "\n});"
      js
    end

    # def draw_js(element_id)
    #   js = ''
    #   js << "\n $(function() {"
    #   js << "\n   $('##{element_id}').DataTable();"
    #   js << "\n });"
    #   js
    # end

    # def draw_js(element_id)
    #   js = ''
    #   js << "(function() {
    #     var data = [];
    #     for ( var i=0 ; i<50000 ; i++ ) {
    #         data.push( [ i, i, i, i, i ] );
    #     };

    #     function_table(){
    #       ('#{element_id}').DataTable( {
    #         data:           data,
    #         deferRender:    true,
    #         scrollY:        200,
    #         scrollCollapse: true,
    #         scroller:       true
    #       } );
    #     );
    # })();"
    #   js
    # end
  end # class end
end