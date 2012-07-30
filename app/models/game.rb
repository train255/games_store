class Game
  include Mongoid::Document
  field :name, type: String
  field :info, type: String
  
  field :cover_image_uid
  field :cover_image_name
  image_accessor :cover_image

end
