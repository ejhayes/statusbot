# statusbot

## motivation - what's this for?

This is my activity tracking tool.  The idea is pretty straightforward:

- Once a week, sit down and identify your goals for the week.  Weeks go by so quickly and it is really easy to be aimless.
- At the end of each day, sit down and identify your specific goals for the next day.  This allows you to plan things out when your mind is still fresh from the current day.  It also allows you to figure out how you can implement your overarching weekly goal into an action plan for a specific day.  It also shows you where your time goes during the day.
- At the end of the week, review the week summary and plan for the next week.

I used this strategy a long time ago and found that it worked really well for me.  In the past I had a very manual system though...so I thought it would be fun to build the core functionality into a chat bot that I can talk to during the day.  For the planning and reporting, I'd just go to a web interface, login, and see all my chat updates.

## local development environment - how do I run this thing?

To get started:

    git clone <this repo>
    cd <this repo>
    bundle
    bundle exec shotgun config.ru

To run tests:

    bundle exec rspec

To run database migrations (specify whatever environment you want):

    RACK_ENV=development bundle exec rake db:create
    RACK_ENV=development bundle exec rake db:migrate

## contribute?

We're all bound write lousy code, miss a unit test, or leave out some killer feature.  If you want to contribute just fork this repo, make changes, and submit a pull request.