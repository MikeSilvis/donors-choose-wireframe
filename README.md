Donors Team 6
=============

# Setup

1. `git clone git://github.com/worace/donors-choose-wireframe.git`

### Install Pre-release Bundler -- don't worry -- this is safe!

2. `gem install bundler --pre`

3. `bundle`

4. `bundle exec rake db:migrate`

5. `bundle exec rake db:test:prepare`

### Export Keys:

In Bash Profile:

6. `export TWITTER_CONSUMER_KEY="6PA2o1Y9veNxOsSOzUzQ"`
   `export TWITTER_CONSUMER_SECRET="M5VqJufusXeR0D1dz3WYLxQDcJsQVGrLo4X4GxNCw"`
   `export AWS_ACCESS_KEY='AKIAIQ6A4WA26WTJAN2Q'`
   `export AWS_SECRET_ACCESS_KEY='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'`

7. `source ~/.bash_profile`

8. Run Redis: `redis-server /usr/local/etc/redis.conf`

9. run the worker: `VERBOSE=TRUE QUEUE=* bundle exec rake environment resque:work`

10. run the scheduler: `VERBOSE=TRUE QUEUE=* bundle exec rake resque:scheduler`

11. run the tests: `bundle exec rspec`

12. run the server: `bundle exec rails s`



### Who's it for

  Potential Characters:

    * Teacher's friend group: give a concentrated way for these types of people to contribute to smaller projects

    * PTA/community members: Provide actionable steps for small groups to attack fundraising

    * Students/faculty members? A more public platform for these people
to interact with their potential donors


### What does it attack

  * Problem: Giving to DC can feel like an isolated/individual
experience, yet the projects have very community-oriented impact
  * These are the types of projects that groups of people are likely to
care about, but there is not much interface for them to share their
interest or contributions
  * Provide a public facing interface for people to track their
contributions toward raising money for DC projects

### How does it attack it

  * Give basic tasks and advice to guide contributions

  * Track exploits and contributions as means of encouragement

  * Give a mechanism to convert user actions into fundraising
(challenges, "points" system, sweat equity)

### Expected results

  * Focused activity on selected projects
  * Projects that get attention from a team should raise $$ faster than
those that just sit around

### Action step

  * Adopt a project via the site.

  * Assemble your squad

  * Potential integration with the "donors select" group for picking
projects after filtering.

