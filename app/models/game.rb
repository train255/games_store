class Game
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::FullTextSearch
  
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
  # field :rate_average, type: Float, default: 0
  field :link, type: String

  belongs_to :category
  validates :name, :category, presence: true
  delegate :name, to: :category, prefix: true, allow_nil: true
  has_many :comments
  has_many :game_images, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :game_images
  has_many :rates

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
  
  def average_rating
    if rates.count > 0
      rates.map { |rate| rate.value }.inject{ |sum, el| sum + el }.to_f / rates.count
    else
      0
    end
  end
  
  # Can phai chay lenh object.update_attributes()
  # Game.all.each do |g|
  #   g.update_attributes()
  # end
  fulltext_search_in :name
end
