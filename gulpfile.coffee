gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
minify = require 'gulp-minifier'
del = require 'del'

BUILD_DEST = './build/'

gulp.task 'copy', ()->
    gulp.src ['./src/lib/**/*.js']
        .pipe gulp.dest(BUILD_DEST + '/lib')
    gulp.src ['./src/main.js']
        .pipe gulp.dest(BUILD_DEST)


gulp.task 'merge', ['copy'], ()->
    gulp.src ['./build/lib/**/*.js', './build/main.js']
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
        BUILD_DEST + 'lib/',
        BUILD_DEST + 'main.js'

    ]

# 生成md5
gulp.task 'md5', ['build'], ()->
    fs = require 'fs'
    crypto = require 'crypto'

    md5 = crypto.createHash('md5')
        .update(fs.readFileSync('./build/wap.js'))
        .digest('hex')

    console.log md5


gulp.task 'watch', ['build'], ()->
    gulp.watch './src/**/*', ['build']

gulp.task 'default', ['watch']

