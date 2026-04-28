require_relative '../wave_function_collapse/wave_function_collapse'

class Terminal
  def initialize
    
  end

  def play 
    wfc = WaveFunctionCollapse.new

    until wfc.completed
      wfc.grid.each do |row|
        puts row.map(&:character).join
      end

      wfc.collapse
      sleep(0.05)
      clear
    end

    wfc.grid.each do |row|
        puts row.map(&:character).join
    end
  end

  def clear
    system('clear') || system('cls')
  end
end