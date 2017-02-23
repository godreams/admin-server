class ApplicationPdf < Prawn::Document
  include Prawn::Measurements

  def initialize
    super(margin: 0, page_size: 'A4')
  end
end
