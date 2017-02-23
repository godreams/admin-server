class ApplicationPdf < Prawn::Document
  def initialize
    super(margin: 0, page_size: 'A4')
    default_leading 10
    font 'Times-Roman'
  end
end
