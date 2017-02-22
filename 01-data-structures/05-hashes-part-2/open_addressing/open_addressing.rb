require_relative 'node'

class OpenAddressing

  def initialize(size)
    @items = Array.new(size)
    #we need this to pass around so that how far to jump in quadratic
    #spacing can be saved
    @indices_to_jump = 1
  end

  def []=(key, value)

    #first attempted index is from the normal key hash (ascii)
    attemptedIndex = index(key, size)
    #puts "First attempted Index #{attemptedIndex}"
    #if the attempted index is occupied and not the same item as
    #what is being inserted, find a new index until the requested index
    #is bigger than array size. at that point, resize the array
    while @items[attemptedIndex] && @items[attemptedIndex].value != value
      attemptedIndex = next_open_index(attemptedIndex)
      #puts "Further attempts: #{attemptedIndex}"
      if attemptedIndex == -1
        resize
        attemptedIndex = index(key, size)
      end
    end

    @items[attemptedIndex] = HashObject.new(key, value)
    @indices_to_jump = 1
    #puts "#{@items}\n\n"
  end

  #find where the requested item should be. hopefully, it's at its standard
  #index given by the ascii function. But if it's not, that means it moved
  #for by some amount of predictably quadratic steps
  def [](key)
    i = 1
    desired_index = index(key, size)
    while @items[desired_index].key != key
      desired_index += i**2
      i += 1
    end

    return @items[desired_index].value
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    code = key.sum
    return code % size
  end

  # Given an index, find the next open index in @items
  # this uses quadratic probing to find the next open index
  #we have to keep track of @indices to jump here because it is grows until
  #a valid location is found or the array is resized
  def next_open_index(index)
    if index + @indices_to_jump**2 < @items.length
      open_index = index + @indices_to_jump**2
      @indices_to_jump += 1
    else
      open_index = -1
    end

    return open_index
  end

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end

  # Resize the hash
  def resize
    @indices_to_jump = 1
    doubled = Array.new(@items.length * 2)
    @items.each do |item|
      if item
        doubled[index(item.key, doubled.length)] = item
        #puts "items at #{item.key}\n #{doubled} \n\n"
      end
    end
    @items = doubled

  end
  def print
    num_items = 0

    @items.each_with_index do |item, index|
      if item
        space=" "
        space = "  " if index < 10
        puts "Position#{space}#{index}: \nKey: #{item.key} \nValue: #{item.value}\n\n"
        num_items += 1
      end
    end

    puts "Load Factor #{Float(num_items)/size}"
  end
#end class
end

star_wars_movies = OpenAddressing.new(6)

star_wars_movies["Star Wars: The Phantom Menace"] = "Number One"
star_wars_movies["Star Wars: Attack of the Clones"] = "Number Two"
star_wars_movies["Star Wars: Revenge of the Sith"] = "Number Three"
star_wars_movies["Star Wars: A New Hope"] = "Number Four"
star_wars_movies["Star Wars: The Empire Strikes Back"] = "Number Five"
star_wars_movies["Star Wars: Return of the Jedi"] = "Number Six"

star_wars_movies.print
