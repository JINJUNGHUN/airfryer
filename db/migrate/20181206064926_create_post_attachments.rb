class CreatePostAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :post_attachments do |t|
      t.integer :post_id
      t.string :image

      t.timestamps
    end
  end
end
