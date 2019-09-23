require_relative ('board'); 
require_relative ('human_player'); 

class BattleshipGame 
  attr_reader :board, :current_player, :p1, :p2; 

  def initialize(p1, board) 
    @p1 = p1; 
    # @p2 = p2; 
    @board = board; 
    @current_player = p1; 
  end 

  def play() 
    until self.game_over?() 
      self.play_turn(); 
    end 
  end 

  def play_turn() 
    pos = @current_player.get_play(); 
    self.attack(pos); 
    @current_player.display(@board); 
    # self.switch_players!(); 
  end 

  def attack(pos) 
    row, col = pos; 
    @board.grid[row][col] = :x; 
  end 

  def count() 
    return @board.count_ships(); 
  end 

  def switch_players!() 
    @current_player = @current_player == @p1 ? @p2 : @p1; 
  end 

  def game_over?() 
    return @board.won?(); 
  end 
end 

if __FILE__ == $PROGRAM_NAME 
  puts 'Welcome to Battleship!'; 
  puts 'Please enter your first name: '; 
  p1_name = gets.chomp(); 
  p1 = HumanPlayer.new(p1_name); 
  board = Board.new(); 
  40.times() { board.place_random_ship() }; 
  game = BattleshipGame.new(p1, board); 
  game.play(); 
end 

# NOTES: 
# I think I could/want to use an options hash to handle if there is another human player or not 
# Actually, I could ask the user if they want to play a human. If so, create HumanPlayer 
# If not, then default to creating a ComputerPlayer 

# As of now, the game is playable on a basic level 
# I still need to add logic to notify the user if they've hit a ship (or part of it) 
# Then I still need to add when a ship has been sunk and clear the board of that ship 
# When thinking of the bonus to add different size ships, the "ship" will have to be an array of pre-determined positions 
# That is what will make up the ship, once that array has been "cleared out", I can declare the ship as sunk 

# I also need to clean up the display of the board 
# Similarly, I need to hide positions of the ship/parts when the board is displayed 
# The only thing that should be visible (to both human and computer) is the marks for spaces that have been attacked 

# I need to add logic when creating the board to determine the # of times "place_random_ship" runs 
  # It should only place a total number of ships that is between 20-40% of the board's capacity 
  # Thinking of the bonus Ship class, I would need to account for how big the ships are 
  # and I'll likely want to limit the number of sizes that can be available 
