alias FirstExam.Repo
alias FirstExam.Product
alias FirstExam.Rating

laptops = %Product{}
|> Product.changeset(%{name: "laptops",
                      quantity: 25})
|> Repo.insert!()

pants = %Product{}
|> Product.changeset(%{name: "pants",
                      quantity: 15})
|> Repo.insert!()

panties = %Product{}
|> Product.changeset(%{name: "panties",
                      quantity: 12})
|> Repo.insert!()

headphones = %Product{}
|> Product.changeset(%{name: "headphones",
                      quantity: 20})
|> Repo.insert!()

haskell = %Product{}
|> Product.changeset(%{name: "haskell",
                      quantity: 1})
|> Repo.insert!()


[
  %{email: "jekat98@ut.ee", rating: 3, product_id: laptops.id},
  %{email: "takej98@ut.ee", rating: 1, product_id: laptops.id},
  %{email: "bruno98@ut.ee", rating: 5, product_id: pants.id},
  %{email: "onurb98@ut.ee", rating: 2, product_id: pants.id},
  %{email: "rucy98@ut.ee", rating: 4, product_id: panties.id},
  %{email: "relmeyer98@ut.ee", rating: 1, product_id: panties.id},
  %{email: "ichise@ut.ee", rating: 5, product_id: headphones.id},
  %{email: "capirola@ut.ee", rating: 2, product_id: headphones.id},
  %{email: "dalza98@ut.ee", rating: 5, product_id: panties.id},
  %{email: "bonssinensis98@ut.ee", rating: 3, product_id: pants.id}
]
|> Enum.map(fn rating_data -> Rating.changeset(%Rating{}, rating_data) end)
|> Enum.each(fn rating_changeset -> Repo.insert!(rating_changeset) end)
