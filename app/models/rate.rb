class Rate
  include Mongoid::Document
  
  field :value, :type => Float, :default => 0.0
  
  belongs_to :user
  belongs_to :game
  
end
