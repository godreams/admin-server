json.donations @donations do |donation|
  json.id donation.id
  json.name donation.name
  json.amount donation.amount
  json.created_at donation.created_at.strftime('%b %e %Y, %l:%M %p')
  json.status 'Pending Coach Approval'
end