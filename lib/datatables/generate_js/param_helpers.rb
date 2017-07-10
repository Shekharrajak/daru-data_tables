module DataTables
  module ParamHelpers
    def js_parameters(options)
      return "" if options.nil?

      attributes = options.collect { |(key, value)| "#{key}: #{typecast(value)}" }
      "{" + attributes.join(", ") + "}"
    end
  end # module ParamHelpers end
end