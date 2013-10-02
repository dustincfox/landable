module Landable
  module Tracking
    class Attribution < ActiveRecord::Base
      KEYS = %w[ad_type bid_match_type campaign content creative device_type keyword match_type medium network placement position search_term source target]

      self.table_name = 'traffic.attributions'

      KEYS.each do |key|
        lookup_for key.to_sym, class_name: "Landable::Tracking::#{key.classify}".constantize
      end

      has_many :visits

      class << self
        def transform(parameters)
          hash = parameters.slice(*KEYS)

          filter = {}

          hash.each do |k, v|
            filter[k.foreign_key] = "Landable::Tracking::#{k.classify}".constantize[v]
          end

          filter
        end

        def lookup(parameters)
          where(transform(parameters)).first_or_create
        end

        def digest(parameters)
          Digest::SHA2.base64digest transform(parameters).values.join
        end
      end
    end
  end
end
