# README

App-specific environment variables:

```ruby
# app/application.yml

GITHUB_CLIENT_ID: "client_id"
GITHUB_CLIENT_SECRET: "client_secret_key"
```

## To put in a gist eventually

# Zero to... not zero

I have _really_ been struggling to wrap my head around Omniauth and using it to authenticate for API calls.

This is one pretty much the first time I've had this much trouble with something at Turing, so I'm (sorta) enjoying the process of wrapping my head around something so foreign that I don't even know where to begin.

For some context, we've worked through a few hand-holdy lessons, like:

- [Rolling your own authentication using OAuth](http://backend.turing.io/module3/lessons/getting_started_with_oauth)
- [Implementing Oauth/OmniAuth with Twitter](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/archive/getting_started_with_oauth.md#user-content-workshop----implementing-oauth-with-twitter)
- [Using Figaro to protect sensitive environment variables](http://backend.turing.io/module3/lessons/using_figaro)

Now, our project (called [APIcurious](http://backend.turing.io/module3/projects/apicurious)) is to more-or-less clone the functionality of either GitHub or Reddit, using OmniAuth to authenticate a user against Github, and then consume the returned data to show that user their repositories, followed/following people, etc.

It's sort of a big piece to bite off and get moving on, and since writing helps me think better anyway, I'm throwing my process here as we go.

This is currently written in my [GitHub repo's README](https://github.com/josh-works/api_curious), but I might pull it into a gist later.

## The process by which josh tries to understand something that is difficult

I accidentally shot myself in the foot on this project. I use a tool called [SelfControl](https://selfcontrolapp.com/) to block distracting sites, like Twitter, Reddit, HackerNews, etc. I started it for a 24 hour block JUST as I realized that our OmniAuth lesson was all about authenticating via the `omniauth-twitter` gem. Eff. I couldn't work through the lesson with good understanding until 24 hrs after it was assigned.

So, once that 24 hour period expired, I worked through the [OmniAuth via Twitter](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/archive/getting_started_with_oauth.md#user-content-workshop----implementing-oauth-with-twitter) lesson, very carefully. I wrote MOST of what I was doing down in my notebook, and made sure I understood every line of code that came of that lesson.

That process wrapped up last night.

So, lets try to port over the Twitter Omniauth functionality to Github, in this current repo!
