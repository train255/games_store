class Payment
  include Mongoid::Document
  field :card_number
  # field :expiration_date
  field :first_name
  field :middle_name
  field :last_name
  field :address_line_1
  field :address_line_2
  field :city
  field :postal_code
  field :telephone
  field :email

  validates_presence_of :card_number, :first_name, :last_name, 
                        :address_line_1, :postal_code
end