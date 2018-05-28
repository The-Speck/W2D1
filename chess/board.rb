require_relative 'piece.rb'

class Board
  
  def initialize 
    @grid = Array.new(8){Array.new(8)}
    populate
    # @grid = Board.populate
  end
  
  def [](pos)
    row, col = pos
    grid[row][col]
  end
  
  def []=(pos, target)
    row, col = pos
    grid[row][col] = target
  end
  
  # def self.populate
  #   local_board = Array.new(8) {Array.new(8)}
  #   local_board.each_with_index do |row, row_idx|
  #     row.each_with_index do |col, col_idx|
  #       if row_idx < 2 || row_idx > 5
  #         local_board[row_idx][col_idx] = Piece.new
  #       else
  #         local_board[row_idx][col_idx] = NullPiece.new
  #       end
  #     end
  #   end
  # 
  #   local_board
  # end
  def populate
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |col, col_idx|
        pos = [row_idx, col_idx]
        if row_idx < 2 || row_idx > 5
          self[pos]= Piece.new
        else
          self[pos]= NullPiece.new
        end
      end
    end
  end
  
  def display
    grid.each do |row|
      p row
    end
  end
  
  def move_piece(start_pos, end_pos)
    begin
      if start_pos == end_pos
        raise "Start pos cannot be the same as end pos"
      elsif grid[start_pos].is_a? NullPiece
        raise "There's no piece at the start position"
      elsif grid[end_pos].nil?
        raise "Cannot move there"
      end
      
      grid[start_pos], grid[end_pos] = NullPiece.new, grid[start_pos]
    rescue => error
      puts error
      start_pos = gets.chomp.split(",").map(&:to_i)
      puts error
      end_pos = gets.chomp.split(",").map(&:to_i)
      move_piece(start_pos, end_pos)
    end
  end 
  
  attr_reader :grid
end

# grid = Board.new
# board.display