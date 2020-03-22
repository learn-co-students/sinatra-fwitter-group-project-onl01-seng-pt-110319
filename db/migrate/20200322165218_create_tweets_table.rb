class CreateTweetsTable < ActiveRecord::Migration[6.0]
  def change
    creat_table :tweets do |t|
      t.string :content
      t.integer :user_id
    end
  end
end
