
[![Build Status](https://travis-ci.com/CoopTang/koroibos.svg?branch=master)](https://travis-ci.com/CoopTang/koroibos)
# Koroibos
A back-end api that exposes endpoints for data on the Olympics

## Tech/framework used
<b>Built with</b>
- [Rails 5.2.4.2](https://rubyonrails.org/)

## Installation
### Requirements
- [Ruby 2.4.1](https://github.com/ruby/ruby)
- [Rails 5.2.4](https://rubyonrails.org/)
- [PostgreSQL-11](https://www.postgresql.org/)

Once these are installed, clone the repository to your local machine 

Once cloned onto your computer, `cd` into the project directory and run `bundle install ` to install all required gems for the project.

**Database Setup**

Run the following command to set up the database

```
rails db:{drop,create,migrate}
rake load_olympians_from_csv
```

To start the server and view the site from the browser locally, start the server with `rails s` . By default, the server runs on http://localhost:3000

## API Reference

### Olympians
`GET /api/v1/olympians`

Returns all Olympians within the database:

**Successful Response**

Status Code 200
```json
{
  "olympians":
    [
      {
        "name": "Maha Abdalsalam",
        "team": "Egypt",
        "age": 18,
        "sport": "Diving",
        "total_medals_won": 0
      },
      {
        "name": "Ahmad Abughaush",
        "team": "Jordan",
        "age": 20,
        "sport": "Taekwondo",
        "total_medals_won": 1
      },
      {...}
    ]
}
```

**Successful Response: No Olympians**

Status Code 200
```json
{
  "olympians": []
}
```

---

### Youngest Olympian
`GET /api/v1/olympians?age=youngest`

Returns the information of the youngest olympian

**Successful Response**

Status Code 200
```json
{
  "olympians":
    [
      {
        "name": "Ana Iulia Dascl",
        "team": "Romania",
        "age": 13,
        "sport": "Swimming",
        "total_medals_won": 0
      }
    ]
}
```

**Unsuccessful Response: Age is not youngest or oldest**

Status Code 400
```json
{
  "message": "Age must be 'youngest' or 'oldest'!"
}
```

---

### Oldest Olympian
`GET /api/v1/olympians?age=oldest`

Returns the information of the oldest olympian

**Successful Response**

Status Code 200
```json
{
  "olympians":
    [
      {
        "name": "Julie Brougham",
        "team": "New Zealand",
        "age": 62,
        "sport": "Equestrianism",
        "total_medals_won": 0
      }
    ]
}
```

**Unsuccessful Response: Age is not youngest or oldest**

Status Code 400
```json
{
  "message": "Age must be 'youngest' or 'oldest'!"
}
```

---

### Olympian Stats
`GET /api/v1/olympian_stats`

Returns average stats on all Olympians in the database

**Successful Response**

Status Code 200
```json
  {
    "olympian_stats": {
      "total_competing_olympians": 3120,
      "average_weight:" {
        "unit": "kg",
        "male_olympians": 75.4,
        "female_olympians": 70.2
      },
      "average_age": 26.2
    }
  }
```

---

### Events
`GET /api/v1/events`

Returns all Olympic sports and their events

**Successful Response**

Status Code 200
```json
{
  "events":
    [
      {
        "sport": "Archery",
        "events": [
          "Archery Men's Individual",
          "Archery Men's Team",
          "Archery Women's Individual",
          "Archery Women's Team"
        ]
      },
      {
        "sport": "Badminton",
        "events": [
          "Badminton Men's Doubles",
          "Badminton Men's Singles",
          "Badminton Women's Doubles",
          "Badminton Women's Singles",
          "Badminton Mixed Doubles"
        ]
      },
      {...}
    ]
}
```

---

### Event Medalists
`GET /api/v1/events/:id/medalists`

Returns all medalists for an event in order of medal type

**Successful Response**

Status Code 200
```json
{
  "event": "Badminton Mixed Doubles",
  "medalists": [
      {
        "name": "Tontowi Ahmad",
        "team": "Indonesia-1",
        "age": 29,
        "medal": "Gold"
      },
      {
        "name": "Chan Peng Soon",
        "team": "Malaysia",
        "age": 28,
        "medal": "Silver"
      }
    ]
}
```

**Unsuccessful Response: Invalid Event ID**

Status Code 404
```json
{
  "message": "Event with that ID does not exist!"
}
```

---

## Tests
[RSpec](https://github.com/rspec/rspec-rails) is the testing framwork used for testing.

**To run all tests**

`bundle exec rspec`

This will run all tests in the `/spec` directory.


**To run an entire test file**

`bundle exec rspec spec/<path to specifc test>`

**To run a specific test in a file**

`bundle exec rspec spec/<path to specifc test>:<line number of the test>`

