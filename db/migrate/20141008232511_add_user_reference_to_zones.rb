class AddUserReferenceToZones < ActiveRecord::Migration
  def change
    add_reference :zones, :user, index: true
  end
end
