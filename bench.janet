(import skewheap)

(def sizes [10000
            50000
            100000
            250000])

(def maxnum (max ;sizes))
(print "Building randomly shuffled list of " maxnum " numbers")
(def numbers (range 0 maxnum))
(sort numbers (fn [_ _ ] (> (math/random) (math/random))))


(def offset-start (os/clock))
(def offset-end (os/clock))
(def offset (* 2 (- offset-end offset-start)))

(each size sizes
  (def items (array/slice numbers 0 size))
  (def start (os/clock))

  (def skew (skewheap/make))
  (skewheap/put skew ;items)
  (each _ items (skewheap/take skew))

  (def end (os/clock))
  (def took (- end start offset))
  (def rate (/ size took))

  (if (= 0 took)
    (printf "skewheap: put/take %-06d - 0s (too few iterations for reliable measurement)"
            size)
    (printf "skewheap: put/take %-06d - %0.02fs (%0.2f items/s)"
            size
            took
            rate)))
