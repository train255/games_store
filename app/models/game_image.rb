class GameImage
  include Mongoid::Document

  field :image_uid
  field :image_name
  image_accessor :image

  belongs_to :game
end
