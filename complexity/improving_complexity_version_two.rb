def time_efficient_ruby(*arrays)
  #puts all of the values into one array
  combined = []
  arrays.each do |array|
    array.each do |value|
      combined << value
    end
  end

  #now we just have one big array to sort. The most efficient way we know how to do that is O(nlogn). Let's merge sort
  #our combined array. The below is simply a translation of the javascript I wrote in the Khan Academy lesson into Ruby
  def merge_sort(arr, left, right)
    if left < right
      mid = ((left + right)/ 2).floor
      merge_sort(arr, left, mid)
      merge_sort(arr, mid + 1, right)

      merge(arr, left, mid, right)
    end
  end

  def merge(arr, left, mid, right)
    lowHalf = []
    highHalf = []

    key = left

    i = 0
    j = 0

    while key <= mid
      lowHalf[i] = arr[key]
      key += 1
      i += 1
    end

    while key <= right
      highHalf[j] = arr[key]
      key += 1
      j += 1
    end

    key = left
    i = 0
    j = 0

    while i < lowHalf.length && j < highHalf.length
      if lowHalf[i] <= highHalf[j]
        arr[key] = lowHalf[i]
        i += 1
        key += 1
      else
        arr[key] = highHalf[j]
        j += 1
        key += 1
      end
    end

    while i < lowHalf.length
      arr[key] = lowHalf[i]
      i += 1
      key += 1
    end

    while j < highHalf.length
      arr[key] = highHalf[j]
      key += 1
      j += 1
    end
    arr
  end

  merge_sort(combined, 0, combined.length - 1)
end
