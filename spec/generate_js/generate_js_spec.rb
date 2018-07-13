require 'spec_helper.rb'

describe Daru::DataTables::JsHelpers do
  before do
    @array_large = []
    for i in 0..50000
      @array_large << i
    end
  end
  let(:data_array) { 
    [
      ['2013', 1000, 400, 1]
    ]
  }
  let(:vec) { Daru::Vector.new([1, 2, 3], name: :a) }
  let(:vec_large) { Daru::Vector.new(@array_large, name: :a) }
  let(:df) { 
    Daru::DataFrame.new(
      { b: [11,12,13], a: [1,2,3], c: [11,22,33]},
      order: [:a, :b, :c],
      index: [:one, :two, :three]
    )
  }
  let(:df_large) {
    Daru::DataFrame.new(
      { b: @array_large}
    )
  }
  let(:opts1) {
    {
      html_options: {
        table_options: {
          table_thead: "<thead>
                      <tr>
                        <th></th>
                        <th>C1</th>
                      </tr>
                    </thead>",
          width: '90%'
        }
      },
      scrollX: true
    }
  }
  let(:opts2) {
    {
      html_options: {
        table_options: {
          cellspacing: '0'
        }
      }
    }
  }
  let(:opts3) {{searching: false}}
  let(:table_array) { Daru::DataTables::DataTable.new(data_array, opts1) }
  let(:table_dv) { Daru::DataTables::DataTable.new(vec, opts2) }
  let(:table_df) { Daru::DataTables::DataTable.new(df) }
  let(:table_array_large) {
    Daru::DataTables::DataTable.new(@array_large, opts3)
  }
  let(:table_dv_large) { Daru::DataTables::DataTable.new(vec_large) }
  let(:table_df_large) { Daru::DataTables::DataTable.new(df_large) }

  describe "#draw_js" do
    it "calls other methods if data length is more than 50000" do
      expect(table_df_large).to receive(:extract_data_array)
      expect(table_df_large).to receive(:draw_ajax_option)
      table_df_large.draw_js('id')
    end
    it "does not call other methods if data length is less than 50000" do
      expect(table_df).to_not receive(:extract_data_array)
      expect(table_df).to_not receive(:draw_ajax_option)
      table_df.draw_js('id')
    end
    it "generates script using client-side processing for data less than 50000" do
      js = table_dv.draw_js('id')
      expect(js).to match(/\$\(document\).ready\(function\(\) \{/)
      expect(js).to match(/\$\('#id'\).DataTable\(/)
      expect(js).to match(/\{data: \[\[0,1\],\[1,2\],\[2,3\]\]\}/)
    end
    it "generates script using server-side processing for data more than 50000" do
      js = table_dv_large.draw_js('id')
      expect(js).to match(/var data_array = \[\[0, 0\],/)
      expect(js).to match(/\$\('#id'\).DataTable\(/)
      expect(js).to match(/serverSide: true, ajax:/)
      expect(js).to match(/out.push\( data_array\[i\] \);/)
      expect(js).to match(/callback\( \{/)
    end
  end

  describe "#draw_js_iruby" do
    it "calls other methods if data length is more than 50000" do
      expect(table_df_large).to receive(:extract_data_array)
      expect(table_df_large).to receive(:draw_ajax_option)
      table_df_large.draw_js_iruby('id')
    end
    it "does not call other methods if data length is less than 50000" do
      expect(table_df).to_not receive(:extract_data_array)
      expect(table_df).to_not receive(:draw_ajax_option)
      table_df.draw_js_iruby('id')
    end
    it "generates script using client-side processing for data less than 50000" do
      js = table_dv.draw_js_iruby('id')
      expect(js).to match(/\$\( function \(\) \{/)
      expect(js).to match(/\$\('#id'\).DataTable\(/)
      expect(js).to match(/\{data: \[\[0,1\],\[1,2\],\[2,3\]\]\}/)
    end
    it "generates script using server-side processing for data more than 50000" do
      js = table_dv_large.draw_js_iruby('id')
      expect(js).to match(/var data_array = \[\[0, 0\],/)
      expect(js).to match(/\$\('#id'\).DataTable\(/)
      expect(js).to match(/serverSide: true, ajax:/)
      expect(js).to match(/if \(i < data_array.length\) \{/)
      expect(js).to match(/out.push\( data_array\[i\] \);/)
      expect(js).to match(/callback\( \{/)
    end
  end

  describe "#extract_data_array" do
    it "returns the data array" do
      expect(table_array.extract_data_array).to eq([[0, "2013", 1000, 400, 1]])
    end
  end

  describe "#draw_ajax_option" do
    it "sets serverSide option" do
      table_array_large.draw_ajax_option
      expect(table_array_large.options).to include(:serverSide=>true)
    end
    it "sets ajax option" do
      table_array_large.draw_ajax_option
      expect(table_array_large.options).to include(:ajax)
    end
  end

  describe "#set_callback_ajax" do
    it "returns callback js" do
      js = table_df_large.set_callback_ajax
      expect(js).to match(/callback\( \{/)
      expect(js).to match(/draw: data.draw,/)
      expect(js).to match(/data: out,/)
      expect(js).to match(/recordsTotal: data_array.length,/)
      expect(js).to match(/recordsFiltered: data_array.length,/)
    end
  end
end
