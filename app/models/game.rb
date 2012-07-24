class Game
  include Mongoid::Document
  field :name, type: String
  field :info, type: String
end
