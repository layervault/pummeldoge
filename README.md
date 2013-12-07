# Pummeldoge

An example Rails app that uses the [LayerVault API](https://developers.layervault.com).

What does it do? It makes sweet GIFs and MOVs of your work, like so:

![](https://f.cloud.github.com/assets/47004/1699314/0d639c28-5f90-11e3-8900-11aaccd064e8.gif)

The above GIF was created from [this LayerVault public project](https://layervault.com/kelly-sutton/Pummeldoge).

## Installation

pummeldoge is a Rails 4 application. You will need [gifsicle](http://www.lcdf.org/gifsicle/),
[ffmpeg](https://trac.ffmpeg.org/wiki/MacOSXCompilationGuide),
and [imagemagick](http://stackoverflow.com/questions/7053996/how-do-i-install-imagemagick-with-homebrew) installed.

You will also need to register a LayerVault application. You can do that from your [LayerVault Development](https://layervault.com/settings/development) page.
(Account required. Accounts are free.)

Next, define your API keys in your shell:

```
export LAYERVAULT_CLIENT_ID=MY_LAYERVAULT_CLIENT_ID_FROM_THE_SITE
export LAYERVAULT_CLIENT_SECRET=MY_LAYERVAULT_SECRET_FROM_THE_SITE
```

Then:

```
git clone git@github.com:layervault/pummeldoge.git
cd pummeldoge
bundle
bundle exec foreman start
open http://localhost:3000
```

Hot doge!

## Notes

This app uses [Sidekiq](https://github.com/mperham/sidekiq) and [postgres](http://www.postgresql.org/).
That might seem a little heavy for a demo app. This is done to cut down on processing time,
most folks likely have multi-core processors these days. If we're doing a lot of work at the same time,
the Rails-default SQLite3 has terrible write performance. To fix that, we use postgres by default.

*You will need to change your username in `config/database.yml`* to take advantage of postgres.

## API Notes

This example application is a good demonstration of top-to-bottom use of the [LayerVault API](https://developers.layervault.com).

To authenticate users, we use the [omniauth-layervault](https://github.com/layervault/omniauth-layervault) gem. You can
see how we create a `User` object from the response in
[app/controllers/auth_controller.rb](https://github.com/layervault/pummeldoge/blob/master/app/controllers/auth_controller.rb) and [app/models/user.rb](https://github.com/layervault/pummeldoge/blob/master/app/models/user.rb).

To actually get data out of LayerVault, we use the [layervault](https://github.com/layervault/layervault_ruby_client) gem.
You can see that in action in the [PreviewGatheringService](https://github.com/layervault/pummeldoge/blob/master/app/services/preview_gathering_service.rb).

Once we have URLs to all of the previews we need, it's just a matter of pulling them down and mushing
them into GIFs and MOVs.