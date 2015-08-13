class Player < ActiveRecord::Base
	belongs_to :game
	belongs_to :assassin
	has_one :target, class_name: "Player", foreign_key: "target_id"


	validates_presence_of :game
	validates_presence_of :assassin

	def status
		if self.alive
			"alive"
		else
			"terminated"
		end
	end

	def name
		self.assassin.name
	end

	def vanquished(assassin)
		self.update_attributes(alive: false)
		assassin.update_attributes(kills: assassin.kills + 1,
			target_id: self.target_id)
		self.game.player_vanquished
	end
end
