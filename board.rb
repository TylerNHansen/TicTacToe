# Board implements the game state, but no logic for getting moves from users
# This isolates how moves are made from how moves are decided
# When
class Board
  attr_reader :rows

  def self.blank_grid
    Array.new(3) { Array.new(3) }
  end

  def initialize(rows = self.class.blank_grid)
    @rows = rows
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @rows[x][y]
  end

  def []=(pos, mark)
    raise 'mark already placed there!' unless empty?(pos)

    x, y = pos[0], pos[1]
    @rows[x][y] = mark
  end

  def cols
    cols = [[], [], []]
    @rows.each do |row|
      row.each_with_index do |mark, col_idx|
        cols[col_idx] << mark
      end
    end
    cols
  end

  def diagonals
    down_diag = [[0, 0], [1, 1], [2, 2]]
    up_diag = [[0, 2], [1, 1], [2, 0]]

    [down_diag, up_diag].map do |diag|
      diag.map { |x, y| @rows[x][y] }
    end
  end

  # overwrites default to compare values of rows, rather than object identity
  def dup
    duped_rows = rows.map(&:dup)
    self.class.new(duped_rows)
  end

  def empty?(pos)
    self[pos].nil?
  end

  def tied?
    # tied if nobody has won and no legal moves left
    return false if won?
    @rows.all? { |row| row.none? { |el| el.nil? } }
  end

  def over?
    won? || tied?
  end

  def winner
    (rows + cols + diagonals).each do |triple|
      return :x if triple == [:x, :x, :x]
      return :o if triple == [:o, :o, :o]
    end

    nil
  end

  def won?
    !winner.nil?
  end

  def show
    self.rows.each { |row| p row }
  end
end
