
class Team < ApplicationRecord
  paginates_per 3
    belongs_to :user
    belongs_to :tournament
    has_many :event
    has_many :team_line_up
    has_many :roosters, dependent: :destroy
    has_one_attached :image ,dependent: :destroy
    validates :name, :short_name, presence: true
    has_many :batting_stats	, dependent: :destroy
    has_many :pitching_stats, dependent: :destroy	


    def self.ransackable_attributes(auth_object = nil)
      ["created_at", "id", "id_value", "name", "short_name", "tournament_id", "updated_at", "user_id"]
    end
    def self.ransackable_associations(auth_object = nil)
      ["event", "image_attachment", "image_blob", "roosters", "team_line_up", "tournament", "user"]
      end

end 