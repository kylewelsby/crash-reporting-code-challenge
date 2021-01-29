![Lint & Test](https://github.com/kylewelsby/crash-reporting-code-challenge/workflows/Lint%20&%20Test/badge.svg)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)

# Crash Notifier Code Challenge

Code Challenge completed by [Kyle Welsby](https://github.com/kylewelsby).

In this code challenge, I am tasked to produce a Application Crash notification processing API endpoint as setout in [CHALLENGE.md](./CHALLENGE.md)

Useful notes and todos througout the development can be found in [TODO](./blame/main/TODO)

## ⚡️ System Dependencies

This project expects Ruby 2.7.2, PostgreSQL, and Redis installed on your system. 

_At time of writing Ruby 3.0 has recently been released, but 2.7.2 is the current stable version_

## 🎲 Installation

Clone the project to your local system and run bundler in the project directory

```
git clone https://github.com/kylewelsby/crash-reporting-code-challenge.git
cd crash-reporting-code-challenge
bundle install
```

Setup the database 

```
bundle exec rails db:setup db:migrate
```

## 🎯 Usage

Start the application instance and workers using foreman

```
bundle exec foreman start
```

You can make requests such as:

#### Notify

Notify of a application crash

```
curl -X POST \
  'http://localhost:5000/notify' \
  -H 'access-control-allow-origin: *' \
  -H 'Content-Type: application/json; charset=utf-8' \
  -d '{
  "project_id": "1",
  "severity": "error",
  "message": "a error message"
}'
```

#### Stats

Show counters of crashes

```
curl http://localhost:5000/projects/1/stats
```

## 🤖 Testing

Run RSpec tests suite 

```
bundle exec rspec
```

## 🚨 Linting

This project uses [`standardrb`](https://github.com/testdouble/standard).

```
bundle exec standardrb .
```

🎓 License

MIT: https://kylewelsby.mit-license.org