'use strict';

const argv = require('yargs').argv;
const fsExtra = require('fs-extra');
const fs = fsExtra;
const gulp = require('gulp');
const imagemin = require('gulp-imagemin');
const myLog = console.log
const path = require('canonical-path');
const yamljs = require('yamljs');

const _configYml = yamljs.load('_config.yml');
const source = _configYml.source || _throw();

gulp.task('compress-images', () => {
  const baseDir = argv.path
    ? path.resolve(argv.path)
    : path.resolve(source);
  if (!fs.existsSync(baseDir)) throw `ERROR: compress-images: path DNE "${baseDir}".`;
  myLog(`Compressing image files under: ${baseDir}`);
  return gulp.src([
    `${baseDir}/**/*.gif`,
    `${baseDir}/**/*.jpg`,
    `${baseDir}/**/*.jpeg`,
    `${baseDir}/**/*.png`,
    `!${baseDir}/**/.*/**`,
    `!${baseDir}/**/build/**`,
    `!${baseDir}/**/node_modules/**`,
  ], { base: baseDir })
    .pipe(imagemin([
      // imagemin.gifsicle({interlaced: true}),
      // imagemin.jpegtran({progressive: true}),
      imagemin.optipng({ optimizationLevel: 4 })]))
    .pipe(gulp.dest(baseDir))
});

// Used to ensure that values/properties that are looked up from external
// sources are actually defined (when expecting a truthy value).
// Idiom: const foo = lookup('bar') || _throw()
function _throw(opt) { throw 'Unexpected value' + opt ? `:${opt}` : ''; }
