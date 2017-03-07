require_relative 'max_heap'
require_relative 'node'
require 'benchmark'

def heap_sort(collection)
  return nil if collection.empty?

  r = Node.new(collection[0])
  heap = MaxHeap.new(r)
  sorted = []

  for i in 1...collection.length
    heap.insert(collection[i])
  end

  heap.print
  puts "\n\n"
  for i in 0...collection.length
    sorted.unshift(heap.delete(heap.root, heap.root.data))
    heap.print
    puts "\n"
  end

  sorted
end

unsorted = []

50.times do |num|
  unsorted.push(rand(200))
end

Benchmark.bm do |x|
  x.report {heap_sort(unsorted)}
end
