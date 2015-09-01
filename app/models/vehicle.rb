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

  validates :year,
            :make,
            :model, presence: true
  validates :year,
            :mileage, numericality: { only_integer: true }
  validates :year, length: { maximum: 4 }
  validates :mileage, length: { maximum: 7 }
end
