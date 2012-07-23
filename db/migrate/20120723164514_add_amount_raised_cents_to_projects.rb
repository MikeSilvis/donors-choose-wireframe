class AddAmountRaisedCentsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :amount_raised_cents, :integer
  end
end
