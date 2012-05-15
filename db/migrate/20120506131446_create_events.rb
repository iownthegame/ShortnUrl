class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :url_ori
      t.string :url_hash

      t.timestamps
    end
  end
end
