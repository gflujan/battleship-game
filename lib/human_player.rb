class HumanPlayer 
  attr_reader :name 

  REQUESTS = [
    'please enter a position that you would like to attack.', 
    'what position would you like to attack now?', 
    'let\'s sink these ships! Where should we attack?', 
    'give \'em hell! Enter some coordinates.', 
    'be the Admiral you were meant to be. What\'s your next target?', 
  ]

  def initialize(name='Human') 
    @name = name 
    @board_plays = [] 
  end 

  def get_play(board) 
    puts 
    puts "#{@name}, #{REQUESTS.sample} (e.g. 0,0 [row, col])" 
    answer = gets.chomp 
    pos = answer.delete(' ').split(',').map(&:to_i) 
    pos = [(pos[0]-1), (pos[1]-1)] 

    if @board_plays.include?(pos) 
      puts 
      print "You've already played that. Please try again." 
      self.get_play(board) 
    else 
      @board_plays << pos 
      return pos 
    end 
  end 

  def display(board) 
    puts 
    # HUMAN'S BOARD 
    puts "#{@name.upcase}'s BOARD" 
    print '  ' 

    i = 1 
    board.grid.length.times do 
      print "  #{i} " 
      i += 1 
    end  
    print "\n" 

    j = 1 
    print "  ---------------------------------------\n" 
    board.grid.each do |row| 
      print "#{j} " 
      row.each do |ele| 
        if ele == nil || ele == :s 
          print '|   ' 
        else 
          print "| #{ele} " 
        end 
      end 

      j += 1 
      print "|\n" 
      print "  ---------------------------------------\n" 
    end 
  end 
end 
