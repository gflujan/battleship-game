class Board 
  attr_reader :grid 

  def initialize(grid=self.class.default_grid) 
    @grid = grid 
  end 

  def self.default_grid 
    @grid = Array.new(6) { Array.new(6) } 
  end 

  def [](pos) 
    row, col = pos 
    @grid[row][col] 
  end 

  def []=(pos, mark) 
    row, col = pos 
    @grid[row][col] = mark 
  end 

  def count_ships 
    total_num_ships = 0 

    grid.each do |sub| 
      total_num_ships += sub.count { |el| el == :s } 
    end 

    total_num_ships 
  end 

  def empty?(pos=nil) 
    if pos.nil? 
      self.count_ships == 0 ? true : false 
    else 
      row, col = pos 
      @grid[row][col].nil? 
    end 
  end 

  def full? 
    board_size = @grid.flatten.length 
    board_size == self.count_ships # ? true : false 
  end 

  def place_random_ship 
    raise "The board is full. You can't place anymore ships." if self.full? 
    
    pos = self.get_rand_empty_pos 
    row, col = pos 
    @grid[row][col] = :s 
  end 

  # I want to generate two random numbers that are within the bounds of the grid's row and col's size 
  # Then, I want to use the instance method .empty? to help determine if that spot works 
  # If it is, I want to return an array with two integers indicating [row, col] 
  # If not, then I'll keep generating rand nums (can I recursively call this method to do that?) 
  def get_rand_empty_pos 
    rows = @grid.length 
    cols = @grid[0].length 
    pos = [rand(0...rows), rand(0...cols)] 
    self.empty?(pos) ? pos : self.get_rand_empty_pos 
  end 

  def won? 
    self.empty? 
  end 
end 
