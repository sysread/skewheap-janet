(def item 0)
(def left 1)
(def right 2)

(defn- merge
  "Recursively merges two nodes, returning a new tree structure."
  [skew a b]
  (cond
    (nil? a) b
    (nil? b) a
    (do
      (var node-a a)
      (var node-b b)

      (when ((skew :cmp) (b item) (a item))
        (set node-a b)
        (set node-b a))

      [(node-a item)
       (merge skew node-b (node-a right))
       (node-a left)])))

(defn make
  "Builds a new, empty skewheap, whose elements will be returned in :cmp order."
  [&opt cmp]
  (default cmp <=)
  @{:cmp cmp
    :size 0
    :root nil})

(defn size
  "The number of elements in the heap"
  [skew]
  (skew :size))

(defn is-empty?
  "True when the heap is empty"
  [skew]
  (= 0 (size skew)))

(defn peek
  "Returns the first item in the heap without removing it."
  [skew]
  (if (is-empty? skew) nil ((skew :root) item)))

(defn put
  "Inserts a new item into the heap. Returns the heap's new size."
  [skew & items]
  (loop [item :in items]
    (set (skew :root)
         (merge
           skew
           (skew :root)
           [item nil nil])))
  (set (skew :size) (+ (skew :size) (length items))))

(defn take
  "Removes and returns an item from the heap. Returns nil when empty."
  [skew]
  (unless (is-empty? skew)
    (let [root (skew :root)
          value (root item)]
      (set (skew :size)
           (- (skew :size) 1))
      (set (skew :root)
           (merge
             skew
             (root left)
             (root right)))
      value)))

(defn- explain-node
  "Prints out a description of the node."
  [node indent]
  (def pad (string/repeat "  " indent))

  (print pad "Node:")
  (print pad "  -item: " (node item))

  (when (node left)
    (explain-node (node left) (+ 1 indent)))

  (when (node right)
    (explain-node (node right) (+ 1 indent))))

(defn explain
  "Prints out a diagnostic describing the skewheap and its structure."
  [skew]
  (print "SkewHeap:")
  (print "  -size: " (skew :size))

  (unless (is-empty? skew)
    (explain-node (skew :root) 1)))

