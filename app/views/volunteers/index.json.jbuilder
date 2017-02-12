json.volunteers @volunteers do |volunteer|
  json.id volunteer.id
  json.name volunteer.user.name
  json.email volunteer.user.email
  json.phone volunteer.user.phone
end