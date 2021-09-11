require './shot'
class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def strike?


  end

  def score
    [first_shot.score, second_shot.score, third_shot.score].sum
  end

  frames = []

end

frame = Frame.new("6", "4", "X")
puts frame.score
