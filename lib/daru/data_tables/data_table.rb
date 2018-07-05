module Daru
  module DataTables
    class DataTable
      attr_accessor :html_options, :element_id, :options, :data
      def initialize(options={})
        @element_id = options.delete(:element_id) unless options[:element_id].nil?
        @options = options
      end
    end
  end
end
