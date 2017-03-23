class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :location
      t.float :funding_goal
      t.text :description
      t.references :category
      t.string :facebook_url
      t.string :website
      t.boolean :active
      t.string :risks
    	t.string :future_plans
    	t.string :short_description
    	t.integer :backers_total,:default=>0
    	t.float :raised_amount, :float,:default=>0
    	t.references :user
      t.timestamps
    end
  end
end
