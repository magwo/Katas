logger = require "logme"

chop_iterative = (e, elements) ->
  logger.debug "Finding #{e} in", elements
  left = 0
  right = Math.max(0, elements.length - 1)
  while true
    i = left + Math.floor (right - left) / 2
    logger.debug "left #{left} right #{right} i #{i}"
    if elements[i] == e
      logger.debug "#{i} contains #{e}"
      return i
    else if left == right
      logger.debug "Not found"
      return -1
    else if e < elements[i]
      right = i
    else if e > elements[i]
      left = i + 1
    else
      throw "Wat"



chop = (e, elements, algorithm) ->
  return algorithm(e, elements)


assert_equal = (v0, v1) ->
  if v0 == v1
    console.log "..."
  else
    logger.error "Assert failed: #{v0} is not equal to #{v1}"
    throw "OMG"
    return false

test_chop = (algorithm) ->
  fail = false
  fail = fail or assert_equal(-1, chop(3, [], algorithm))
  fail = fail or assert_equal(-1, chop(3, [1], algorithm))
  fail = fail or assert_equal(0,  chop(1, [1], algorithm))

  fail = fail or assert_equal(0,  chop(1, [1, 3, 5], algorithm))
  fail = fail or assert_equal(1,  chop(3, [1, 3, 5], algorithm))
  fail = fail or assert_equal(2,  chop(5, [1, 3, 5], algorithm))
  fail = fail or assert_equal(-1, chop(0, [1, 3, 5], algorithm))
  fail = fail or assert_equal(-1, chop(2, [1, 3, 5], algorithm))
  fail = fail or assert_equal(-1, chop(4, [1, 3, 5], algorithm))
  fail = fail or assert_equal(-1, chop(6, [1, 3, 5], algorithm))

  fail = fail or assert_equal(0,  chop(1, [1, 3, 5, 7], algorithm))
  fail = fail or assert_equal(1,  chop(3, [1, 3, 5, 7], algorithm))
  fail = fail or assert_equal(2,  chop(5, [1, 3, 5, 7], algorithm))
  fail = fail or assert_equal(3,  chop(7, [1, 3, 5, 7], algorithm))
  fail = fail or assert_equal(-1, chop(0, [1, 3, 5, 7], algorithm))
  fail = fail or assert_equal(-1, chop(2, [1, 3, 5, 7], algorithm))
  fail = fail or assert_equal(-1, chop(4, [1, 3, 5, 7], algorithm))
  fail = fail or assert_equal(-1, chop(6, [1, 3, 5, 7], algorithm))
  fail = fail or assert_equal(-1, chop(8, [1, 3, 5, 7], algorithm))

  if fail then console.log "FAILED" else console.log "PASSED"

# Disable debug normally
logger.debug = (args...) ->
  0
test_chop(chop_iterative)