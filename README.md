# Appspider plugin for Jenkins

This plugin (when done) will be used by developers to add to their Jenkins CI to 
trigger a AppSpider task (currently it's just a scan) 

## Development

For development and to see this plugin in a test Jenkins server:

```
$ rvm install jruby-1.7.20
$ bundle install
$ jpi server
```

## Requirements

* Jenkins CI
* install the ruby-runtime plugin for Jenkins
* JAVA_OPTS = "-Djava.awt.headless=true -Xmx1048m -XX:+UseConcMarkSweepGC"
