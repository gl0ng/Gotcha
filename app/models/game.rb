class Game < ActiveRecord::Base
	has_one :admin, class_name: "Assassin", foreign_key: "admin_id"
	has_many :players

	validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
	validates :description, presence: true, length: { maximum: 150 }
	validates_presence_of :admin

	def admin
		Assassin.find_by_id(self.admin_id)
	end

	def players
		Player.where(game_id: self.id)
	end
end
