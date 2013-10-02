module Landable
  module Tracking
    class Visitor < ActiveRecord::Base
      self.table_name = 'traffic.visitors'

      lookup_for :ip_address, class_name: IpAddress
      lookup_for :user_agent, class_name: UserAgent

      has_many :visits
    end
  end
end
