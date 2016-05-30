class Visitor
  include DataMapper::Resource

  property :id, Serial

  # has n, :comments
end