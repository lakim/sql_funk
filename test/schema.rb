ActiveRecord::Schema.define(:version => 0) do
  create_table :subscribers, :force => true do |t|
    t.string :name
    t.datetime :created_at
    t.datetime :updated_at
  end
end