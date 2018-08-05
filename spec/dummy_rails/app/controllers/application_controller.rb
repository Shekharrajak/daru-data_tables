class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def datatables
    data = [
            ['2013', 1000, 400, 1, 1, 1, 1, 1, 1, 1],
            ['2014', 1170, 460, 5, 2, 2, 2, 2, 2, 2],
            ['2015', 660, 1120, 3, 3, 3, 3, 3, 3, 3],
            ['2016', 1030, 540, 4, 4, 4, 4, 4, 4, 4]
    ]
    data1 = []
    for i in 0..100000
      data1 << i
    end
    vec = Daru::Vector.new([1, 2, 3], name: :a)
    df = Daru::DataFrame.new(
      { b: [11,12,13,14,15], a: [1,2,3,4,5], c: [11,22,33,44,55] },
      order: [:a, :b, :c],
      index: [:one, :two, :three, :four, :five]
    )

    options = {
      searching: false,
      pageLength: 7
    }
    options2 = {
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
      }
    }
    options3 = {
      scrollX: true,
      html_options: {
        table_options: {
          cellspacing: '0',
          width: "100%"
        }
      }
    }

    @table_array_large = Daru::View::DataTable.new(data1, options)
    @table_dv = Daru::View::DataTable.new(vec, options2)
    @table_array = Daru::View::DataTable.new(data, options3)
    @table_df = Daru::View::DataTable.new(df)
    render "datatables" , layout: "application"
  end

  def datatables_bunch_js
    df = Daru::DataFrame.new(
      { b: [11,12,13,14,15], a: [1,2,3,4,5], c: [11,22,33,44,55] },
      order: [:a, :b, :c],
      index: [:one, :two, :three, :four, :five]
    )
    @table_df = Daru::View::DataTable.new(df)
    render "datatables_bunch_js" , layout: "datatables"
  end
end
