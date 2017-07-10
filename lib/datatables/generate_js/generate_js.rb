
module DataTables
  class DataTable
    include DataTables::ParamHelpers

    # Generates JavaScript function for rendering the Table.
    #
    # Parameters:
    #  *element_id            [Required] The ID of the DIV element that the DataTable should be rendered in.
    def draw_js(element_id)
      js = ''
      js << "\n$(document).ready(function() {"
      js << "\n"
      js << "\n  $('#{element_id}').DataTable( {"
      js << "\n    #{@options.to_json}"
      js << "\n  }"
      js << "\n"
      js << "\n}"
      js
    end
  end # class end
end