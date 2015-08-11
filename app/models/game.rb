class Game < ActiveRecord::Base
	has_one :admin, class_name: "Assassin", foreign_key: "admin_id"

	validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
	validates :description, presence: true, length: { maximum: 150 }

	def admin
		Assassin.find_by_id(self.admin_id)
	end
end
