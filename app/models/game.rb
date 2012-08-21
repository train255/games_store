class Game
  include Mongoid::Document
  include Mongoid::Timestamps
  
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
  field :price, type: Float, default: 0
  field :like, type: Boolean, default: false
  field :link, type: String

  belongs_to :category
  validates :name, :category, presence: true
  delegate :name, to: :category, prefix: true, allow_nil: true
  has_many :comments
  has_many :game_images

  def self.names_ids
    all.map { |sc| ["#{sc.category_name} > #{sc.name}", sc.id] }.sort_by { |x| x.first }
  end

  def self.game_hot
    Game.find(:all, :conditions => { is_hot: true })
  end

  def game_related
    Game.where(category_id: self.category_id) - [self]
  end 
  
  def self.game_new
    Game.desc(:created_at)
  end
end
