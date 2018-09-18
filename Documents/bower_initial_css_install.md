
<!-- This is the terminal snapshot of steps of initial bower/? css install steps after git pull-->
```
Nanis-MacBook-Air:tech-access ssun2$ git checkout -b css-works
Switched to a new branch 'css-works'
Nanis-MacBook-Air:tech-access ssun2$ npm i
audited 20040 packages in 7.338s
found 0 vulnerabilities

Nanis-MacBook-Air:tech-access ssun2$ npm install -g bower
npm WARN deprecated bower@1.8.4: We don't recommend using Bower for new projects. Please consider Yarn and Webpack or Parcel. You can read how to migrate legacy project here: https://bower.io/blog/2017/how-to-migrate-away-from-bower/
/usr/local/bin/bower -> /usr/local/lib/node_modules/bower/bin/bower
+ bower@1.8.4
added 1 package from 1 contributor in 3.795s
Nanis-MacBook-Air:tech-access ssun2$ ls
Documents		config.env		database		package-lock.json	public
README.md		coverage		node_modules		package.json		src
Nanis-MacBook-Air:tech-access ssun2$ cd public/stylesheets
Nanis-MacBook-Air:stylesheets ssun2$ ls
bower.json	main.css	main.css.map	main.scss
Nanis-MacBook-Air:stylesheets ssun2$ bower install
bower o-grid#^4.4.3         not-cached https://github.com/Financial-Times/o-grid.git#^4.4.3
bower o-grid#^4.4.3            resolve https://github.com/Financial-Times/o-grid.git#^4.4.3
bower o-grid#^4.4.3           download https://github.com/Financial-Times/o-grid/archive/v4.4.3.tar.gz
bower o-grid#^4.4.3            extract archive.tar.gz
bower o-grid#^4.4.3           resolved https://github.com/Financial-Times/o-grid.git#4.4.3
bower sass-mq#^5.0.0        not-cached https://github.com/sass-mq/sass-mq.git#^5.0.0
bower sass-mq#^5.0.0           resolve https://github.com/sass-mq/sass-mq.git#^5.0.0
bower sass-mq#^5.0.0          download https://github.com/sass-mq/sass-mq/archive/v5.0.0.tar.gz
bower sass-mq#^5.0.0           extract archive.tar.gz
bower sass-mq#^5.0.0          resolved https://github.com/sass-mq/sass-mq.git#5.0.0
bower o-grid#^4.4.3            install o-grid#4.4.3
bower sass-mq#^5.0.0           install sass-mq#5.0.0

o-grid#4.4.3 bower_components/o-grid
└── sass-mq#5.0.0

sass-mq#5.0.0 bower_components/sass-mq
Nanis-MacBook-Air:stylesheets ssun2$ sass --watch main.scss main.css
File main.css is a CSS file.
    Did you mean: sass --watch main.scss:main.css
  Use --trace for backtrace.
Nanis-MacBook-Air:stylesheets ssun2$ sass --watch main.scss:main.css
>>> Sass is watching for changes. Press Ctrl-C to stop.
      error bower_components/o-grid/main.scss (Line 7: File to import not found or unreadable: sass-mq/mq.)




>>> Change detected to: bower_components/o-grid/main.scss
      write main.css
      write main.css.map
      ```
