class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :pages, :users
  end
end
