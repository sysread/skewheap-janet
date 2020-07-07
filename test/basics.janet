(import ../skewheap)

(def max-num 500)
(def numbers (range 0 max-num))

# randomize numbers list
(math/seedrandom (os/time))
(sort numbers (fn [_ _ ] (> (math/random) (math/random))))


(def skew (skewheap/make))

(unless (nil? (skewheap/take skew))
  (error "take: did not recive nil from empty skewheap"))

(unless (skewheap/is-empty? skew)
  (error "is-empty?: not true for empty skewheap"))

(skewheap/put skew ;numbers)

(if (skewheap/is-empty? skew)
  (error "is-empty?: not false for non-empty skewheap"))

(each n (range 0 max-num)
  (def expected-size (- max-num 1 n))
  (def peeked (skewheap/peek skew))
  (def actual (skewheap/take skew))

  (unless (= actual peeked)
    (error (string "peek: expected " actual " but got " peeked)))

  (unless (= actual n)
    (error (string "take: expected " n " but got " actual)))

  (unless (= (skewheap/size skew) expected-size)
    (error (string "size: expected " expected-size " but got " (skewheap/size skew)))))

(unless (skewheap/is-empty? skew)
  (error "is-empty?: not true after skewheap was emptied"))
