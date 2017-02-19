json.user do
  json.name @user.name
  json.roles @user.roles_array
  json.auth_token JsonWebTokenService.encode(user_id: @user.id)
end
