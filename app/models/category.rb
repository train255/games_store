class Category
  include Mongoid::Document
  field :name, type: String

  has_many :games

  validates_presence_of :name

end