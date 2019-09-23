class Board 
  attr_reader :grid; 

  def initialize(grid=self.class.default_grid) 
    @grid = grid; 
  end 

  def self.default_grid() 
    @grid = Array.new(10) { Array.new(10) }; 
  end 

  def [](pos) 
    row, col = pos; 
    @grid[row][col]; 
  end 

  def []=(pos, mark) 
    row, col = pos; 
    @grid[row][col] = mark; 
  end 

  def count_ships() 
    total_num_ships = 0; 

    grid.each() do |sub| 
      total_num_ships += sub.count() { |el| el == :s }; 
    end 

    return total_num_ships; 
  end 

  def empty?(pos=nil) 
    if pos.nil? 
      return self.count_ships() == 0 ? true : false; 
    else 
      row, col = pos; 
      return @grid[row][col].nil?; 
    end 
  end 

  def full?() 
    board_size = @grid.flatten().length(); 
    return board_size == self.count_ships() ? true : false; 
  end 

  def place_random_ship() 
    raise "The board is full. You can't place anymore ships." if self.full?(); 
    
    pos = self.get_rand_empty_pos(); 
    row, col = pos; 
    @grid[row][col] = :s; 

  end 
  # WILL I NEED THIS LATER? Maybe in another/separate method? 
  # until self.full?() 
  #   # I think I want a helper method to grab random empty positions 
  #   # I also think I can/want to recursively call this method until we're full 
  # end 

  # I want to generate two random numbers that are within the bounds of the grid's row and col's size 
  # Then, I want to use the instance method .empty? to help determine if that spot works 
  # If it is, I want to return an array with two integers indicating [row, col] 
  # If not, then I'll keep generating rand nums (can I recursively call this method to do that?) 
  def get_rand_empty_pos() 
    # rows = @grid.length(); 
    # cols = @grid[0].length(); 
    # pos = [rand(0...rows), rand(0...cols)]; 

    # This is nice in that it refactors down to 2 lines 
    # but I also don't like it because it's make the pos logic a little more obscure 
    pos = [rand(0...@grid.length), rand(0...@grid[0].length)]; 
    return self.empty?(pos) ? pos : self.get_rand_empty_pos(); 
  end 

  # Two versions, one-liner versus block style :-) 
  def won?(); return self.empty?(); end 
  # def won?() 
  #   return self.empty?(); 
  # end 
end 
