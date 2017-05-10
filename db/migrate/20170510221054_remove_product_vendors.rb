class RemoveProductVendors < ActiveRecord::Migration[5.0]
  def change
    drop_table :product_vendors
    drop_table :ztblpurchasecoupons
    drop_table :orders
    drop_table :order_details
  end
end
