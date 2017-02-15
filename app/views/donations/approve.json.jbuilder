json.donation do
  json.id @donation.id
  json.status @donation.status_string
  json.approvable @donation.approvable?(current_user_role)
end