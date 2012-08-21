class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  # field :name ,type: String
  # field :email ,type: String
  field :content ,type: String
  
  belongs_to :game
  belongs_to :user
end