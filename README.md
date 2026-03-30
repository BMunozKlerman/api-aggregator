# API Aggregator

## Prerequisites
* Ruby version: 3.4.8
* Rails version: 7.2.2.2
* Postgres version: 16 or higher

## Getting Started

### 1. Clone the repository
```bash
git clone git@github.com:BMunozKlerman/api-aggregator.git
cd api-aggregator
```
### Install dependencies
```bash
bundle install
```
### Set up the database
```bash
bin/rails db:prepare
```
### Enviroments variables
Create a `.env` file in the root of the project and add the following variables:
```bash
DUMMY_API="https://dummyjson.com"
```
### Run the server
```bash
bin/rails server
```
The API will be reachable at http://localhost:3000.

## Runing Tests
We use RSpec for our test suite, covering Models, Services, and Request specs.
To run the tests, execute the following commands:
```bash
# Prepare the test database
RAILS_ENV=test bin/rails db:test:prepare

# Run all tests
bundle exec rspec
```

### API Endpoints

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| GET | `/user_status/:id` |Returns aggregated data (Full Name, Experience, Pending Tasks Count, Next Urgent Task).|