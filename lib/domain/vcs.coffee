eq = (a, b) ->
  a[0] is b[0] and a[1] is b[1] and a[2] is b[2]

gt = (a, b) ->
    (a[0] > b[0]) or (a[0] is b[0] and a[1] > b[1]) or (a[0] is b[0] and a[1] is b[1] and a[2] > b[2])

gte = (a, b) ->
  @gt(a,b) or @eq(a,b)


version = (str) ->
  v = new String(str).match(/^(\d+)\.(\d+)\.(\d+)/)   # very strict: wont even allow whitespace before version
  return false if !v or v.length isnt 4
  v[1..].map((n) -> parseInt(n,10))

template = (str) ->
  str.replace(/^.*\n/,"")

module.exports = {eq, gt, gte, version, template}
