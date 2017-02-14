json.coaches @coaches do |coach|
  json.id coach.id
  json.name coach.user.name
  json.email coach.user.email
  json.phone coach.user.phone
end