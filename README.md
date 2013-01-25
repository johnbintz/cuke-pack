# cuke-pack

Common Cucumber setups to make things go fast and smooth.

## Install it

``` ruby
# Gemfile

gem 'cuke-pack'
```

``` bash
bundle exec cuke-pack install
```

This will overwrite your `config/cucumber.yml` file with one that plugs in nicely with Guard. It also adds a new config file in
`features/support/cuke-pack.rb`.

## Specifying the driver

If you have other Capybara drivers installed like Poltergeist of persistent_selenium, you can specify the driver as an
environment variable:

``` bash
DRIVER=poltergeist bundle exec cucumber
```

## Confirming JavaScript

If you need to confirm an `alert()` or `confirm()`, you can do so in your step with `confirm_js`. Just replaces
`window.alert` and `window.confirm` with functions that return true.

## Step Writer

Enables [cucumber-step_writer](http://github.com/johnbintz/cucumber-step_writer) for you.

## Flay your steps

I can get duplicate code in my steps pretty quickly. Sometimes I flay them to see where the duplicates are and then I
factor out the common code.

## Hijacking `@wip`

I personally think the original use of `@wip` in Cucumber is silly. Why would you commit non-working
features to the source repository? So this project re-purposes `@wip` to let you focus your Cucumber test
runs on a single feature and work on it until it runs:

### Guard

If you're using Guard for continuous testing, install the `wip` guard:

``` bash
bundle exec cuke-pack wip-guard
```

You can then use Guard to only run scenarios with the tag `@wip`:

``` bash
bundle exec guard -g wip
```

### Precommit

If you run tests before committing your code with a tool like [penchant](http://github.com/johnbintz/penchant),
you can configure your tests to run using the `precommit` profile. This one ensures that there are no
`@wip` scenarios. It also lets you skip certain features/scenarios that are tagged `@no-precommit`. Good for
turning off tests that you haven't needed to touch in a while. Just be careful with it!

## Other things

You can easily enable FakeFS, Mocha, and Timecop if you need them. Turn them on in `cuke-pack.rb` and then use
the right tag on your scenario.

## Old things

There's some stuff that is so deprecated that I'll remove it eventually, once all my other offending projects
don't use them anymore. You shouldn't use them either.

