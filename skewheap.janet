(defmacro- cmp-nodes
  "Expands to using the skewheap's :cmp to compare the :item of two nodes"
  [skew a b]
  ~((,skew :cmp) (,a :item) (,b :item)))

(defn- make-node
  "Builds a node table for :item with optional :left and :right children"
  [item &opt left right]
  @{ :item item
     :left left
     :right right })

(defn- merge-nodes
  "Recursively merges two nodes, returning a new tree structure."
  [skew a b]
  (cond
    (nil? a) b
    (nil? b) a
    (do
      (var node-a a)
      (var node-b b)

      (when (cmp-nodes skew b a)
        (set node-a b)
        (set node-b a))

      (def {:item item
            :left left
            :right right}
        node-a)

      (make-node item
                 (merge-nodes skew node-b right)
                 left))))

(defn make
  "Builds a new, empty skewheap, whose elements will be returned in :cmp order."
  [&opt cmp]
  (default cmp <=)
  @{:cmp cmp
    :size 0
    :root nil})

(defmacro size
  "The number of elements in the heap"
  [skew]
  ~(,skew :size))

(defmacro is-empty?
  "True when the heap is empty"
  [skew]
  ~(= 0 (size skew)))

(defn peek
  "Returns the first item in the heap without removing it."
  [skew]
  (if (is-empty? skew)
    nil
    ((skew :root) :item)))

(defn put
  "Inserts a new item into the heap. Returns the heap's new size."
  [skew item]
  (set (skew :root)
       (merge-nodes
         skew
         (skew :root)
         (make-node item)))
  (++ (skew :size)))

(defn take
  "Removes and returns an item from the heap. Returns nil when empty."
  [skew]
  (if (is-empty? skew)
    nil
    (let (item ((skew :root) :item))
      (set (skew :size)
           (- (skew :size) 1))
      (set (skew :root)
           (merge-nodes
             skew
             ((skew :root) :left)
             ((skew :root) :right)))
      item)))

(defn- explain-node
  "Prints out a description of the node."
  [node indent]
  (def pad (string/repeat "  " indent))

  (print pad "Node:")
  (print pad "  -item: " (node :item))

  (when (node :left)
    (explain-node (node :left) (+ 1 indent)))

  (when (node :right)
    (explain-node (node :right) (+ 1 indent))))

(defn explain
  "Prints out a diagnostic describing the skewheap and its structure."
  [skew]
  (print "SkewHeap:")
  (print "  -size: " (skew :size))

  (unless (is-empty? skew)
    (explain-node (skew :root) 1)))

