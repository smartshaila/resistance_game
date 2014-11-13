json.array!(@role_relationships) do |role_relationship|
  json.extract! role_relationship, :id, :role_id, :revealed_role_id, :revealed_faction
  json.url role_relationship_url(role_relationship, format: :json)
end
