module Donations
  class ReceiptPdf < ApplicationPdf
    def initialize(donation)
      @donation = donation
      super()
    end

    def build
      add_background_image
      font_size 15
      add_donor_details
    end

    private

    def add_background_image
      background_image_path = File.join(File.absolute_path(File.dirname(__FILE__)), 'receipt_background.jpg')
      image background_image_path, scale: 0.4622
      move_up bounds.height
    end

    def add_donor_details
      # Name
      draw_text @donation.name, at: [mm2pt(43), mm2pt(216)]

      # Contact number
      draw_text @donation.phone, at: [mm2pt(41), mm2pt(203)]

      # Email ID
      draw_text @donation.email, at: [mm2pt(35), mm2pt(190)]

      # Address
      text_box @donation.address, at: [mm2pt(34), mm2pt(180)], height: mm2pt(15), width: mm2pt(160), overflow: :shrink_to_fit

      # PAN
      draw_text @donation.pan, at: [mm2pt(46), mm2pt(157)] if @donation.pan.present?
    end
  end
end
