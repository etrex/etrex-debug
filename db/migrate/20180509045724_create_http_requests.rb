class CreateHttpRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :http_requests do |t|
      t.string :url
      t.string :method
      t.jsonb :params
      t.jsonb :headers
      t.string :body
      t.string :ip

      t.timestamps
    end
  end
end
