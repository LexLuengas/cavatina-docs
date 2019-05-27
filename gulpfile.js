// Less configuration
var gulp = require('gulp');
var less = require('gulp-less');
var sourcemaps = require('gulp-sourcemaps');

gulp.task('less', function(cb) {
    gulp.src('resources/css/*.less')
        .pipe(sourcemaps.init())
        .pipe(less())
        .pipe(sourcemaps.write())
        .pipe(gulp.dest(function(f) {
            return f.base;
        }));
    cb();
});

gulp.task('default', gulp.series('less', function(cb) {
    gulp.watch('resources/css/*.less', gulp.series('less'));
    cb();
}));
