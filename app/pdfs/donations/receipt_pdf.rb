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
      add_donation_details
      add_receipt_details

      self
    end

    private

    def add_background_image
      background_image_path = File.join(File.absolute_path(File.dirname(__FILE__)), 'receipt_background.jpg')
      image background_image_path, scale: 0.4622
      move_up bounds.height
    end

    def add_donor_details
      # Name.
      draw_text @donation.name, at: [mm2pt(43), mm2pt(216)]

      # Contact number.
      draw_text @donation.phone, at: [mm2pt(41), mm2pt(203)]

      # Email ID.
      draw_text @donation.email, at: [mm2pt(35), mm2pt(190)]

      # Address.
      if @donation.address.present?
        text_box @donation.address, at: [mm2pt(34), mm2pt(180)], height: mm2pt(15), width: mm2pt(160), overflow: :shrink_to_fit
      end

      # PAN.
      if @donation.pan.present?
        draw_text @donation.pan, at: [mm2pt(46), mm2pt(157)] if @donation.pan.present?
      end
    end

    def add_donation_details
      # Amount as a number.
      draw_text "#{@donation.amount} /-", at: [mm2pt(62), mm2pt(128)]

      # Amount in words.
      amount_in_words = @donation.amount.to_words(hundreds_with_union: true).titleize + ' Only'
      text_box amount_in_words, at: [mm2pt(46), mm2pt(118)], height: mm2pt(15), width: mm2pt(140), overflow: :shrink_to_fit
    end

    def add_receipt_details
      # Receipt number.
      draw_text @donation.id, at: [mm2pt(167), mm2pt(245)]

      # Receipt date.
      receipt_date = @donation.final_approval.created_at.strftime('%d/%m/%Y')
      draw_text receipt_date, at: [mm2pt(171), mm2pt(235)]
    end
  end
end
