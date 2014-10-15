# Juicer Client

The API client for the [BBC News Labs Juicer API](http://juicer.bbcnewslabs.co.uk).

NOTE: the Juicer is an experiment run by the BBC News Labs. The API may change
without notice, there are no uptime, reliability guarantees. Please take this
as experimental sofware in front of experimental API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'juicer-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install juicer-client

## Usage

Using the library is very simple. You'll need to obtain an API key from
[BBC Developer Portal](https://developer.bbc.co.uk/) by signing up
and registering a new app for the `bbcrd-juicer-apis` product in the
API listing.

Once you have obtained an API key and have installed the gem, you can
use it by requiring the `juicer` library and instantiating it with
your API key:

```ruby
require 'juicer'

juicer = Juicer.new("<your API key>")
```

Have a look at the
[documentation](http://bbc-news-labs.github.io/juicer-client/Juicer.html)
for the library on how to filter articles, find similar content, etc.

```ruby
juicer.products
=> ["NewsWeb", "Twitter", "Monitoring", "TheMirror", "Jupiter", "TheGuardian", ...]

juicer.articles({text: "London",
                 product: ["NewsWeb"],
                 published_after: "2014-10-14"})
=> [{"title"=>"London Market Report",
     "description"=>"London Market Report",
     "cps_id"=>"news_web_0962731f8c375d5096590ca38cee96e0e408180d",
     "published"=>"2014-10-14T08:14:07.000Z",
     "url"=>"http://www.bbc.co.uk/news/business-29610241#sa-ns_mchannel=rss&ns_source=PublicRSS20-sa",
     "highlight"=>false,
     "source"=>"NewsWeb",
     "format"=>"TextualFormat",
     "image"=>nil,
     "themes"=>[],
     "people"=>[],
     "places"=>[],
     "organisations"=>[{"kind"=>"Organisation", "name"=>"Burberry", ..}]},
    {...}]

juicer.similar_articles("news_web_0962731f8c375d5096590ca38cee96e0e408180d")
=> [{"score"=>1.8277457,
     "title"=>"Mulberry profit warning hits shares",
     "cps_id"=>"20038835",
     "created_at"=>"2012-10-23T12:58:45.247Z",
     "published_at"=>"2012-10-23T11:57:37Z",
     "juicer_url"=>"http://juicer.bbcnewslabs.co.uk/articles/20038835.json",
     "url"=>"http://www.bbc.co.uk/news/business-20038835"},
    {...}]
```

## Contributing

1. Fork it ( https://github.com/BBC-News-Labs/juicer-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
