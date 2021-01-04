# Rucy & Arara's :parrot: ASE exam guide

## Practice

We have four folders.

All of them contain white_bread and the most important libraries we've used.

1. base phoenix project without user authentication
2. base phoenix project with user authentication
3. solution to the first practical exam
4. solution to the second practical exam

In order to run any of these projects you have to do the following, in ubuntu, I have no idea how to go about it in windows ~~neither do I want to know how :D~~

* Make sure that you have psql set up. you don't wanna waste any time troubleshooting postgres, believe me, you really don't.

### Quick recap of setting up a phoenix project

**Try not to run the commands with sudo, if possible.**

#### How to create a phoenix project?(if you need it)

``` sh
mix phx.new <name> --module <NameCapitalized> --database postgres --no-dashboard
```

#### What to do if it tells you that the command phx_new does not exist?

``` sh
mix archite.install hex phx_new 1.5.5
```

#### How to run the projects

``` sh
cd <project> && mix deps.get && mix deps.compile;
cd assets && npm install
cd ..
mix ecto.reset
MIX_ENV=test mix ecto.reset
mix phx.server

```

#### What to do after making a new migration or changing the schema?

``` sh
mix ecto.reset
MIX_ENV=test mix ecto.reset
```

#### What to do if you wanna add something to mix.exs?

#### white_bread

* Remember to have chromedriver on.
* **do not start chromedriver with sudo**
* Do everything in one file

## Theory
