class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :graduate_application
      t.string :name
      t.string :description
      t.string :file_ref

      t.timestamps
    end
  end
end
