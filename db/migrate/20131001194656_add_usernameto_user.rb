class AddUsernametoUser < ActiveRecord::Migration
	def up
	  add_column :users, :name, :string
	  add_column :users, :admin, :boolean, :default => nil
	end

	def down
	   
	end
end
