class Vehicle
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :year, :type => Integer
  field :make, :type => String
  field :model, :type => String
  field :engine, :type => String
  field :transmission, :type => String
  field :drive, :type => String
  field :fuel, :type => String
  field :mileage, :type => Integer
  field :color, :type => String
  belongs_to :user, :index => true
end
