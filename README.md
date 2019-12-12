# Turing Tutorials

This is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags. A user coming to the site to learn can also connect their GitHub account to their profile and make friends with their GitHub followers and/or those following them.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

Created as a brownfield learning project for Turing School Backend Engineering Program.

## Local Setup

Clone down the repo
```
$ git clone
```

Install the gem packages
```
$ bundle install
```

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Set up Figaro or other ENV variable tool:
```
figaro install
```

Obtain API Keys and save to local environment:
```
ENV['YOUTUBE_API_KEY']: <YOUTUBE>
ENV['SENDGRID_API_KEY']: <SENDGRID>
ENV['GITHUB_ID']: <GITHUB OAUTH ID>
ENV['GITHUB_SECRET']: <GITHUB OAUTH TOKEN>
ENV['GITHUB_TEST_TOKEN']: <GITHUB TESTING>
```

Run the test suite:
```ruby
$ bundle exec rspec
```

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* Testing Suite: RSpec, Capybara, Selenium, VCR, WebMock
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

### Versions
* Ruby 2.4.1
* Rails 5.2.0
