json.user do
  json.name @user_role.user.name
  json.role @user_role.class.name
  json.auth_token JsonWebTokenService.encode(user_id: @user_role.user.id)
end