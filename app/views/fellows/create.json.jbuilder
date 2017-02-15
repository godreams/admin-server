json.fellow do
  json.id @fellow.id
  json.name @fellow.user.name
  json.email @fellow.user.email
  json.phone @fellow.user.phone
end