class CreateApplications < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :service
      t.string :email
      t.string :full_name
      t.text :question
      t.boolean :bank_customer
      t.integer :bank_account
      t.date :date
      t.time :time
      t.integer :operator_id
      t.string :aasm_state

      t.timestamps
    end
  end
end

