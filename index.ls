/* expose a subset of an object */
module.exports = (keys, obj) ->
  proxy = {}
  keys.for-each (key) ~>
    Object.define-property do
      proxy
      key
      get: ->
        deep-get obj, key
      set: (val) ->
        deep-set obj, key, val
      enumerable: true
  proxy

/* helper methods */
function deep-get(obj, key)
  deep-get-arr obj, key.split '.'
  
function deep-get-arr(obj, key-arr)
  key = key-arr.shift!
  
  switch key-arr.length
  | 0 => obj[key]
  | _ => deep-get-arr obj[key], key-arr

function deep-set(obj, key, val)
  deep-set-arr obj, key.split('.'), val
  
function deep-set-arr(obj, key-arr, val)
  key = key-arr.pop!
  deep-get-arr(obj, key-arr)[key] = val
