json.volunteer do
  json.id @volunteer.id
  json.name @volunteer.user.name
  json.email @volunteer.user.email
  json.phone @volunteer.user.phone
end