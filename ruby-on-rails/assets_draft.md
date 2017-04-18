# Asset Pipeline

## Features
Main feature: concatenate assets, reduce the number of requests that a browser makes to render a web page.
Second feature: asset minification or compression
Third feature: css and js preprocessors (Sass, CoffeeScript)

## Fingerprinting
When the file contents change, the filename is also changed.

## Usage
Stored in app/assets
In production Rails precompiles these files to public/assets. The precompiled copies are then served as static assets by the web server.

### Organization
app/assets - assets owned by the application
lib/assets - your own libraries' code that doesn't really fit into the scope of the application or those libraries which are shared across applications
vendor/assets - owned by outside entities, such as code for JavaScript plugins and CSS frameworks

### Erb
The asset pipeline automatically evaluates ERB.
'''css
.class { background-image: url(<%= asset_path 'image.png' %>) }
'''
'''sass
image-url("rails.png") # => url(/assets/rails.png)
image-path("rails.png") # => "/assets/rails.png"
'''
'''js
$('#logo').attr({ src: "<%= asset_path('logo.png') %>" });
'''

'''coffee
$('#logo').attr src: "<%= asset_path('logo.png') %>"
'''

### Manifest files and directives

application.js
'''
// ...
//= require jquery
//= require jquery_ujs
//= require_tree .
'''

application.css

/* ...
*= require_self
*= require_tree .
*/

### Preprocessing
The file extensions used on an asset determine what preprocessing is applied

In development mode, or if the asset pipeline is disabled, when these files are requested they are processed by the processors provided by the coffee-script and sass gems and then sent back to the browser as JavaScript and CSS respectively. 
When asset pipelining is enabled, these files are preprocessed and placed in the public/assets directory for serving by either the Rails app or web server.

Multiple preprocessing:
app/assets/stylesheets/projects.scss.erb => first erb, then scss, served as css - order of preprocessors is important

### In Development 
Assets are served as separate files in the order they are specified in the manifest file.


### In Production
By default Rails assumes assets have been precompiled and will be served as static assets by your web server.

Task to run during deployment:
'''
RAILS_ENV=production bin/rails assets:precompile
'''
It's included in capistrano:
'''
load 'deploy/assets'
'''






