class AddColumnsToPage < ActiveRecord::Migration
  def change
    add_column :pages, :url,         :string, null: false
    add_column :pages, :title,       :string, null: false
    add_column :pages, :description, :text
    add_column :pages, :identifier,  :uuid,   default: "uuid_generate_v4()"
  end
end
