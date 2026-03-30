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
API_KEY="your_api_key_here"
```
You can generate your api key or use just "your_api_key_here" for local testing.
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

| Method | Endpoint | Description | Auth Requied |
| :--- | :--- | :--- | :--- |
| GET | `/user_status/:id` |Returns aggregated data (Full Name, Experience, Pending Tasks Count, Next Urgent Task).| `X-Api-Key` (Header) | 

## Test EP on Postman

### Create new request
1. Create a new HTTP Method to ```GET```
2. Set the URL to ```http://localhost:3000/user_status/:user_id```, choose the user_id that you want
### Confugure Auth
1. Go to Headers tab, under the URL
2. Add the new column ```X-Api-Key```
3. In the value past the API_key you setted on the ```.env``` file

You are ready to test the endpoint, just click send!
