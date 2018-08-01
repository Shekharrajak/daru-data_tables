require 'spec_helper.rb'

describe Daru::View do
  describe '.init_javascript' do
    it 'loads datatables dependent js files' do
      js = Daru::View.init_javascript
      expect(js).to match(/BEGIN jquery-latest.min.js/)
      expect(js).to match(/END jquery-latest.min.js/)
      expect(js).to match(/BEGIN jquery.dataTables.js/)
      expect(js).to match(/END jquery.dataTables.js/)
    end
  end

  describe '.init_css' do
    it 'loads datatables dependent js files' do
      css = Daru::View.init_css
      expect(css).to match(/BEGIN jquery.dataTables.css/)
      expect(css).to match(/END jquery.dataTables.css/)
    end
  end

  describe '.init_script' do
    it 'loads datatables dependent js files' do
      script = Daru::View.init_script
      expect(script).to match(/BEGIN jquery-latest.min.js/)
      expect(script).to match(/END jquery-latest.min.js/)
      expect(script).to match(/BEGIN jquery.dataTables.js/)
      expect(script).to match(/END jquery.dataTables.js/)
      expect(script).to match(/BEGIN jquery.dataTables.css/)
      expect(script).to match(/END jquery.dataTables.css/)
    end
  end
end

describe Daru::View::Display do
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
  let(:table_array) { Daru::View::DataTable.new(data_array, opts1) }
  let(:table_dv) { Daru::View::DataTable.new(vec, opts2) }
  let(:table_df) { Daru::View::DataTable.new(df) }
  let(:table_array_large) {
    Daru::View::DataTable.new(@array_large, opts3)
  }
  let(:table_dv_large) { Daru::View::DataTable.new(vec_large) }
  let(:table_df_large) { Daru::View::DataTable.new(df_large) }

  describe '#to_html' do
    context 'when small dataset of array is used as data' do
      subject(:js) {table_array.to_html('id')}
      it 'generates the valid script of the table' do
        expect(js).to match(/\$\('#id'\).DataTable\(/)
        expect(js).to match(
          /\{scrollX: true, data: \[\[0,"2013",1000,400,1\]\]\}/
        )
      end

      it 'generates the html table with thead' do
        expect(js).to match(/<table width="90%" id="id" class="display">/)
        expect(js).to match(/<tr>/)
        expect(js).to match(/<th><\/th>/)
        expect(js).to match(/<th>C1<\/th>/)
      end
    end

    context 'when large dataset of array is used as data' do
      subject(:js) {table_array_large.to_html('id')}
      it 'generates the valid script of the table' do
        expect(js).to match(/var data_array = \[\[0, 0\],/)
        expect(js).to match(/\$\('#id'\).DataTable\(/)
        expect(js).to match(/searching: false, serverSide: true, ajax:/)
        expect(js).to match(/out.push\( data_array\[i\] \);/)
        expect(js).to match(/callback\( \{/)
      end

      it 'generates the html table with thead' do
        expect(js).to match(
          /<table class="display" cellspacing="0" width="100%" id="id">/
        )
        expect(js).to match(/<th><\/th>/)
        expect(js).to match(/<th>Column: 0<\/th>/)
      end
    end

    context 'when small data set of Daru::Vector is used as data' do
      subject(:js) {table_dv.to_html('id')}
      it 'generates the valid script of the table' do
        expect(js).to match(/\$\('#id'\).DataTable\(/)
        expect(js).to match(/\{data: \[\[0,1\],\[1,2\],\[2,3\]\]\}/)
      end

      it 'generates the html table with thead' do
        expect(js).to match(/<table cellspacing="0" id="id" class="display">/)
        expect(js).to match(/<tr>/)
        expect(js).to match(/<th> <\/th>/)
        expect(js).to match(/<th>a<\/th>/)
      end
    end

    context 'when large dataset of Daru::Vector is used as data' do
      subject(:js) {table_dv_large.to_html('id')}
      it 'generates the valid script of the table' do
        expect(js).to match(/var data_array = \[\[0, 0\],/)
        expect(js).to match(/\$\('#id'\).DataTable\(/)
        expect(js).to match(/serverSide: true, ajax:/)
        expect(js).to match(/out.push\( data_array\[i\] \);/)
        expect(js).to match(/callback\( \{/)
      end

      it 'generates the html table with thead' do
        expect(js).to match(
          /<table class="display" cellspacing="0" width="100%" id="id">/
        )
        expect(js).to match(/<th> <\/th>/)
        expect(js).to match(/<th>a<\/th>/)
      end
    end

    context 'when small data-set of Daru::DataFrame is used as data' do
      subject(:js) {table_df.to_html('id')}
      it 'generates the valid script of the table' do
        expect(js).to match(/\$\('#id'\).DataTable\(/)
        expect(js).to match(
          /\{data: \[\[0,1,11,11\],\[1,2,12,22\],\[2,3,13,33\]\]}/
        )
      end

      it 'generates the html table with thead' do
        expect(js).to match(
          /<table class="display" cellspacing="0" width="100%" id="id">/
        )
        expect(js).to match(/<th><\/th>/)
        expect(js).to match(/<th>a<\/th>/)
        expect(js).to match(/<th>b<\/th>/)
        expect(js).to match(/<th>c<\/th>/)
      end
    end

    context 'when large data-set pf Daru::DataFrame is used as data' do
      subject(:js) {table_df_large.to_html('id')}
      it 'generates the valid script of the table' do
        expect(js).to match(/var data_array = \[\[0, 0\],/)
        expect(js).to match(/\$\('#id'\).DataTable\(/)
        expect(js).to match(/serverSide: true, ajax:/)
        expect(js).to match(/out.push\( data_array\[i\] \);/)
        expect(js).to match(/callback\( \{/)
      end

      it 'generates the html table with thead' do
        expect(js).to match(
          /<table class="display" cellspacing="0" width="100%" id="id">/
        )
        expect(js).to match(/<th><\/th>/)
        expect(js).to match(/<th>b<\/th>/)
      end
    end
  end

  describe "#show_script" do
    context "with script_tag" do
      it 'calls to_js method' do
        expect(table_df).to receive(:to_js)
        table_df.show_script('id', script_tag: true)
      end
    end
    context "without script_tag" do
      it 'returns script of the table' do
        js = table_df.show_script('id', script_tag: false)
        expect(js).to match(/\$\('#id'\).DataTable\(/)
        expect(js).to match(
          /\{data: \[\[0,1,11,11\],\[1,2,12,22\],\[2,3,13,33\]\]\}/
        )
      end
    end
  end

  describe "#to_js" do
    it "returns script of the table with script_tag" do
      js = table_dv.to_js('id')
      expect(js).to match(/script/)
      expect(js).to match(/\$\('#id'\).DataTable\(/)
      expect(js).to match(
        /\{data: \[\[0,1\],\[1,2\],\[2,3\]\]\}/
      )
    end
  end
end
