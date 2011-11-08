#Template VCS for modul8
m8-templation is a simple version control system for web application templates relying on [modul8](https://github.com/clux/modul8) for deployment.

If a web application wants to store all the templates used by the application in localStorage, then they can become out of date with the server.
This module allows these templates to always stay in sync with the server by bundling the current server versions of the templates and some helper methods to compare them.

## Pre-Requisites
All versions must be prepended with a new line with a version string line of form 'int.int.int'.
This is a limitation if you need rendering of templates to happen on the server - the first line of each template has to be removed first.
For web applications on the other hand, rendering happens entirely on the client side. We aim simply to facitilate this choice of behaviour.

## Usage
Install with

    $ npm install m8-templation

then require, and pass it to modul8

    var TemplateVcs = require('m8-templation')
    modul8('./client/app.js')
      .use(new TemplateVcs('./directory/'))
      .compile('./out.js')

Optionally, an object can be specified as a second argument to the constructor to tweak the module's behavior. It's keys are:

- `ext` - Extensions to filter the scanning by (defaults to '.html')
- `domain` - Domain to export client versioning code to (defaults to 'template')
- `key` - Key on the data domain to export the templates to (defaults to 'versions')


## Behavior
All files in a directory are scanned (recursively) for templates. If all matching files contain a valid template on the first line,
the versions will be extracted and added to the data domain under a sensible key (base_dir+'/user/edit.html' => 'user/edit').

The client can require tools for decoupling the version and the template from the file + methods for comparing different versions.
This code is available on the template domain under `template::vcs`, wheras template versions are included on the data domain, where its container can be
required under `data::versions`.

With this data and code you will be able to simply check whether the template you've got in localStorage matches the one in your config.
If it does, you can safely keep using the browser's cached version, if not, an ajax fetch is required.


## License
MIT Licensed - See LICENSE file for details
