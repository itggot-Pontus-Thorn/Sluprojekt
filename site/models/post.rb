class Post
  include DataMapper::Resource

  property :id, Serial
  property :title, String, required: true
  property :category, String, required: true
  property :content, Text, required: true
  property :created_at, DateTime

  belongs_to :admin
  has n, :comments
end