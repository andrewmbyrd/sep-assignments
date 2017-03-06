require 'benchmark'
#the stupid recursive search takes a new array every time, so we have to keep track
#of the actual location we want from the original array with low_index and high_index
def search(array, num, low_index, high_index)
  return -1 unless array
  low = 0
  high = array.length - 1
  mid = (low + high) / 2
  if array[mid] == num
    return (low_index + high_index) / 2
  elsif array[mid] > num
    #we'll make a smaller array that we pass back into the search function recursively. if the number
    #we're looking for is less than our middle guess, then low_index remains the same, but high_index changes
    smaller_array = array.slice(0...mid)
    search(smaller_array, num, low_index, low_index + mid - 1)
  else
    #if the number we're looking for is higher than our middle guess, then low_index is now higher by however many more indices mid just was
    #and high index remains the same
    smaller_array = array.slice((mid+1)...array.length)
    search(smaller_array, num, low_index + mid + 1, high_index)
  end

end


array=[]

for i in 1..1_000_000
  array.push(i)
end

Benchmark.bm do |x|
  x.report {search(array, 750_000, 0, 999_999)}
  x.report {search(array, 999_997, 0, 999_999)}
  x.report {search(array, 3, 0, 999_999)}
  x.report {search(array, 4, 0, 999_999)}

end
