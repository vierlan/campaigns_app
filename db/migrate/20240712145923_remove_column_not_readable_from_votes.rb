class RemoveColumnNotReadableFromVotes < ActiveRecord::Migration[7.1]
  def change
    remove_column :votes, :not_readable, :boolean
    remove_column :votes, :timestamp, :integer
  end
end
