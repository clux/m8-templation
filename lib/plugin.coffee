path    = require 'path'
fs      = require 'fs'
fsx     = require 'fsx'
vcs     = require './domain/vcs'


class Plugin
  constructor : (@template_dir, @ext='.html', @name='templation') ->
    throw new Error("need a valid template directory #{@template_dir}") if !path.existsSync(@template_dir)

  domain : ->
    __dirname+'/domain/' # makes vcs requirable as templation::vcs

  data : ->
    vobj = {}
    for file in fsx.readDirSync(@template_dir).files when path.extname(file) is @ext
      v = vcs.version(fs.readFileSync(file))
      throw new Error("path: #{file} does not start with a valid version number") if !v
      vobj[path.basename(file).split(@ext)[0]] = v
    vobj


module.exports = Plugin

if module is require.main
  console.log (new Plugin('/home/clux/repos/deathmatchjs/public/tmpl/')).data()
