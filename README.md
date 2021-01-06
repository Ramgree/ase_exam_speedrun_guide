# Rucy & Arara's :parrot: ASE exam guide

## Practice

We have four folders.

All of them contain white_bread and the most important libraries we've used.

1. base phoenix project without user authentication
2. base phoenix project with user authentication
3. solution to the first practical exam
4. solution to the second practical exam

In order to run any of these projects you have to do the following, in **GNU+Linux**.

* Make sure that you have psql set up. you don't wanna waste any time troubleshooting postgres, believe me, you really don't.

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

#### What's left to do:

1. Make a `RatingController`
2. Add the index action **Make sure to understand Ecto.Query**
3. Add a `RatingController` resource to the router
4. Make a folder `rating` on templates
5. Add rating_view under the View folder and fill it
6. Add index.html.eex
7. Add new.html.eex
8. Add the `new` and `create` actions to the `RatingController`

## Theory
