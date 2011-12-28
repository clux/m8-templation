function eq(a, b) {
  return a[0] === b[0] && a[1] === b[1] && a[2] === b[2];
}

function gt(a, b) {
  return (a[0] > b[0]) || (a[0] === b[0] && a[1] > b[1]) || (a[0] === b[0] && a[1] === b[1] && a[2] > b[2]);
}

function gte(a, b) {
  return gt(a, b) || eq(a, b);
}

// parsers
function version(str) {
  var v = String(str).match(/^(\d+)\.(\d+)\.(\d+)/); // very strict
  if (!v || v.length !== 4) {
    return false;
  }
  return v.slice(1).map(function (n) {
    return parseInt(n, 10);
  });
}

function template(str) {
  return String(str).replace(/^[\w]*\n/, '');
}

function parse(str) {
  return [version(str), template(str)];
}

module.exports = {
  eq        : eq
, gt        : gt
, gte       : gte
, parse     : parse
, version   : version
, template  : template
};

