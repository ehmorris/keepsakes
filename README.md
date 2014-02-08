# Dayview
### Displays QS information in one explorable interface.

### Running the app
* Run `./bin/setup`
* Run `rake db:migrate`
* Fill the `.env` file in with an actual Moves client ID and secret
* Run `foreman start` and  `open http://localhost:3000`

[![Code Climate](https://codeclimate.com/github/ehmorris/dayview.png)](https://codeclimate.com/github/ehmorris/dayview)

#### Potential sources of information
* [Location | Foursquare](https://github.com/mattmueller/foursquare2)
* [Location | Moves](https://dev.moves-app.com)
* [Location | Maps](https://github.com/aai/mapbox-rails)
* [Music | Rdio](http://developer.rdio.com)
* [Work | Github](http://developer.github.com/v3)
* [Pictures | Instagram](http://instagram.com/developer)
* [Weather](https://github.com/dlt/yahoo_weatherman)
* Calendar

#### Ideas
* On the broad strokes made possible by this data: [whichlight's post](http://blog.whichlight.com/post/65575793300/how-the-entropy-of-personal-behaviors-and-social)
* Something like swath summaries could allow someone to find interesting seasons more easily, when faced with 10+ years of daily entries: summarize a summer in a few sentences, a school semester, etc.
* Planar navigation scheme i.e. you zoom into a location to recieve details on it (average time spent there, number of times visited, usual incoming path, etc.) rather than clicking "how long do i usually spend here." Think Iron Man HUD. Zooming in makes the previous content zoom close to you, like you're speeding past it, in perspective with the map. See [The Refugee Project](http://therefugeeproject.org) for a great example:
 
![Whole map view](http://i.imgur.com/Cca1deK.png)
![Map hover view](http://i.imgur.com/DJOgRUg.png)
![Map detail view](http://i.imgur.com/APHJkj9.png)

More examples:
* Z-index navigation: ([Orchestra](http://play.lso.co.uk/#/Ravels-Bolero/orchestra) + [Hover States](http://hoverstat.es/posts/lso-play/))
* [Zoom thumbnail groups](http://hoverstat.es/posts/jake-dinos-chapman/)
