class AddGenresIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :genres_id, :integer
  end
end
