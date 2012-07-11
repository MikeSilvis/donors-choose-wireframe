class AddDonorsChooseIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :donors_choose_id, :string
  end
end
