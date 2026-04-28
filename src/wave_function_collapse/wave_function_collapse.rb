require_relative 'unit'

class WaveFunctionCollapse
  RULES = {
    '#' => ['#', '*', '@', '~'],
    '*' => ['#', '@', '*'],
    '@' => ['#', '*', '@'],
    '~' => ['#', '.', '~'],
    '.' => ['.', '~']
  }

  attr_reader :grid, :completed

  def initialize
    @grid = []
    @height, @width = 10, 25

    @height.times do |h|
      row = []
      @width.times do |w|
        row << Unit.new(h, w)
      end
      @grid << row
    end

    @completed = false
  end

  def collapse
    cells = find_lowest_entropy

    if cells.empty?
      @completed = true
      return
    end

    cell = pick_random_cell(cells: cells)
    cell.collapse
    update_neighbors(cell.x, cell.y)
  end

  def update_neighbors(row, col)
    left = @grid[row][col - 1] if col - 1 >= 0
    right = @grid[row][col + 1] if col + 1 < @width
    up = @grid[row - 1][col] if row - 1 >= 0
    down = @grid[row + 1][col] if row + 1 < @height
    cell = @grid[row][col]

    [left, right, up, down].compact.each do |neighbor|
      if neighbor.collapsed
        next
      end

      neighbor.possibilities &= RULES[cell.character] unless neighbor.collapsed
      neighbor.character = neighbor.possibilities.length
    end    
  end

  def find_lowest_entropy
    lowest_value = 5
    res = {}

    @grid.each do |row|
      row.each do |unit|
        if unit.collapsed
          next
        end

        if unit.character < lowest_value
          lowest_value = unit.character
        end

        res[unit.character] ||= []
        res[unit.character] << unit
      end
    end

    if res.empty?
      return []
    end

    res[lowest_value]
  end

  def pick_random_cell(cells:)
    cells.sample
  end
end