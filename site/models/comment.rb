class Comment
  include DataMapper::Resource

  property :id, Serial
  property :name, String, required: true
  property :email, String, required: true
  property :content, Text, required: true

  belongs_to :post
  belongs_to :visitor
end