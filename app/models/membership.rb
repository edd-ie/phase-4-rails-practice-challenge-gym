class Membership < ApplicationRecord
    belongs_to :gym
    belongs_to :client

    validates :client_id, :gym_id, :charge, presence: true
end
