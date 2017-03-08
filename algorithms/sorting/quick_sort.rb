require 'benchmark'

def quick_sort(collection, left_index, right_index)
  unless collection
    return nil
  end

  if right_index <= left_index
    return collection
  else

    pivot = collection[right_index]
    new_pivot_loc = left_index

    for i in left_index...(right_index)

      temp = collection[i]
      if temp < pivot
        collection[i] = collection[new_pivot_loc]
        collection[new_pivot_loc] = temp
        new_pivot_loc += 1
      end
    end

    collection[right_index] = collection[new_pivot_loc]
    collection[new_pivot_loc] = pivot

    
    quick_sort(collection, left_index, new_pivot_loc - 1)
    quick_sort(collection, new_pivot_loc + 1, right_index)
  end

end

unsorted = []

50.times do |num|
  unsorted.push(rand(200))
end

Benchmark.bm do |x|
  x.report {quick_sort(unsorted, 0, unsorted.length-1)}
end
