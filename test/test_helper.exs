ExUnit.start

Mix.Task.run "ecto.create", ~w(-r GetAtMe.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r GetAtMe.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(GetAtMe.Repo)

