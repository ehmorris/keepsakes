### keepsakes — displays QS information in one explorable interface.

#### Running the app
* Run `./bin/setup`
* Run `rake db:migrate`
* Fill the `.env` file in with an actual Moves client ID and secret
* Run `foreman start` and  `open http://localhost:3000`

#### Dashboards
* [Mailgun](https://mailgun.com/cp?)
* [Mapbox](https://www.mapbox.com/projects)
* [Moves](https://dev.moves-app.com/apps)
* [![Code Climate](https://codeclimate.com/github/ehmorris/keepsakes.png)](https://codeclimate.com/github/ehmorris/keepsakes)

#### Potential sources of information
* [Location | Moves](https://dev.moves-app.com)
* [Location | Maps](https://github.com/aai/mapbox-rails)
* [Music | Rdio](http://developer.rdio.com)
* [Work | Github](http://developer.github.com/v3)
* [Pictures | Instagram](http://instagram.com/developer)
* Text messages (will have to include instructions for android / ios / other)
* [Journal](https://idonethis.com)
* [Calendar](https://developers.google.com/google-apps/calendar/)
* [Weather](http://openweathermap.org/)

#### Ideas
* On the broad strokes made possible by this data: [whichlight's post](http://blog.whichlight.com/post/65575793300/how-the-entropy-of-personal-behaviors-and-social)
* For viewing lots of days at once, something like day-group summaries could allow someone to find interesting groups of time more easily i.e. seasons, semesters, winter break, vacations, etc. When faced with 10+ years of daily entries, how should the interface change? Textually, could we summarize a summer in a few sentences, a semester?
