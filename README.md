# Supercast. This is a Work in Progress with many obvious improvement.

## Introduction

A personalized podcast recommendation engine that suggests podcasts based on user preferences, listening history, and popular genres.

## Requirements

- Ruby version 3.2.2

- Rails version 7.0.8

- Postgres

- Listen Notes API

## Installation

- Visit Listen Notes to generate api key

- Set the key in a .env file in the application root
    ```
    LISTEN_NOTES_API_KEY='key'
    ```

- Clone the repository and get inside it:

```
git clone git@github.com:JamesOkunlade/supercast.git

cd supercast
```

- Install all gems:

```
bundle install
```

- Create a postgres database:

```
rails db:create
```

- Migrate database and run the rake for updating genres and podcasts in that order.

```
rails db:migrate

rails genres:update
rails podcast_recommendations:generate
```

- Start the server

```
rails s
```

## Author

James Okunlade

- [Github profile](https://github.com/JamesOkunlade)