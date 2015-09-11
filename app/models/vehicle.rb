class Vehicle
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :name, :type => String
  field :vin, :type => String
  field :year, :type => Integer
  field :make, :type => String
  field :model, :type => String
  field :engine, :type => String
  field :transmission, :type => String
  field :drive, :type => String
  field :fuel, :type => String
  field :color, :type => String
  belongs_to :user, :index => true
  has_many :odometer_readings

  validates :name,
            :year,
            :make,
            :model, presence: true
  validates :year, numericality: { only_integer: true }
  validates :year, length: { maximum: 4 }
  validates :vin, length: { is: 17 }, allow_blank: true
end
