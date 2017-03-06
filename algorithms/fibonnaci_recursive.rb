require 'benchmark'

def fib(n)

  return 0 if n < 2
  return 1 if n == 2

  return fib(n-1) + fib(n-2)

end

Benchmark.bm do |x|
  x.report {fib(20)}

end
