class Game < ActiveRecord::Base
	require 'securerandom'

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

	def status
		if self.finished
			"Completed"
		elsif self.in_progress
			"In-Progress"
		else
			"Enrolling"
		end
	end		

	def start
		self.update_attributes(in_progress: true)
		contestants = players.clone.shuffle
		contestants.each_with_index do |contestant, index|
			if contestant == contestants.last
				contestant.update_attributes(target_id: contestants.first.id)
			else
				contestant.update_attributes(target_id: contestants[index + 1].id)
			end
			contestant.update_attributes(passcode: SecureRandom.hex(4))
		end
	end	
end
