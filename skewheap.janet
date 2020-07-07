(def item 0)
(def left 1)
(def right 2)

(def skew-cmp 0)
(def skew-size 1)
(def skew-root 2)

(defn- merge
  "Recursively merges two nodes, returning a new tree structure."
  [skew a b]
  (cond
    (nil? a) b
    (nil? b) a
    (do
      (var node-a a)
      (var node-b b)

      (when ((skew skew-cmp) (b item) (a item))
        (set node-a b)
        (set node-b a))

      [(node-a item)
       (merge skew node-b (node-a right))
       (node-a left)])))

(defn make
  "Builds a new, empty skewheap, whose elements will be returned in skew-cmp order."
  [&opt cmp]
  (default cmp <=)
  @[cmp 0 nil])

(defn size
  "The number of elements in the heap"
  [skew]
  (skew skew-size))

(defn is-empty?
  "True when the heap is empty"
  [skew]
  (= 0 (size skew)))

(defn peek
  "Returns the first item in the heap without removing it."
  [skew]
  (if (is-empty? skew) nil ((skew skew-root) item)))

(defn put
  "Inserts a new item into the heap. Returns the heap's new size."
  [skew & items]
  (loop [item :in items]
    (++ (skew skew-size))
    (set (skew skew-root) (merge skew (skew skew-root) [item nil nil]))))

(defn take
  "Removes and returns an item from the heap. Returns nil when empty."
  [skew]
  (unless (is-empty? skew)
    (var root (skew skew-root))
    (var value (root item))
    (-- (skew skew-size))
    (set (skew skew-root) (merge skew (root left) (root right)))
    value))

(defn- explain-node
  "Prints out a description of the node."
  [node indent]
  (def pad (string/repeat "  " indent))
  (print pad "Node:")
  (print pad "  -item: " (node item))
  (when (node left) (explain-node (node left) (+ 1 indent)))
  (when (node right) (explain-node (node right) (+ 1 indent))))

(defn explain
  "Prints out a diagnostic describing the skewheap and its structure."
  [skew]
  (print "SkewHeap:")
  (print "  -size: " (skew skew-size))
  (unless (is-empty? skew)
    (explain-node (skew skew-root) 1)))
