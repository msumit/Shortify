class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :short_url
      t.string :long_url
      t.string :creator
      t.string :location

      t.timestamps
    end
  end
end
