### keepsakes — displays QS information in one explorable interface.

#### Running the app
* Run `./bin/setup`
* Run `rake db:migrate`
* Fill the `.env` file in with an actual Moves client ID and secret
* Run `foreman start` and  `open http://localhost:3000`

#### Required developer accounts
* [Moves](https://dev.moves-app.com)
* [Instagram](http://instagram.com/developer)
* [Mapbox](https://www.mapbox.com/developers)
* [Wunderground](http://www.wunderground.com/weather/api)
* [Geonames](http://www.geonames.org)
  * Note: you need to enable "free web services" on the account: [geonames.org/enablefreewebservice](http://www.geonames.org/enablefreewebservice)

#### Dashboards
* [Mailgun](https://mailgun.com/cp?)
* [Mapbox](https://www.mapbox.com/projects)
* [Moves](https://dev.moves-app.com/apps)
* [![Code Climate](https://codeclimate.com/github/ehmorris/keepsakes.png)](https://codeclimate.com/github/ehmorris/keepsakes)

#### Potential sources of information
* [x] [Location | Moves](https://dev.moves-app.com)
* [x] [Location | Maps](https://github.com/aai/mapbox-rails)
* [ ] [Music | Rdio](http://developer.rdio.com) (History is unavailable through their API, have to use LastFM)
* [ ] [Work | Github](http://developer.github.com/v3)
* [x] [Pictures | Instagram](http://instagram.com/developer)
* [x] [Text messages](http://www.ecamm.com/mac/phoneview/) (will have to include instructions for android / ios / other). Alternatively: [Using node to monitor/read iMessages](https://github.com/nicola/node-imessage).
* [ ] [Journal](https://idonethis.com)
* [ ] [Calendar](https://developers.google.com/google-apps/calendar/)
* [x] [Weather](http://www.wunderground.com/weather/api)

### Make available as a native app
* https://github.com/rogerwang/node-webkit
* https://sandstorm.io
* https://github.com/atom/atom-shell

#### Ideas
* On the broad strokes made possible by this data: [whichlight's post](http://blog.whichlight.com/post/65575793300/how-the-entropy-of-personal-behaviors-and-social)
* For viewing lots of days at once, something like day-group summaries could allow someone to find interesting groups of time more easily i.e. seasons, semesters, winter break, vacations, etc. When faced with 10+ years of daily entries, how should the interface change? Textually, could we summarize a summer in a few sentences, a semester?
