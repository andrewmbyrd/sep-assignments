def well_written_ruby(*arrays)
  #puts all of the values into one array
  combined = []
  arrays.each do |array|
    array.each do |value|
      combined << value
    end
  end

  #sorted array will initialilze the first element of combined, which we will remove from combined to make
  #sure it doesn't get counted twice.
  sorted = [combined.delete_at(0)]

  #for each value of the combined array, put it in its proper place in the (to-be-correctly) sorted array
  combined.each do |num|
    #in our sorted array, we need to (potentially) traverse the entire thing. so we set up a for from 0 to length (excluding length)
    for i in 0...sorted.length
      #if we found a number greater than the current one in question, great! insert it at that location and exit the inner loop
      if num < sorted[i]
        sorted.insert(i, num)
        break
      end
      #if we never broke out of the loop, then i will equal sorted.length - 1 if we
      #reached this point, then current num is the biggest thing we've seen so far. so put it at the end
      sorted.insert(i + 1, num) if i == sorted.length - 1
    end
  end

  #return the sorted array
  sorted
end
