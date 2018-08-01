class String
  def js_code(true_or_false=true)
    @_datatables_js_code = true_or_false
    self
  end

  def js_code?
    @_datatables_js_code || false
  end
end
