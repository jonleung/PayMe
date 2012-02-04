class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :name
      t.string :email
      t.text :description

      t.timestamps
    end
  end
end
