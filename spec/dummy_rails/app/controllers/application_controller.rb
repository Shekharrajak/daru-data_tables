class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def datatables
    @table = Daru::DataTables::DataTable.new()
    @df = Daru::DataFrame.new({b: [11,12,13,14,15], a: [1,2,3,4,5],
      c: [11,22,33,44,55]},
      order: [:a, :b, :c],
      index: [:one, :two, :three, :four, :five])
    @df_table_script = Daru::DataTables::DataTable.new()
    @html_code = ''
    @html_code << @df_table_script.to_js('table_id1')

    t = Daru::DataTables::DataTable.new(pageLength: 4)
    table_opts = {
      class: "display",
      cellspacing: "0",
      width: "100%"
      }
    options = {
        table_options: table_opts
    }
    options[:table_options][:table_html] = @df.to_html_thead + @df.to_html_tbody
    @html_code2 = t.to_html(id='table_id2', options)

    t_opts = {
        data: [[1,1,1],
          [1,2,3],
          [11,12,13],
          [1,2,3],
          [11,12,13],
          [1,2,3],
          [11,12,13]
        ],
        pageLength: 4
    }
    table_from_array = Daru::DataTables::DataTable.new(t_opts)
    table_opts = {
      class: "display",
      cellspacing: "0",
      width: "50%",
      table_html: "
      <thead>
            <tr>
                <th>Num1 </th>
                <th>Num2 </th>
                <th>Num3 </th>
            </tr>
        </thead>"
      }
    options = {
        table_options: table_opts
    }
    @html_code_array_sorted = table_from_array.to_html(id='table_id3', options)

    t_opts[:ordering] = false
    table_from_array = Daru::DataTables::DataTable.new(t_opts)
    table_opts = {
      class: "display",
      cellspacing: "0",
      width: "50%",
      table_html: "
      <thead>
            <tr>
                <th>Num1 </th>
                <th>Num2 </th>
                <th>Num3 </th>
            </tr>
        </thead>"
      }
    options = {
        table_options: table_opts
    }
    @html_code_array = table_from_array.to_html(id='table_id4', options)

  end
end
