class AddGenreIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :genre_id, :integer
  end
end
