class GameImage
  include Mongoid::Document

  field :image_uid
  image_accessor :image

  belongs_to :game

  def image_url(version = :game)
    "http://#{Settings.host}#{image.send(version).url}"
  end
end
