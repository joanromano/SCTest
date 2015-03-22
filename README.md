# SCTest

## Prerequisites

* [Git](http://git-scm.com/)
* [Ruby](https://www.ruby-lang.org/) with [Bundler](http://bundler.io/)

## Installation

1. Clone the repo

2. Run `bundle install` to install dependencies

3. Run `rake spec` to run the tests

4. Run `rake create_users` to run the generate users task. This will generate `n` users with username `user_i`, where `1<=i<=n`

5. Run `rails server` and visit your app locally at [http://localhost:3000](http://localhost:3000).

## Endpoints

- Generate users:

`GET users?count=n` -> Where `n` is the number, between 20 and 500, of users to generate. This is a convenience backdoor controller of the `create_users` task and will do the same, giving no output.

- Artists

`GET artists?username="username"&page=n` -> Where `username` is the username to fetch and `n` the page number. Output:

````
{
"first_degree" => Array of first degree artists,
"second_degree" => Array of second degree artists
}
```

Each artist object will have the following format:

```
{
"display_name":"User 210",
"username":"user_210",
"icon_url":"https://robohash.org/user_210",
"upload_track_count":86
}
```

Note that each degree array will have at most 10 artists per page.

## Heroku

- The app is deployed on Heroku [http://scartists.herokuapp.com/](http://scartists.herokuapp.com/). Make sure you generate users before attempting to fetch artists.
