# NAME

skewheap - a self-balancing priority heap

# INSTALL

    jpm install https://github.com/sysread/skewheap-janet

Or add to your `project.janet` and:

    jpm build

# USAGE

    (import skewheap)

    # Build a skew heap that prioritizes entries by :priority, where a lower
    # number indicates a higher priority.
    (def queue
        (skewheap/make
          (fn (a b)
            (<= (a :priority) (b :priority)))))

    # Insert a bunch of items
    (skewheap/put queue a-bunch-of-tasks)

    # Loop over the items in order by priority and do-stuff-to them
    (loop [task :iterate (skewheap/get queue)
                :until (skewheap/is-empty? queue)]
          (do-stuff-to task))

## skewheap/make

    (skewheap/make &opt cmp)

Builds a new skew heap. Accepts one optional parameter, function that compares
two items and returns true if the first should have priority over the second.

## skewheap/size

    (skewheap/size queue)

Returns the number of items in the queue.

## skewheap/is-empty?

    (skewheap/is-empty? queue)

Returns true if the queue has zero items in it.

## skewheap/peek

    (skewheap/peek queue)

Returns the first item in the queue without removing it from the queue. Returns
`nil` if the queue is empty.

## skewheap/take

    (skewheap/take queue)

Removes and returns the next item in the queue. Returns `nil` if the queue is
empty.

## skewheap/put

    (skewheap/put queue & items)

Adds one or more items to the queue.

## skewheap/explain

    (skewheap/explain queue)

Prints out the queue's tree structure for debugging purposes.
