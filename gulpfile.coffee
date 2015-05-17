gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
minify = require 'gulp-minifier'
del = require 'del'

BUILD_DEST = './build/'

gulp.task 'copy', ()->
    gulp.src ['./src/fetch.js']
        .pipe gulp.dest(BUILD_DEST)


gulp.task 'compile', ()->
    gulp.src ['./src/**/*.coffee']
        .pipe coffee()
        .pipe gulp.dest(BUILD_DEST)


gulp.task 'merge', ['copy', 'compile'], ()->
    gulp.src ['./build/fetch.js', './build/main.js']
        .pipe concat('wap.js')
        .pipe minify
                minify: true,
                collapseWhitespace: true,
                conservativeCollapse: true,
                minifyJS: true,
        .pipe gulp.dest(BUILD_DEST)

gulp.task 'build', ['merge'], ()->
    # clean
    del [
        BUILD_DEST + 'fetch.js',
        BUILD_DEST + 'main.js'

    ]

gulp.task 'default', ['build']

