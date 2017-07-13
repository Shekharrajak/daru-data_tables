class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def datatables
    @table = DataTables::DataTable.new()
    @df = Daru::DataFrame.new({b: [11,12,13,14,15], a: [1,2,3,4,5],
      c: [11,22,33,44,55]},
      order: [:a, :b, :c],
      index: [:one, :two, :three, :four, :five])
    @df_table_script = DataTables::DataTable.new()
    @html_code = ''
    @html_code << @df_table_script.to_js('table_id1')

  end


end
