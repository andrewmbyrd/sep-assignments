require 'benchmark'
def search(array, num)
  low = 0
  high = array.length - 1


  while low <= high

    mid = (low + high) / 2

    if array[mid] < num
      low = mid + 1
    elsif array[mid] > num
      high = mid - 1
    else
      return mid
    end

  end

  return -1
end


array=[]

for i in 1..1_000_000
  array.push(i)
end

Benchmark.bm do |x|
  x.report {search(array, 750_000)}
  x.report {search(array, 999_997)}
  x.report {search(array, 3)}
  x.report {search(array, 19)}

end
