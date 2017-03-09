require_relative 'city'

def greedy_salesman(map, start_city_index)

  #make some cities. Each has a name and an index that was mapped into the edge matrix
  new_orleans = City.new("New Orleans", 0)
  denver = City.new("Denver", 1)
  chicago = City.new("Chicago", 2)
  charlotte = City.new("Charlotte", 3)
  atlanta = City.new("Atlanta", 4)
  philadelphia = City.new("Philadelphia", 5)
  seattle = City.new("Seattle", 6)
  houston = City.new("Houston", 7)

  #put the cities in an easy-to-access list
  cities = [new_orleans, denver, chicago, charlotte, atlanta, philadelphia, seattle, houston]

  #start at whatver city is given to start with. This could use a switch: case or while loop to take a city name instead, but this implementation
  #seems more efficient for now
  current_city = cities[start_city_index]

  #this is just to make the output prettier
  num_cities_visited = 0
  distance_travelled = 0
  output_message = ""
  while current_city.visited == false
    #set min to an arbitrarily high value. This works in this example because all of the cities are in the U.S. so
    #nothing is more than 10,000 miles away. Min could find a non-zero value in the actual map, but that is not
    #necessary here.
    min = 10_000
    #find the index of the unvisited city whose distance is a minimum from the current city. Of course we must skip the part
    #of the matrix where the city looks at itself
    for i in 0...map[current_city.index].length
       if map[current_city.index][i] < min && current_city.index != i && !cities[i].visited
         min = map[current_city.index][i]
         next_city_index = i
       end

    end

    #This makes output prettier
    num_cities_visited += 1
    distance_travelled += min

    if num_cities_visited == 1
      output_message += "Start at #{current_city.name} and travel #{min} miles to "
    elsif num_cities_visited == cities.length
      output_message += "#{current_city.name}. \nTotal distance travelled was #{distance_travelled} miles."
    else
      output_message += "#{current_city.name}.\nThen travel #{min} miles to "
    end

    #set the current city to show that its been visited. Then set the new current city to be the one that had the smallest distance from the
    #old current city
    current_city.visited = true;
    current_city = cities[next_city_index]

  end

  puts output_message

end



#put approximate distances between each city into a map/edge matrix

map = [[0,    1300,  925,  713,  469, 1225, 2600,  348],
       [1300,    0, 1000, 1550, 1400, 1730, 1320, 1030],
       [925,  1000,    0,  750,  716,  760, 2000, 1080],
       [713,  1550,  750,    0,  244,  537, 2800, 1037],
       [469,  1400,  716,  244,    0,  777, 2636,  793],
       [1225, 1730,  760,  537,  777,    0, 2820, 1550],
       [2600, 1320, 2000, 2800, 2636, 2820,    0, 2346],
       [348,  1030, 1080, 1037,  793, 1550, 2346,    0]
     ]

greedy_salesman(map, 6)
