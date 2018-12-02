module Daru
  module View
    class Engine < ::Rails::Engine; end if defined?(Rails)
    class DataTable
      attr_accessor :html_options, :element_id, :options, :data
      # @param data [Array, Daru::DataFrame, Daru::Vector] The data provided
      #   by the user to generate the datatable
      # @param options [Hash] Various options provided by the user to
      #   incorporate in datatable
      # @return Initializes the Daru::DataTables::DataTable object
      # @example
      #   vec = Daru::Vector.new([1, 2, 3], name: :a)
      #   opts = {searching: false}
      #   table = Daru::DataTables::DataTable.new(vec, opts)
      def initialize(data=[], options={})
        @element_id = options.delete(:element_id) unless options[:element_id].nil?
        @html_options = options.delete(:html_options) unless options[:html_options].nil?
        @html_options ||= default_html_options
        @data = data
        @options = options
        @options[:data] = to_data_array(data)
        row_number = 0
        @options[:data].each do |array|
          array.unshift(row_number)
          row_number += 1
        end
      end

      private

      def default_html_options
        table_opts = {
          class: 'display',
          cellspacing: '0',
          width: '100%'
        }
        html_options = {
          table_options: table_opts
        }
        html_options
      end

      # DataTables accept the data as Array of array.
      #
      # TODO : I didn't find use case for Daru::MultiIndex.
      def to_data_array(data_set)
        case
        when data_set.is_a?(Daru::DataFrame)
          return ArgumentError unless data_set.index.is_a?(Daru::Index)

          rows = data_set.access_row_tuples_by_indexs(*data_set.index.to_a)
          convert_to_array_of_array(rows)
        when data_set.is_a?(Daru::Vector)
          rows = []
          data_set.to_a.each { |a| rows << [a] }
          rows
        when data_set.is_a?(Array)
          convert_to_array_of_array(data_set)
        else
          raise ArgumentError, 'Invalid Argument Passed!'
        end
      end

      def convert_to_array_of_array(rows)
        if rows.all? { |row| row.class==Array }
          rows
        else
          tuples = []
          rows.each { |row| tuples << [row] }
          tuples
        end
      end
    end
  end
end
