class AddDescriptionToEvents < ActiveRecord::Migration
  def change
	add_column :events, :cookies_key, :text
  end
end
