module DataTables
  class DataTable

    attr_accessor :html_options, :element_id, :options
    def initialize(options={})
      @element_id = options.delete(:element_id) unless options[:element_id].nil?
      @options = options.empty? ? nil : options
    end
  end
end