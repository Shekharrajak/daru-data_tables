require 'securerandom'
require 'erb'
require_relative 'iruby_notebook'

module DataTables
  def self.init_script(
    dependent_js=[
      'jquery-1.12.4.js', 'jquery.dataTables.min.js',
      'dataTables.scroller.min.js'
    ]
  )
    js =  ''
    js << "\n<script type='text/javascript'>"
    js << DataTables.generate_init_code(dependent_js)
    js << "\n</script>"
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

    def to_html(id=nil, options={})
      path = File.expand_path('../../templates/table_div.erb', __FILE__)
      template = File.read(path)
      id ||= SecureRandom.uuid
      table_script = show_script(id, script_tag: false)
      ERB.new(template).result(binding)
    end

    def show_in_iruby(dom=SecureRandom.uuid)
      IRuby.html(to_html(dom))
    end
  end # module Display end

  class DataTable
    include display
  end
end
