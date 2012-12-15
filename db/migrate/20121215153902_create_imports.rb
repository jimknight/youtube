class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.string :url
      t.string :status

      t.timestamps
    end
  end
end
