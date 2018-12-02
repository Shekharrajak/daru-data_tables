require 'securerandom'
require 'erb'
require_relative 'iruby_notebook'
require_relative '../generate_js/generate_js'
require 'action_view'
require 'daru/data_tables/constants_data_table'

module Daru
  module View
    class DataTables
      # @param dependent_js [Array] dependent js files required
      # @return [String] js code of the dependent files
      def self.init_javascript(
        dependent_js=DATATABLES_DEPENDENCIES_WEB
      )
        # TODO: there are many js and css files, that must be added for
        # more features. Refer: https://datatables.net/download/index
        js =  ''
        js << "\n<script type='text/javascript'>"
        js << Daru::View.generate_init_code_js(dependent_js)
        js << "\n</script>"
        js
      end

      # @param [Array] dependent css files required
      # @return [String] CSS code of the dependent file(s)
      def self.init_css(
        dependent_css=DATATABLES_DEPENDENCIES_CSS
      )
        css = ''
        css << "\n<style type='text/css'>"
        css << Daru::View.generate_init_code_css(dependent_css)
        css << "\n</style>"
        css
      end

      # dependent script for the library. It must be added in the head tag
      # of the web application.
      #
      # @return [String] code of the dependent css and js file(s)
      # @example
      #
      # dep_js = DataTables.init_script
      #
      # use in Rails app : <%=raw dep_js %>
      def self.init_script
        init_code = ''
        init_code << init_css
        init_code << init_javascript
        init_code
      end
    end

    module Display
      # @param dom [String] The ID of the DIV element that the DataTable
      #   should be rendered in
      # @param options [Hash] options provided
      # @return [String] js script to render the table
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
      # @param id [String] The ID of the DIV element that the DataTable
      #   should be rendered in
      # @param options [Hash] options provided
      # @return [String] Generates JavaScript and renders the table in the
      #   final HTML output.
      def to_html(id=nil, options={})
        # More things can be added into table_script.erb
        path = File.expand_path('../templates/table_script.erb', __dir__)
        template = File.read(path)
        id ||= SecureRandom.uuid # TODO: remove it or Use it for table tag.
        element_id ||= id
        table_script = show_script(element_id, script_tag: false)
        html_code = ERB.new(template).result(binding)
        # table_options is given. That means table html code is not present in
        # the webpage. So it must generate table code with given options.
        table_thead = extract_table
        draw_table_thead(element_id, html_code, table_thead)
        html_code
      end

      # @param dom [String] The ID of the DIV element that the DataTable
      #   should be rendered in
      # @return [void] shows the datatable in IRuby notebook
      def show_in_iruby(dom=SecureRandom.uuid)
        IRuby.html(to_html(dom))
      end

      # @param element_id [String] The ID of the DIV element that the DataTable
      #   should be rendered in
      # @return [String] returns the javascript of the DataTable
      def to_js(element_id)
        js =  ''
        js << "\n<script type='text/javascript'>"
        js << draw_js(element_id)
        js << "\n</script>"
        js
      end

      private

      def extract_table
        return data.to_html_thead unless data.is_a?(Array)

        path = File.expand_path('../templates/thead.erb', __dir__)
        template = File.read(path)
        ERB.new(template).result(binding)
      end

      def draw_table_thead(element_id, html_code, table_thead)
        if html_options && html_options[:table_options]
          draw_table_thead_from_html_options(element_id, html_code, table_thead)
        # if user provided html_options but not provided html_options[:table_options]
        else
          html_code.concat(
            content_tag(
              'table', table_thead.html_safe, id: element_id, class: 'display'
            )
          )
        end
      end

      def draw_table_thead_from_html_options(element_id, html_code, table_thead)
        html_options[:table_options][:id] = element_id
        html_options[:table_options][:class] ||= 'display'
        table_thead = html_options[:table_options].delete(:table_thead) if
        html_options[:table_options][:table_thead]
        html_code.concat(
          content_tag('table', table_thead.html_safe, html_options[:table_options])
        )
      end
    end

    class DataTable
      include ActionView::Helpers::TagHelper # to use content_tag
      include Display
      include JsHelpers
    end
  end
end
