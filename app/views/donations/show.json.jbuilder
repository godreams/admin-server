json.(@donation, :name, :email, :phone, :amount)

json.volunteer do
  json.name @donation.volunteer.user.name
end