# ProductImporter

### Setting up environment
Prequisites: Elixir 1.8.1

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Testing
#### Automated
- Set up the test database
```
MIX_ENV=test mix ecto.create
MIX_ENV=test mix ecto.migrate
```
- Run the tests: `espec`

#### Manual
Hit the following endpoint: `http://localhost:4000/api/products/import`
Params:
```
{ "data" => 
  {
    "branch_identifier": "TUC",
    "id": "353de6ec-6faf-4143-95a5-b2d7a3c19cee",
    "part_number": "0121F00548",
    "part_price": 314,
    "short_description": "GALV x FAB x 0121F00548 x 16093 x .026 x 29.88 x 17.56"
  }
}
```

Alternatively, if you use Postman, you can import the collection in this repo (`ProductImporter.postman_collection.json`) and try it yourself.