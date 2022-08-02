class Grid
  attr_reader :textContent

  def initialize
    @textContent = {}
    self.first_build
  end

  def first_build
    for i in 1..9
      @textContent[i.to_s] = i
    end
    @textContent
  end

  def print_grid
    print "\n"
    @textContent.each do |key, value|
      print "#{value}  " + (key.to_i%3==0 ? "\n" : "")
    end
  end

  def change_grid (key, value)
    @textContent[key] = value
    print "---------"
    self.print_grid
  end

end


def check_straight? (grid, keys)

  (grid[keys[0].to_s] == grid[keys[1].to_s]) && (grid[keys[1].to_s] == grid[keys[2].to_s])

end

def check_diagonals? (grid)

  (grid["1"] == grid["5"] && grid["5"] == grid["9"]) || (grid["3"] == grid["5"] && grid["5"] == grid["7"])

end

def game_over? (grid)
  straight_lines = [
               [1, 2, 3], [4, 5, 6], [7, 8, 9],
               [1, 4, 7], [2, 5, 8], [3, 6, 9]
              ]
  a =
  straight_lines.select do |straight|
    check_straight?(grid.textContent, straight)

  end

  return !a.empty? || check_diagonals?(grid.textContent)
end

$last = "5"
def check_input input, grid
  input = input.split(" ")
  num = input[0].to_i
  if input.length == 2
    if input[1] == "X" || input[1] == "Y"
      if num > 0 && num < 10
        if input[1] != $last
          if grid.textContent[input[0]] == num
            $last = input[1]
            return true
          else
            print "That position has already been played! Try Again: "
            return false
          end
        else
          print "Not your turn! Try Again: "
          return
        end
      end
    end
  end
  print "Invalid input! Try Again: "
  return false
end

def play_game
  grid = Grid.new()
  grid.print_grid
  print "Enter Position (Integer from 1-9) and your letter (X or Y) with a space between: "

  9.times do

    input = gets.chomp
    until check_input(input, grid)

      input = gets.chomp
    end
    grid.change_grid(input[0].to_s, input[2])

    if game_over?(grid)
      puts "#{input[2]} wins!"
      break
    end
    print "Enter your move: "
  end
end


play_game()
