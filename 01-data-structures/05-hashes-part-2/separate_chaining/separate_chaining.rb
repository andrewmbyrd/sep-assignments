require_relative 'linked_list'

class SeparateChaining
  attr_reader :max_load_factor

  #we'll go ahead and populate each space in the base array with an empty linked list from
  # the outset. also keep track of num items to make calculating Load Factor easy
  def initialize(size)
    @max_load_factor = 0.7
    @buckets = Array.new(size)
    @buckets.each_with_index do |bucket, index|
      @buckets[index] = LinkedList.new
    end
    @num_items = 0
  end

  #simply always add the inserted item to the tail of the desired buckets. increment num_items
  #resize when load factor gets too high
  def []=(key, value)

    @buckets[index(key, size)].add_to_tail(Node.new(key, value))
    @num_items += 1

    resize if load_factor > @max_load_factor
  end

  #traverse the current linked list until the desired element is found.
  # raise an error if an invalid key is sent
  def [](key)
    current_node = @buckets[index(key, size)].head
    if !current_node
      #raise InvalidKeyError "Cannot retrieve that item - not instantiated"
      return  nil
    end
    while current_node.key != key
      current_node = current_node.next
      break unless current_node
    end

    if !current_node
      #raise InvalidKeyError "Cannot retrieve that item - not instantiated"
      return nil
    end

    return current_node.value
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Calculate the current load factor
  def load_factor
    Float(@num_items) / size
  end

  # Simple method to return the number of BUCKETS in the hash
  def size
    @buckets.length
  end

  def print
    @buckets.each_with_index do |bucket, index|
      if bucket.head
        space=" "
        space = "  " if index < 10
        puts "Bucket#{space}#{index} \n"
        current_node = bucket.head
        while current_node
          puts "Key: #{current_node.key}\n"
          puts "Value: #{current_node.value}\n"
          if current_node.next
            puts " -- > "
          else
            puts "\n\n"
          end
          current_node = current_node.next
        end
      end

    end
    puts "Load Factor: #{load_factor}"
  end

  # Resize the hash
  def resize
    more_buckets = Array.new(size * 2, LinkedList.new)
    more_buckets.each_with_index do |bucket, index|
      more_buckets[index] = LinkedList.new
    end
    @buckets.each do |bucket|
      current_node = bucket.head
      #puts "Current Node Key: #{current_node.key}"
      #puts "Next node key: #{current_node.next.key} \n\n"
      if current_node
        more_buckets[index(current_node.key, more_buckets.length)].add_to_tail(current_node)
        current_node = current_node.next
      end
    end

    @buckets = more_buckets
  end



  class InvalidKeyError < StandardError
  end
end

class InvalidKeyError < StandardError
end

star_wars_movies = SeparateChaining.new(6)

star_wars_movies["Star Wars: The Phantom Menace"] = "Number One"
star_wars_movies["Star Wars: Attack of the Clones"] = "Number Two"
star_wars_movies["Star Wars: Revenge of the Sith"] = "Number Three"
star_wars_movies["Star Wars: A New Hope"] = "Number Four"
star_wars_movies["Star Wars: The Empire Strikes Back"] = "Number Five"
star_wars_movies["Star Wars: Return of the Jedi"] = "Number Six"
star_wars_movies["Lotr"]
star_wars_movies.print
