class CreateCategory < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.text :title
    end
  end
end
