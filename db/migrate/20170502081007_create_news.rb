class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :title, null: false, default: ''
      t.text :annotation
      t.boolean :from_yandex, default: true
      t.timestamp :date
      t.timestamp :published_at
    end
  end
end
