class ComputerPlayer 
  attr_reader :name 

  ATTACK_MSGS = [ 
    'is thinking of an attack...', 
    'is plotting your demise. MWAHAHA!', 
    'is preparing to win ever so decisively.', 
    'doesn\'t like your face.', 
    'has a real name of "Inigo Montoya"... you\'re doomed.', 
  ]

  def initialize(name='Ekko') 
    @name = name 
    @board_plays = [] 
  end 

  # For this, I need to keep track of the comp's last played position 
  # I also want to keep track of all of the positions it's targeted throughout the game 
  # Overall, I can just create an array of positions, and use .last to make sure it doesn't repeat recent moves 
  # The array can store the moves played, 
    # but I want to use something to keep track of which moves were successful attacks (hash?) 
    # This would help in giving the comp logic to "be smart" about it's next possible move 
    # This would only apply when using the Ship class to generate diff size ships 
    # The comp could look at it's successes and try to pick a target that would sink a ship 
  def get_play(board) 
    puts 
    puts "#{@name}, the computer, #{ATTACK_MSGS.sample}" 
    sleep 3 

    rows = board.grid.length 
    cols = board.grid[0].length 
    pos = [rand(0...rows), rand(0...cols)] 

    if @board_plays.include?(pos) 
      self.get_play(board) 
    else 
      @board_plays << pos 
      return pos 
    end 
  end 

  def display(board) 
    puts 
    # COMPUTER'S BOARD 
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
