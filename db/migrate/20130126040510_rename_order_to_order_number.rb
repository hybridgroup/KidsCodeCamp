class RenameOrderToOrderNumber < ActiveRecord::Migration
	change_table :lessons do |t|
	  t.rename :order, :order_number
	end

end
