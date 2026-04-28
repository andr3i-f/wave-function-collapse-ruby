class Unit
  attr_accessor :possibilities, :character
  attr_reader :collapsed, :x, :y

  def initialize(row, col)
    @x = row
    @y = col
    @possibilities = ['#', '*', '@', '.', '~']
    @character = @possibilities.length
    @collapsed = false
  end

  def collapse
    @character = @possibilities.sample
    @collapsed = true
  end
end