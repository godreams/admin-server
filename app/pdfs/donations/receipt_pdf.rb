module Donations
  class ReceiptPdf < ApplicationPdf
    def initialize(donation)
      @donation = donation
      super()
    end

    def build
      background_image_path = File.join(File.absolute_path(File.dirname(__FILE__)), 'receipt_background.jpg')
      image background_image_path, scale: 0.4622
      move_up bounds.height
      move_down 300
      text 'Add actual text content', align: :center, inline_format: true, size: 15
    end
  end
end
