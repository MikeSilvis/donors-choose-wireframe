class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :proposal_url
      t.string :fund_url
      t.string :image_url
      t.string :title
      t.text   :short_description
      t.text   :fulfillment_trailer
      t.string :percent_funded
      t.string :cost_to_complete
      t.string :total_price
      t.string :free_shipping
      t.string :teacher_name
      t.string :grade_level
      t.string :poverty_level
      t.string :school_name
      t.string :city
      t.string :zip
      t.string :state_abbr
      t.string :latitude
      t.string :longitude
      t.string :state
      t.string :subject
      t.string :resource_type
      t.string :expiration_date
      t.string :funding_status


      t.timestamps
    end
  end
end
