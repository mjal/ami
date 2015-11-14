var gulp = require('gulp');

var gutil = require('gulp-util');
var coffee = require('gulp-coffee');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var addsrc = require('gulp-add-src');
var inline = require('gulp-inline');
var minifyCss = require('gulp-minify-css');

gulp.task('js', function() {
  gulp.src(['./src/coffee/config.coffee', './src/coffee/index.coffee'])
    .pipe(concat("application.coffee"))
    .pipe(coffee().on('error', gutil.log))
    .pipe(addsrc('./src/js/*.js'))
    .pipe(concat("index.js"))
    .pipe(uglify())
    .pipe(gulp.dest('./dist/'))
});

gulp.task('css', function() {
  gulp.src('./src/index.css')
    .pipe(minifyCss())
    .pipe(gulp.dest('./dist/'))
});

gulp.task('dist', function() {
  gulp.src('./src/index.html')
    .pipe(inline({disabledTypes: ['img']}))
    .pipe(gulp.dest('./dist/'))
});

gulp.task('default', ['js', 'css', 'dist']);
