class ZoneSerializer < ActiveModel::Serializer
  attributes :id, :name, :city_name, :minutes_offset
end
