# Landable

Rails engine providing an API and such for managing mostly static content.


## Installation

Add `gem 'landable'` to your project's Gemfile.

Run `bundle exec rails g landable:install`, and update the new landable initializer to taste.

Open your routes file, and ensure that the engine is mounted properly. Typically, this will be your final, catch-all route:

```ruby
My::Application.routes.draw do
  mount Landable::Engine => '/'
end
```

Asset storage defaults to the local filesystem. To modify this, configure [CarrierWave][carrierwave] and [Fog][fog]:

```ruby
# config/initializers/carrier_wave.rb, perhaps
CarrierWave.configure do |config|
  config.root      = Rails.root.join('public/uploads')
  config.cache_dir = Rails.root.join('tmp/carrierwave')

  # For example, using Fog for AWS:
  config.store = :fog
  config.fog_credentials = {
    provider: 'AWS',
    # etc; see the CarrierWave and Fog docs.
  }

  # Or, in development or test, maybe just store locally:
  config.store = :file
end
```

Finally, install Landable's migrations:

```sh
rake landable:install:migrations
rake db:migrate
```

### Categories
Landable comes with default categories that you can see [here](https://git.cashnetusa.com/trogdor/landable/blob/master/lib/landable/configuration.rb#L26). You can overwrite these categories in your initializer.

```ruby
Landable.configure do |config|
  config.categories.merge!({ 'CatName' => 'Description', 
                             'CatName2' => 'Description2' })
end
```

### Sitemap
Landable comes with an automatic sitemap generator that you can configure in your initializer. See your sitemap at ```/sitemap.xml```

```ruby
Landable.configure do |config|
  # Keeps pages with testing category out of sitemap (defaults to [])
  config.sitemap_exclude_categories = %w(Testing) 
  
  # Configures protocol to be used in sitemap (defaults to 'http')
  config.sitemap_protocol = "https" 
  
  # Configures host name to be used in sitemap (defaults to 'request.host')
  config.sitemap_host = "www.example.com" 
  
  # Landable sitemap generator only includes pages in Landable.  To include other pages, add them as an array like so in your initializer. 
  config.sitemap_additional_paths = %w(/ /terms-of-use.html /privacy-policy.html) 
end
```

### Reserving Page Paths
Landable allows you to reserve paths in your initalizer preventing users from creating pages with these paths.  You can enter these reserved paths as a RegEx as well! Specific reserved paths must start with a slash, and RegEx paths must not start with a slash as shown in the example below.

```ruby
Landable.configure do |config|
  # Users will not be able to create Publicist Pages with these paths / paths matching these RegExs
  config.reserved_paths = %w(/ /terms-of-use.html /privacy-policy.html regex_path\/\w*)
end
```

### Partial To Publicist Template Support
Landable allows you to create [Publicists](http://git.cashnetusa.com/trogdor/publicist) Templates out of partials from your source code. For example, lets say you wanted to create templates out of your header (Defined in app/views/layouts/_header.html.haml) and footer (Defined in app/views/layouts/_footer.html.haml).

You can do this like so...
```ruby
Landable.configure do |config|
  config.partials_to_templates = %w(layouts/header layouts/footer)
end
```

## Visit Tracking
Landable includes the ability to track visits.

```ruby
Landable.configure do |config|
  # To enable tracking, put one of the following in your Landable initializer:
  config.traffic_enabled = true  # Enables tracking for all requests.  (:all is also accepted here.)
  config.traffic_enabled = :html # Enables tracking for only HTML requests.
end
```

## Development

Run `./bin/redb` to refresh the dummy app's database.

Run the test suite with `rake landable`.

Contributions are welcome - submit a pull request.

* Do include specs to back up all code changes.
* Do add your changes to the "unreleased" section of [CHANGELOG.md](CHANGELOG.md) (adding this section if it does not exist). Include the pull request number.
* Don't bump Landable's version number.


## Releases

The Landable gem may be built and released by a maintainer at any time. (If you are not a maintainer, skip the rest of this section. Extra top secret.)

1. Ensure all required pull requests have been merged.
4. Ensure `rake landable` succeeds.
2. Update `lib/landable/version.rb` according to [semantic versioning](http://semver.org/) rules.
3. Rename the unreleased section of [CHANGELOG.md](CHANGELOG.md) to the release version number. Include a Github compare link against the previous version.
4. `commit -a -m "Release vX.Y.Z"`, and push to master.
5. `rake release`

If this is your first time running a release, configure geminabox first:

```sh
gem inabox -c # when prompted, enter http://gems.enova.com as the host
```

## See Also

Related projects we are also building:

1. [publicist](http://git.cashnetusa.com/trogdor/publicist): a web app for working with landable applications

[carrierwave]: https://github.com/carrierwaveuploader/carrierwave
[fog]: https://github.com/fog/fog
