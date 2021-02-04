alias Exam.{Repo, User, Product}

%User{}
|> User.changeset(%{email: "stress98@ut.ee",
                    pin: 666666,
                    balance: 600})
|> Repo.insert!()

%Product{}
|> Product.changeset(%{name: "headphones",
                       unit: 1.0,
                       quantity: 1})
|> Repo.insert!()

%Product{}
|> Product.changeset(%{name: "headset",
  unit: 3.0,
  quantity: 3})
|> Repo.insert!()

%Product{}
|> Product.changeset(%{name: "pants",
  unit: 1.0,
  quantity: 1})
|> Repo.insert!()