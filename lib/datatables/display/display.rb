require 'securerandom'
require 'erb'
require_relative 'iruby_notebook'
require 'datatables/generate_js/generate_js'
require 'action_view'

module DataTables
  # dependent script for the library. It must be added in the head tag
  # of the web application.
  #
  # @example
  #
  # dep_js = DataTables.init_script
  #
  # use in Rails app : <%=raw dep_js %>
  #
  def self.init_script(
    dependent_js=[
      'jquery-1.12.4.js', 'jquery.dataTables.min.js',
      'dataTables.scroller.min.js'
    ],
    dependent_css=['jquery.dataTables.min.css', 'scroller.dataTables.min.css']
  )
    js =  ''
    js << "\n<script type='text/javascript'>"
    js << DataTables.generate_init_code_js(dependent_js)
    js << "\n</script>"
    js << "\n<style type='text/css'>"
    js << DataTables.generate_init_code_css(dependent_css)
    js << "\n</style>"
    js
  end

  module Display
    def show_script(dom=SecureRandom.uuid, options={})
      script_tag = options.fetch(:script_tag) { true }
      if script_tag
        to_js(dom)
      else
        html = ''
        html << draw_js(dom)
        html
      end
    end

    # If table_options is not present then it will assume that table tag is
    # already present in the web page source, where we are pasting the
    # html code.
    def to_html(id=nil, options={})
      # Some more things can be added into table_script.erb
      path = File.expand_path('../../templates/table_script.erb', __FILE__)
      template = File.read(path)
      id ||= SecureRandom.uuid # TODO: remove it or Use it for table tag.
      table_script = show_script(id, script_tag: false)
      html_code = ERB.new(template).result(binding)
      # table_options is given. That means table html code is not present in
      # the webpage. So it must generate table code with given options.
      unless options[:table_options].nil?
        options[:table_options][:id] = id
        table_thead_tbody = options[:table_options].delete(:table_html)
        table_thead_tbody ||= ""
        html_code.concat(content_tag("table", table_thead_tbody.html_safe, options[:table_options]))
      end
      html_code
    end

    def show_in_iruby(dom=SecureRandom.uuid)
      IRuby.html(to_html(dom))
    end

    # Generates JavaScript and renders the tabke in the final HTML output.
    #
    # Parameters:
    #  *element_id            [Required] The ID of the DIV element that the table should be rendered in.
    def to_js(element_id)
      js =  ""
      js << "\n<script type='text/javascript'>"
      js << draw_js(element_id)
      js << "\n</script>"
      js
    end
  end # module Display end

  class DataTable
    include ActionView::Helpers::TagHelper  # to use content_tag
    include Display
    include JsHelpers
  end
end
