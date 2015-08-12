class Player < ActiveRecord::Base
	belongs_to :game
	belongs_to :assassin

	validates_presence_of :game
	validates_presence_of :assassin

	def status
		if self.alive
			"alive"
		else
			"terminated"
		end
	end
end
