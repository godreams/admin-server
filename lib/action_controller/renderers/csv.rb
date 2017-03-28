ActionController::Renderers.add :csv do |object, options|
  filename = options[:filename] || 'export'
  response = CsvExportService.new(object).export
  send_data(response, type: Mime[:csv], disposition: "attachment; filename=#{filename}.csv")
end
