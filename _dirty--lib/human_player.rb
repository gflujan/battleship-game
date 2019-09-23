class HumanPlayer 
  attr_reader :name; 

  def initialize(name) 
    @name = name; 
  end 

  def get_play() 
    puts 
    puts "#{@name}, please enter a position that you'd like to attack (e.g. 0,0)"; 
    answer = gets.chomp(); 
    pos = answer.delete(' ').split(',').map(&:to_i); 
  end 

  def display(board) 
    @board = board; 

    @board.grid.each() do |row| 
      p row; 
    end 
  end 
end 
