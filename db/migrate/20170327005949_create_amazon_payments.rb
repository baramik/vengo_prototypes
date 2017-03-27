class CreateAmazonPayments < ActiveRecord::Migration
  def change
    create_table :amazon_payments do |t|
      t.string :client_id
      t.timestamps null: false
    end
  end
end
