(import testament :prefix "" :exit true)
(import ../skewheap)

(def max-num 500)
(def numbers (range 0 max-num))

(deftest basics
  (def skew (skewheap/make))

  (is (nil? (skewheap/take skew)) "take: receives nil from empty skewheap")
  (is (skewheap/is-empty? skew) "is-empty?: true for empty skewheap")

  (skewheap/put skew ;numbers)

  (is (not (skewheap/is-empty? skew)) "is-empty?: false for non-empty skewheap")

  (each n (range 0 max-num)
    (def expected-size (- max-num 1 n))
    (def peeked (skewheap/peek skew))
    (def actual (skewheap/take skew))
    (def size (skewheap/size skew))

    (is (= n peeked) (string "peek: expected " n ", got " actual))
    (is (= n actual) (string "take: expected " n ", got " actual))
    (is (= expected-size size) (string "size: expected " expected-size ", got " size)))

  (is (skewheap/is-empty? skew) "is-empty?: true after skewheap was emptied"))

(run-tests!)
