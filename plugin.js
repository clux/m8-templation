var path = require('path')
  , fs = require('fs')
  , fsx = require('fsx')
  , vcs = require('./domain/vcs');

function Plugin(template_dir, ext, name) {
  this.template_dir = template_dir;
  this.ext = ext || '.html';
  this.name = name || 'templation';
  if (!path.existsSync(template_dir)) {
    throw new Error("need a valid template directory " + template_dir);
  }
}

Plugin.prototype.domain = function () {
  return path.join(__dirname, 'domain');
};

Plugin.prototype.data = function () {
  var vobj = {}
    , that = this;
  fsx.readDirSync(this.template_dir).files.forEach(function (file) {
    if (path.extname(file) !== that.ext) {
      return; // skip non-templates
    }
    var v = vcs.version(fs.readFileSync(file));
    if (!v) {
      throw new Error('path: ' + file + 'does not start with a valid version number');
    }
    vobj[path.relative(that.template_dir, file).split(that.ext)[0]] = v;
  });
  return vobj;
};

exports.Plugin = Plugin;

if (module === require.main) {
  var tdir = '/home/clux/repos/deathmatchjs/public/tmpl/';
  console.log((new Plugin(tdir)).data());
}

