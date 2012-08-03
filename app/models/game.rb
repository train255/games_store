class Game
  include Mongoid::Document
  field :name, type: String
  field :info, type: String

  field :banner_uid
  field :banner_name
  image_accessor :banner
  field :description, type: String # hien thi tren banner & javascrip

  field :cover_image_uid
  field :cover_image_name
  image_accessor :cover_image

  field :is_hot, type: Boolean, default: false
  field :price, type: Float
  field :like, type: Boolean, default: false
  field :category, type: String
  field :link, type: String

  # has_many :game_images, autosave: true

  def self.game_hot
    Game.find(:all, :conditions => { is_hot: true })
  end
end

