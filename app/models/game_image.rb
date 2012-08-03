class GameImage
  include Mongoid::Document

  field :image_uid
  image_accessor :image

  belongs_to :game

  def image_url(size = "200x200")
    "http://#{Settings.host}#{image.thumb(size).url}" if image
  end
end
