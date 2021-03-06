class OdometerReading
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :value, :type => Integer
  field :entry_date, :type => Date, :index => true
  belongs_to :vehicle, :index => true

  validates :value, numericality: { only_integer: true }
  validates :value, length: { maximum: 7 }
end
