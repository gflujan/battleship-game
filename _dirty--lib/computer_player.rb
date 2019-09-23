class ComputerPlayer 
  attr_reader :name; 

  def initialize(name) 
    @name = name; 
  end 

  # For this, I need to keep track of the comp's last played position 
  # I also want to keep track of all of the positions it's targeted throughout the game 
  # Overall, I can just create an array of positions, and use .last to make sure it doesn't repeat recent moves 
  # The array can store the moves played, 
    # but I want to use something to keep track of which moves were successful attacks (hash?) 
    # This would help in giving the comp logic to "be smart" about it's next possible move 
    # This would only apply when using the Ship class to generate diff size ships 
    # The comp could look at it's successes and try to pick a target that would sink a ship 
  def get_play() 
    # 
  end 

  def display(board) 
    @board = board; 
  end 
end 
