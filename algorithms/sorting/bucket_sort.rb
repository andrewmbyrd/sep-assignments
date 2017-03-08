require 'benchmark'

def bucket_sort(collection)

  buckets = Array.new(collection.length)
  sorted = []

  #first, put them in the buckets
  collection.each do |num|
    index = num / 2
    index = buckets.length-1 if index >= buckets.length

    if buckets[index]
      buckets[index].push(num)
    else
      buckets[index] = []
      buckets[index].push(num)
    end

  end


  #then sort the buckets. just using the stock selection sort here
  buckets.each do |bucket|
    if bucket
      if bucket.length == 1
        sorted.push(bucket[0])
      else
        for i in 0...bucket.length - 2
          min_index = i
          for j in (i + 1)... bucket.length
            if bucket[j]< bucket[min_index]
              min_index = j
            end

          end
          temp = bucket[i]
          bucket[i] = bucket[min_index]
          bucket[min_index] = temp
        end

        bucket.each do |num|
          sorted.push(num)
        end
      end
    end
  end

    sorted
end


unsorted = []

50.times do |num|
  unsorted.push(rand(80))
end


Benchmark.bm do |x|
  x.report {bucket_sort(unsorted)}
end
