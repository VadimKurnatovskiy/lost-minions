class AddCallAvailabilityToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :call_time_from, :datetime
    add_column :users, :call_time_to, :datetime
  end
end
