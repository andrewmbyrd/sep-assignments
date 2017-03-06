require 'benchmark'

def fib(n)

  if n < 3
    return n - 1
  else

    fibs=[]
    fibs[0] = 0
    fibs[1] = 1

    for i in 2...n
      fibs[i] = fibs[i - 1] + fibs[i - 2]
    end

    return fibs[n - 1]
  end

end

Benchmark.bm do |x|
  x.report {fib(20)}

end
