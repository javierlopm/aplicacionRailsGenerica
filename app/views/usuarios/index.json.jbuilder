json.array!(@usuarios) do |usuario|
  json.extract! usuario, :id, :usuario, :password, :alias, :email
  json.url usuario_url(usuario, format: :json)
end
