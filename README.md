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

I'm gonna go without testing first, since it's hard to test that which you don't know.

Oh, last point - I'm _way_ behind on technical expectations. That's frustrating to me, but I'm hoping the slow work I did at the beginning will pay off soon...

## Iteration 0: Talking to Github

OK, so I want to authenticate against Github. Referencing the twitter lesson, I'm going to try to duplicate that functionality, but using GitHub.

In that lesson, I did:

1. Add omniauth gem
2. Configure Omniauth env. variables
3. add GET route for twitter/github authentication endpoint
4. put link to "login" on home page
5. On click, Github will make a GET request on a given callback url. I need to handle that in `sessions#create`.
6. Inside of `sessions#create`, I need to make a new user.
7. To make a new user, I need to have a DB model to handle it, so make a migration to modify that table in DB.
8. write a method in user model, something like `def self.from_omniauth(auth_info)` that uses `first_or_create_by` to find/update DB records.
9. From session controller, call that method to see if user is authenticated.
???
10. User should be able to log out, too
10. Profit. At this point, I'm cooking with gas.

So, lets do all this...

(Just for fun, I went through the end of the Twitter authentication lesson _a third time_. I don't pretend to understand something until at least my 2nd or 3rd exposure to it, so... maybe I'm starting to get it.)

Here's the test file I'm first working with:

```ruby
RSpec.feature "user can authenticate application" do
  scenario "from home page" do
    it "sees login button" do
      visit root_path
      expect(page).to have_link "Sign in with Github"
    end
  end

  scenario "and after logging in" do
    it "sees user's name" do
      visit root_path
      click_on("Login with Github")

      expect(path).to be("/")
    end
  end
end
```
.

.

.

time passing...

OK, I spent an embarrasing amount of time getting two errors.

My RSpec tests were failing with:

> ActionController::RoutingError:
       uninitialized constant AuthController

and when running on localhost, when I clicked on "login w/github", trying to authenticate, the response was throwing

> OmniAuth::Strategies::OAuth2::CallbackError
>  csrf_detected | CSRF detected

Turns out that's just specific to the OmniAuth gem, it didn't like how I had my routes configured. Messing around with them, here's my current routes, which is allowing the authenticate action to hit my `sessions#new` controller:

```ruby
# routes.rb
root 'home#show'
get '/auth/github', as: :github_login
get '/auth/github/callback', to: 'sessions#create'
```

Geesh. That took too long.

Anyway, now `request.env["omniauth.auth"]` gives me a sweet hash with all sorts of goodies.


```ruby
# from inside sessions#create
request.env["omniauth.auth"].keys
=> ["provider", "uid", "info", "credentials", "extra"]
```

And those keys right there hold everything we need to create a new user, or find an existing user.

To create or find a user, we need to call a class-level method on our user model.

```ruby
# user.rb
```
(if you're keeping track, I'm on step six of the list from above)

lets try `rails g migration CreateUser user_name name user_id oauth_token oauth_token_secret image`


OK! Up and running. Made the migration, added the appropriate user methods and such:

```ruby
# /user.rb

class User < ApplicationRecord

  def self.from_omniauth(auth_info)
    where(user_id: auth_info.uid).first_or_create do |new_user|
      new_user.user_id = auth_info.uid
      new_user.name = auth_info.info.name
      new_user.user_name = auth_info.info.nickname
      new_user.image = auth_info.extra.raw_info.avatar_url
      new_user.oauth_token = auth_info.credentials.token
    end
  end
end
```
And some flash messages to notify our users that they've logged in/logged out.

It's still styled like crap, but we'll get there eventually.

I'm gonna say this finishes Iteration 0

## Iteration 1

Now that our users can log in, I think I'd like to be able to redirect them to a "dashboard" page.

In this dashboard, the FIRST version should just render the raw JSON object of this user.

I'm thinking of a progression like this:

1. `/dashboard` should show raw JSON of the current user
2. `/dashboard` should have the user's picture on it
2. `/dashboard` should include the objects of all the user's repos (this will require a second API call, I believe)
3. `/dashboard` should show formatted text of the repos, and include links to them all

and more?



### Reference material thus far

- a identical project that has a nice end-state: [api_curious github repo](https://github.com/Dpalazzari/api_curious)
- above project can be accessed [here](https://api-curious-github-dp.herokuapp.com/) if you want.
