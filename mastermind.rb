
class Board
	@@count = 1
	 def self.display(guess,black,white)
	 	puts "__________________________________________________"
	 	puts "            Your Guess                  | Response"
	 	print "#{@@count}. #{guess} |"
	 	black.times {print "B "}
	 	white.times{print "W "}
	 	puts ""
	 	puts "__________________________________________________"
	 	@@count += 1
	 end

end

class Game

	def self.conversion(x)
		case
	        when x == "RD" then return 1
	        when x == "BU" then return 2
	        when x == "YW" then return 3
	        when x == "GN" then return 4
	        when x == "WH" then return 5
	        when x == "BK" then return 6
	    end
	end

	def self.convertGuess(array)
	    array.map { |x| conversion(x)}
	end

	def self.userGuess
		puts "Please make your guess separated by spaces (RD=Red BL=Blue YW=Yellow GN=Green WH=White BK=Black):"
		guess = gets.chomp.upcase.split(" ")
	end

	def self.checkBlackPeg(guess,code)
		count = 0
		for i in 0..5
			if guess[i] == code[i]
				count += 1 
			end	
		end
		return count
	end

	def self.checkWhitePeg(guess,code)
		count = 0
		code2 = []
		code.each {|x| code2 << x}
		for i in 0..5
			if guess[i] == code2[i]
				code2[i] = 0
				guess[i] = 0
			end
		end
		for i in 0..5
			if guess[i] == code2[i]
				next
			elsif code2.include? guess[i]
				index = code2.index(guess[i])
				code2[index] = 0
				count += 1
			else next
			end
		end
		return count
		puts "The code has changed to: #{code}"
	end

	def self.secretCode
		code = []
		6.times { code << rand(1..6)}
		return code
	end

	def self.manualCode
		code = []
		code = gets.chomp.split(" ")
		code.map {|x| x.to_i}
	end

	def self.chooseCode
		puts "Press 1 if you want a randomly generated code"
		puts "Press 2 if you want to set the code yourself"
		input = gets.chomp.to_i
		puts "1 = Red | 2 = Blue | 3 = Yellow | 4 = Green | 5 = White | 6 = Black, separate your answer with spaces:" if input == 2
		if input == 1
			code = self.humanGuesses
		else
			code = self.computerGuesses
		end
	end

	def self.computerGuesses
		code = self.manualCode
		black_pegs = 0
		count = 0
		while black_pegs != 6 #&& count < 12
			guess =[]
			6.times { guess << rand(1..6) }
			black_pegs = self.checkBlackPeg(guess,code)
			white_pegs = self.checkWhitePeg(guess,code)
			Board.display(guess,black_pegs,white_pegs)
			count += 1
		end
		puts "The computer wins!!!" if black_pegs == 6
		#puts "The computer ran out of guesses" if count == 12
		puts "The final guess was: #{guess} and the secret code was #{code}"
	end

	def self.humanGuesses
		code = self.secretCode
		guess = []
		black_pegs = 0
		count = 0
		while black_pegs != 6 && count < 12
			guess2 = self.userGuess
			guess = self.convertGuess(guess2)
			black_pegs = self.checkBlackPeg(guess,code)
			white_pegs = self.checkWhitePeg(guess,code)
			Board.display(guess2,black_pegs,white_pegs)
			count += 1
		end
		puts "You won!!!" if black_pegs == 6
		puts "You ran out of guesses, the computer wins" if count == 12
	end
end


code = Game.chooseCode






