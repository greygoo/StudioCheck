# StudioCheck

StudioCheck is a Cucumber & Gherkin based testing web app for [SUSE
Studio](http://susestudio.com) built appliances.

StudioCheck relies on the wonderful
[StudioApi](https://github.com/jreidinger/studio_api) gem, so the tests are
executed via the Studio API. This has several advantages:

1. Tests can be executed on different servers: susestudio.com or private
instances. This helps users report bugs and verify delivered fixes.

2. Using Gherkin as description language makes tests easy to read and write.
Translation to matchers and API calls are pretty straightforward as well.

## Installation

```
  $ git clone git://github.com/bkutil/StudioCheck.git
  $ cd StudioCheck
  $ bundle install
  $ rake db:migrate
```

StudioCheck uses Resque to execute tests, so the Redis database must be
started, eg:

```
  $ sudo su                 # Switch to root user
  $ rcredis start           # Start redis now
  $ chkconfig redis on      # Automatically start redis on boot
```

## Usage

```
  $ rake resque:work &
  $ rails s 
```
