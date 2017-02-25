json.receipt do
  json.number @donation.id
  json.date @donation.final_approval.created_at
  json.pdf_base64 @receipt_pdf
end
