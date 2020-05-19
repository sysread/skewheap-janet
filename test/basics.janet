(import ../skewheap)

(def max-num 500)
(def numbers (range 0 max-num))

# randomize numbers list
(math/seedrandom (os/time))
(sort numbers (fn [_ _ ] (> (math/random) (math/random))))


(def skew (skewheap/make))

(each n numbers
  (skewheap/put skew n))

(each n (range 0 max-num)
  (def expected-size (- max-num 1 n))
  (def actual (skewheap/take skew))

  (unless (= actual n)
    (error (string "take: expected " n " but got " actual)))

  (unless (= (skewheap/size skew) expected-size)
    (error (string "size: expected " expected-size " but got " (skewheap/size skew)))))
