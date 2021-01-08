# Rucy & Arara's :parrot: ASE exam guide

## Practice

We have four folders.

All of them contain white_bread and the most important libraries we've used.

1. base phoenix project without user authentication
2. base phoenix project with user authentication
3. solution to the first practical exam
4. solution to the second practical exam

### Quick recap of setting up a phoenix project

#### How to quickly get started?

1. Copy base project
2. Search for all base_project occurences and swap them out with your desired project name
3. Search for all BaseProject occurences and swap them out with your DesiredProject name
4. Search for all BaseProjectWeb occurences and swap them out with your DesiredProjectWeb name
5. **Don't forget to also change the name of the lowercase folders! i.e if you copy base_project then change it from base_project to <new_name> and base_project_web to <new_name_web>**

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

``` sh
mix deps.get
```

#### white_bread

* Remember to have chromedriver on.
* **do not start chromedriver with sudo**
* Do everything in one file

### First Practice

#### Ecto stuff:

Schemas:

1. Product (name and quantity)
2. Rating (email and rating)

Number of votes and average rate will be calculated.

We can make the first two migrations as follows:

``` sh
mix phx.gen.schema Product products name:string quantity:integer;
mix phx.gen.schema Rating ratings email:string rating:float

```

Now we have to add `belongs_to(product)` to the `ratings` schema, add `has_many(ratings)` to `products` and `:product_id, references(:products)` alongside `create unique_index(:ratings, [:email, :product_id], name: :email_product_id)
` to the CreateRatings migration file.

The ecto part is the **trickiest** of them all, make sure that you have all validations correctly set there, on the changeset as well.

**Make sure to add product_id to the cast function in the rating changeset, and make it required as well**

The last step is to add the dummy seeds.

So all we have to do now is:

``` sh
mix ecto.reset;
MIX_ENV=test mix ecto.reset
```

in order to have our db fresh.

#### Next steps:

I think it's better to try to implement everything as fast as possible, and then worry about tests and else.

However, this might not be the best option, since it seems that TDD and BDD combined yield half of the grade, and take much less time than the whole implementation.

##### Implementation

1. Make a `RatingController`
2. Add the index action **Make sure to understand Ecto.Query**
3. Add a `RatingController` resource to the router
4. Make a folder `rating` on templates
5. Add rating_view under the View folder and fill it
6. Add index.html.eex
7. Add new.html.eex
8. Add the `new` and `create` actions to the `RatingController`
9. Add **all** the validation to the changeset. everything should, supposedly, be handled automatically.

##### TDD

TDD is quite straightforward, as pretty much all tests have very minor differences.

Make sure to do all validation on the changeset, otherwise it'll become a huge mess with insane nested `case`s.

##### BDD

I'd recommend writing the Gherkin story right after setting everything up. Free 4 points I guess.

It might sound stupid, but it seems that we will have two stories that do almost nothing.

1. I want to check ratings
2. I want to rate something

#### Summary

Implementation should take you 75% of the time, TDD 10% and then BDD 15%.

Watch out to not get caught up on implementation too much.


### Second Practice

#### Ecto stuff

Schemas:

1. Frame (roll_one, roll_two, roll_three, score, current, game_id)
2. Game (username)

Number of votes and average rate will be calculated.

We can make the first two migrations as follows:

``` sh
mix phx.gen.schema Game games username:string;
mix phx.gen.schema Frame frames roll_one:integer roll_two:integer roll_three:integer score:integer current:integer

```

**remember that you should put dependent migrations in a logical order**

**I.E Frames depends on Games, hence generate the Games migration before Frame's**

Now we have to add `belongs_to :game, SecondExam.Game` to the `frames` schema, add `has_many :frames, SecondExam.Frame` to `games`, `:game_id, references(:games)` to `frames`, with `create unique_index(:games, [:username], name: :games_username_index)` in the CreateGames migration file.

Also add **game_id** to the cast function in the frames schema.

#### Implementation

1. Make a `GameController`
2. Add the start, create and play actions with dummy `render conn, <action>.html`
3. Add a `GameController` resource to the router
4. Make a folder `game` on templates
5. Add game_view under the View folder and fill it
6. Add start.html.eex
7. Add play.html.eex
9. Add **all** the validation to the changeset. 

### Best path for the most points

Aim to get the following done in around **50 minutes**

**Do not start by going straight for the controller logic**

1. Gherkin - 4 free points // 5 minutes
2. Routes - 2 free points // 2 minutes
3. Models & Seeds - 5 not-so-free points (just the schema + migrations + random data) // 20 minutes
4. Controller Logic I + Views & Templates - 3 hard points (add "dummy" controllers that only render `route.html`)  // 20 minutes

For the following part:

5. TDD - 8 points // 30 minutes, aim to do MODEL tests. These are far easier to do; just make a changeset and confirm the error.
6. Controller Logic II - 10 points // 70 minutes+
7. white bread steps - 3 points // impossible to do this without the controller logic being 100% done, but quite easy nevertheless. should not take longer than 10 minutes.

## Theory
