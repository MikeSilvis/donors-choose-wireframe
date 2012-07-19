class AddDisplayHtmlToChallengeEvidences < ActiveRecord::Migration
  def change
    add_column :challenge_evidences, :display_html, :string
  end
end
