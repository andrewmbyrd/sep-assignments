require_relative 'pixel'

class Screen
  attr_accessor :width
  attr_accessor :height
  attr_accessor :matrix

  def initialize(width, height)
    self.matrix = []
    self.width = width
    self.height = height
    for i in 0...width
      self.matrix[i] = []
      for j in 0...height
        self.matrix[i][j] = 0
      end
    end
  end

  # Insert a Pixel at x, y, and really this should just be
  # insert(Pixel) because its super confusing if x and y are anything
  #other than pixel.x and pixel.y, respectively
  def insert(pixel, x, y)
    if inbounds(x,y)
      self.matrix[x][y] = pixel
    else
      raise BoundaryError "That is not a valid pixel location"
    end
  end

  def at(x, y)
    unless inbounds(x,y)
      nil
    else
      return self.matrix[x][y]
    end
  end

  def search(thing)
    for i in 0...width
      if matrix[i].index(thing)
        return [i, matrix[i].index(thing)]
      end
    end

    return nil
  end

  private

  def inbounds(x, y)
    return x >= 0 && x < self.width && y >= 0 && y < self.height
  end

end

class BoundaryError < StandardError
end

#screen = Screen.new(5, 5)
#screen.insert(Pixel.new(255,3,5,1,1), 1, 1)
#puts screen.at(1,1)
#puts screen.matrix
