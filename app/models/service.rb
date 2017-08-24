class Service < ApplicationRecord
  belongs_to :user

  belongs_to :service_man, class_name: 'User', foreign_key: :service_man_id

  ACCEPTED = 'Accepted'
  CANCELLED = 'Cancelled'
  COMPLETED = 'Completed'
  PENDING = 'Pending'
  validates_presence_of :service_name
  validates_presence_of :description
  validates_presence_of :raw_address
  validates_presence_of :phone_no

  attr_accessor :raw_address

  geocoded_by :raw_address
  reverse_geocoded_by :latitude, :longitude

  after_validation -> {
    self.address = self.raw_address
    geocode
  }, if: ->(obj){ obj.raw_address.present? and obj.raw_address != obj.address }

  after_validation :reverse_geocode, unless: ->(obj) { obj.raw_address.present? },
                   if: ->(obj){ obj.latitude.present? and obj.latitude_changed? and obj.longitude.present? and obj.longitude_changed? }
end
