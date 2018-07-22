require 'spec_helper.rb'

describe Daru::DataTables do
  describe '.generate_init_code_js' do
    it 'loads datatables dependent js files' do
      js = Daru::DataTables.generate_init_code_js([
        'jquery-latest.min.js', 'jquery.dataTables.js'
      ])
      expect(js).to match(/BEGIN jquery-latest.min.js/)
      expect(js).to match(/END jquery-latest.min.js/)
      expect(js).to match(/BEGIN jquery.dataTables.js/)
      expect(js).to match(/END jquery.dataTables.js/)
    end
  end

  describe '.generate_init_code_css' do
    it 'loads datatables dependent js files' do
      css = Daru::DataTables.generate_init_code_css(['jquery.dataTables.css'])
      expect(css).to match(/BEGIN jquery.dataTables.css/)
      expect(css).to match(/END jquery.dataTables.css/)
    end
  end
end
