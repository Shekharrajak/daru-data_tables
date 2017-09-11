module Daru
  module DataTables
    # generate initializing code
    def self.generate_init_code_js(dependent_js)
      js_dir = File.expand_path('../../js', __FILE__)
      path = File.expand_path('../../templates/init.inline.js.erb', __FILE__)
      template = File.read(path)
      ERB.new(template).result(binding)
    end

    def self.generate_init_code_css(dependent_css)
      css_dir = File.expand_path('../../css', __FILE__)
      path = File.expand_path('../../templates/init.inline.css.erb', __FILE__)
      template = File.read(path)
      ERB.new(template).result(binding)
    end

    # Enable to show plots on IRuby notebook.
    # Load the dependent JS files in IRuby notebook. Those JS will help in
    # plotting the table in IRuby cell.
    #
    # One can see the loaded JS files in the source code of the notebook.
    # @example
    #
    # DataTables.init_iruby
    #
    def self.init_iruby(
      dependent_js=['jquery.dataTables.js'],
      dependent_css=['jquery.dataTables.css']
    )
      # Note: Jquery is dependecy for DataTables.
      # Since Jquery is already a dependency for iruby notebook.
      # So it will be loaded into IRuby notebook when `iruby` is run.
      # No need to add it in the `dependent_js`.
      js = generate_init_code_js(dependent_js)
      css = generate_init_code_css(dependent_css)
      IRuby.display(IRuby.javascript(js))
      # IRuby.display(css, mime: 'text/stylesheet')
      # FixMe: Don't know, how to add css in IRuby notebook (Means there is
      # no IRuby.stylesheet(..) method)
    end
  end
end