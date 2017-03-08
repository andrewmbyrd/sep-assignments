def space_efficient_ruby(*arrays)
  #puts all of the values into one array
  combined = []
  arrays.each do |array|
    array.each do |value|
      combined << value
    end
  end

  #now we just have one big array to sort. We can improve space efficiency by only working with that one array IN place
  #Let's use a quick sort to achieve this
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

  quick_sort(combined, 0, combined.length - 1)
end
