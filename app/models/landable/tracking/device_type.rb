module Landable
  module Tracking
    class DeviceType < ActiveRecord::Base
      self.table_name = 'traffic.device_types'

      lookup_by :device_type, cache: 50, find_or_create: true

      has_many :attributions
    end
  end
end
