require ('byebug') 

require_relative 'board' 
require_relative 'human_player' 
require_relative 'computer_player' 

class BattleshipGame 
  attr_reader :current_player, :current_board, :other_player, :p1, :p2 

  def initialize(players={}) 
    defaults = { 
      p1: 'bueller', 
      board1: [], 
      p2: 'sloane', 
      board2: [], 
    } 

    players = defaults.merge(players) 

    @p1 = players[:p1] 
    @p2 = players[:p2] 
    @p1_board = players[:board1] 
    @p2_board = players[:board2] 

    @current_player = @p1 
    @other_player   = @p2 
    @current_board  = @p2_board 
  end 

  def play 
    self.play_turn until self.game_over? 
    self.conclude(@current_player.name) 
  end 

  def play_turn 
    pos = @current_player.get_play(@current_board) 

    if self.invalid?(pos) 
      puts 
      print 'Sorry, you have an entered an invalid position. :-(' 
      self.play_turn 
    else 
      self.attack(pos) 
      @other_player.display(@current_board) 
      self.conclude(@current_player.name) if self.game_over? 
      self.switch_players! 
    end 
  end 

  def attack(pos) 
    row, col = pos 

    # Update this to use the current player's name as part of the response 
    # Also, should I use the name of the "other player's" board in the response as well? 
    if @current_board.grid[row][col] == :s 
      print "Success! #{@current_player.name} hit a ship on #{@other_player.name}'s board!" 
      puts 
      @current_board.grid[row][col] = :X 
    else 
      print "Bummer! #{@current_player.name} missed their target on #{@other_player.name}'s board. :-(" 
      puts 
      @current_board.grid[row][col] = :_ 
    end 
  end 

  def invalid?(pos) 
    # byebug 
    row, col = pos 
    row >= @current_board.grid.length || col >= @current_board.grid[0].length 
  end 

  def count 
    @current_board.count_ships 
  end 

  def switch_players! 
    @current_player = @current_player == @p1 ? @p2 : @p1 
    @other_player = @other_player == @p1 ? @p2 : @p1 
    @current_board = @current_board == @p1_board ? @p2_board : @p1_board 
  end 

  def game_over? 
    @current_board.won? 
  end 

  def conclude(winning_name) 
    puts 
    puts "CONGRATS! The game is over. #{winning_name} sunk all the battleships!" 
    puts 
    exit 
  end 
end 

if __FILE__ == $PROGRAM_NAME 
  puts 
  puts 'Welcome to Battleship!' 
  puts 'Player 1, please enter your first name: ' 
  p1_name = gets.chomp.capitalize 
  p1 = HumanPlayer.new(p1_name) 
  p2 = ComputerPlayer.new 

  custom_grid1 = Array.new(3) { Array.new(3) } 
  custom_grid2 = Array.new(3) { Array.new(3) } 
  max_num_ships = custom_grid1.flatten.length / 2 

  p1_board = Board.new(custom_grid1) 
  p2_board = Board.new(custom_grid2) 

  max_num_ships.times do 
    p1_board.place_random_ship 
    p2_board.place_random_ship 
  end 

  players = { 
    p1: p1, 
    board1: p1_board, 
    p2: p2, 
    board2: p2_board, 
  } 
  
  game = BattleshipGame.new(players) 
  game.play 
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
