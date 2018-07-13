require 'spec_helper.rb'

describe 'DataTable' do
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
  let(:df) { 
    Daru::DataFrame.new(
      { b: [11,12,13,14,15], a: [1,2,3,4,5], c: [11,22,33,44,55]},
      order: [:a, :b, :c],
      index: [:one, :two, :three, :four, :five]
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

  describe 'Initialization of DataTables' do
    context "when Array is used as data" do
      it 'sets correct attributes for small dataset' do
        expect(table_array.data).to eq(data_array)
        expect(table_array.options).to eq(
          {:scrollX=>true, :data=>[[0, "2013", 1000, 400, 1]]}
        )
        expect(table_array.html_options).to eq(:table_options => {
          :table_thead=>"<thead>\n                      <tr>\n                "\
          "        <th></th>\n                        <th>C1</th>\n           "\
          "           </tr>\n                    </thead>", :width=>"90%"
        })
      end

      it 'sets correct attributes for large dataset' do
        expect(table_array_large.data).to eq(@array_large)
        expect(table_array_large.options).to include(:searching=>false)
        # set default html_options
        expect(table_array_large.html_options).to eq(
          :table_options => {:class=>"display", :cellspacing=>"0", :width=>"100%"}
        )
      end
    end

    context "when Daru::DataFrame is used as data" do
      it 'sets correct attributes' do
        expect(table_df.data).to eq(df)
        expect(table_df.options).to eq(
          {:data=>[[0, 1, 11, 11], [1, 2, 12, 22], [2, 3, 13, 33],
                   [3, 4, 14, 44], [4, 5, 15, 55]]
          }
        )
        # set default html_options
        expect(table_df.html_options).to eq(
          :table_options => {:class=>"display", :cellspacing=>"0", :width=>"100%"}
        )
      end
    end

    context "when Daru::Vector is used as data" do
      it 'sets correct attributes' do
        expect(table_dv.data).to eq(vec)
        expect(table_dv.options).to eq({:data => [[0, 1], [1, 2], [2, 3]]})
        expect(table_dv.html_options).to eq(:table_options => {:cellspacing=>"0"})
      end
    end
  end
end
