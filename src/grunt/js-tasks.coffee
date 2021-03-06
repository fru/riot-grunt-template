
defineWrapper = (filepath, options) -> 
  filepath = filepath.replace(/^dist\/raw/, '')
  return [
    ';defineModule("' + filepath + '", function(require, exports, module){'
    '});'
  ]

module.exports =
  copy:
    expand: true
    cwd: 'src/'
    src: ['**/*.js', '!footer.js', '!header.js', '!grunt/**']
    dest: 'dist/raw/'
  jshint:
    options:
      force: true
    expand: true
    cwd: 'src/'
    src: ['**/*.js', '!footer.js', '!header.js', '!grunt/**']
  wrap:
    options:
      wrapper: defineWrapper
    expand: true
    cwd: 'dist/raw/'
    src: ['**/*.js']
    dest: 'dist/dev/'
  concat:
    options:
      separator: '\n'
    src: ['dist/dev/libs.js','src/header.js', 'dist/dev/**/*.js', 'src/footer.js']
    dest: 'dist/client.js'
  uglify:
    expand: true
    cwd: 'dist/'
    src: ['*.js', '!*.min.js']
    dest: 'dist/'
    ext: '.min.js'
  watch:
    files: ['src/**/*.js']
    tasks: ['newer:copy:js', 'newer:jshint:js', 'newer:wrap:js', 'newer:concat:js', 'newer:uglify:js' ]

  
