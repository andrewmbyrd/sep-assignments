require_relative 'actor'
require_relative 'queue'
require 'some_linked_list_class'
require 'some_hash_class'

#this is a an hash whose populated indices each contain an array. index 0 of each small(er) array contains an actor object, who
#is hashed into the array based on their name item in the array contains actor objects which are neighbors of the first index in some
#map THAT IS NOT GIVEN, but COULD drawn using each actor's `film_actor_hash`
adj_list = ['...']

kevin_bacon = Actor.new(kevin, "movie_hash")

def find_kevin_bacon(other_actor)

  bfsInfo = Hash.new(13)

  for i in 0..adj_list.items.length
    bfsInfo[adj_list[i][0].name] = {
      actor: adj_list[i][0],
      distance: nil,
      predecessor: nil
    } if adj_list.items[i]
  end

  #find kevin bacon in this bfsInfo and set his distance (to himself) to 0
  bfsInfo["Kevin Bacon"][:distance] = 0


  #we'll put kevin bacon in first and draw the distances of every other actor from him
  queue = Queue.new
  queue.enqueue(kevin_bacon)

  #this is simply the breadth first search algorithm implemented in the Khan Academy checkpoint
  while !queue.empty?
    current = queue.dequeue

    for i in (1...adj_list[current.name].length)
      neighbor = adj_list[current.name][i]

      unless bfsInfo[neighbor.name][:distance]
        queue.enqueue(neighbor)
        bfsInfo[neighbor.name][:distance] = bfsInfo[current.name][:distance] + 1
        bfsInfo[neighbor.name][:predecessor] = current
      end

    end

  end

#ok now we have our breadth first search info filled out, so we need to return the list of movies that connects the argument other_actor
#to kevin bacon

movie_list = []

#if the other actor is more than 6 movies away, or not connected at all return nil
if bfsInfo[other_actor.name][:distance] > 6 ||  bfsInfo[other_actor.name][:distance] == nil
  return nil

else

 #otherwise, find the other actor in our bfsInfo hash that we finished creating above
  current = bfsInfo[other_actor.name]

  #as long as the distance is greater than 0, we haven't reached kevin bacon yet
  while current[:distance] > 0
    #the common movie is the intersection of this actor's film_actor_hash and its predecessor's. we only need one movie if there's more than one
    common_movie = adj_list[current[:actor].name.film_actor_hash.keys]&current.predecessor.film_actor_hash.keys[0]

    #add that movie ot the list and move backwards (at most 6 times)
    movie_list.push(common_movie)
    current = current.predecessor
  end

  #return our array with at most 6 movies connecting the random actor to kevin bacon
  return movie_list
end

end
