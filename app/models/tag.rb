class Tag

  include DataMapper::Resource

  has n, :link, through: Resource

  property :id, Serial
  property :name, String

end
