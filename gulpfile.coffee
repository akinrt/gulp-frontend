# ==============================================================================
# gulp.coffee
# ------------------------------------------------------------------------------
# Gulp ☃
# ==============================================================================

# ==============================================================================
# TABLE OF CONTENTS
# ------------------------------------------------------------------------------
#   a. Require plugins
#   b. Define directories
#   c. Common tasks
#   d. haml
#   e. copy:img
#   f. stylus
# ==============================================================================

'use strict'

# Require and load tasks
# ==============================================================================
gulp         = require 'gulp'
path         = require 'path'
watch        = require 'gulp-watch'
coffee       = require 'gulp-coffee'
haml         = require 'gulp-ruby-haml'
csscomb      = require 'gulp-csscomb'
csslint      = require 'gulp-csslint'
uglify       = require 'gulp-uglify'
stylus       = require 'gulp-stylus'
autoprefixer = require 'gulp-autoprefixer'

pkg      = require path.join process.cwd(), "package.json"

# Define directories
# ==============================================================================

dir           = {}
dir.root      = '';
dir.dest      = dir.root + 'dest/'
dir.haml      = dir.root + 'haml/'
dir.images    = dir.root + 'images/'
dir.scripts   = dir.root + 'scripts/'
dir.stylus    = dir.root + 'stylus/'
dir.destHaml  = dir.dest
dir.destCss   = dir.dest + 'custom/ach/css/'
dir.destJs    = dir.dest + 'custom/js/'
dir.destImage = dir.dest + 'custom/ach/img/'

# Common tasks
# ==============================================================================
gulp.task 'default', ['watch'],()->
  return

# gulp.task 'build', ['sass', 'haml', 'copy:img', 'csscomb', 'stylus'], ()->
gulp.task 'build', ['stylus'], ()->
# gulp.task 'build', ['sass'], ()->
  console.log "builded frontend resource @ " + dir.dest
  return

gulp.task 'watch', ()->
  console.log "watch start"
  watcher = gulp.watch dir.sass + '*.scss', ['sass', 'css-lint']
  watcher = gulp.watch dir.haml + '*.haml', ['haml']
  watcher.on 'change', (event)->
    console.log 'File ' + event.path + ' was ' + event.type + ', running tasks...'
  return

# haml
# ==============================================================================
gulp.task 'haml', ()->
  return gulp.src 'haml/*.haml'
    .pipe haml {doubleQuote: true}
    .pipe gulp.dest dir.destHaml
    .on 'end', ()->
      console.log '[haml] task ended'

# copy:img
# ==============================================================================
gulp.task 'copy:img', ()->
  return gulp.src [ dir.images + '*.*' ], { base: dir.images }
    .pipe gulp.dest dir.destImage
    .on 'end', ()->
      console.log '[copy:img] task ended'

# csscomb
# ==============================================================================
gulp.task 'csscomb', ()->
  return gulp.src dir.destCss + '*.css'
    .pipe csscomb()
    .pipe gulp.dest dir.destCss
    .on 'end', ()->
      console.log '[csscomb] task ended'

# css lint
# ==============================================================================
gulp.task 'css-lint', ()->
  return gulp.src dir.destCss + '*.css'
    .pipe csslint dir.root + '.csslintrc'
    .pipe csslint.reporter()
    .on 'end', ()->
      console.log '[css-lint] task ended'

# stylus
# ==============================================================================
gulp.task 'stylus', ()->
  gulp.src dir.stylus + 'main.styl'
    # .pipe stylus(compress: true)
    .pipe stylus()
    .pipe autoprefixer()
    .pipe gulp.dest dir.destCss

