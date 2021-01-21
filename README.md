# Sweater Weather

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]

  <h3 align="center">Sweater Weather</h3>

  <p align="center">
    Sweater Weather was built to be used as a backend application that the frontend will then communicate with in order to get the necessary information.  The overall application is for planning road trips, and will allow users to see the current weather as well as the forecasted weather at the destination.  The frontend communicates with this backend piece through an API, which the backend then exposes the infomation coming from the APIs in the proper format that satisfies the frontend team's requirments.
    <br />
    <!-- for adding a demo video
    <a href="Add our video link here">View Demo</a>  · -->
    ·
    <a href="https://github.com/s-steel/sweater_weather/issues">Report Bug</a>
    ·
    <a href="https://github.com/s-steel/sweater_weather/issues">Request Feature</a>
  </p>
</p>




<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Endpoints](#endpoints)
  * [Forecast](#forecast)
  * [Background](#background)
  * [User Registration](#user-registration)
  * [User Login](#user-login)
  * [Road Trip](#road-trip)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Configuration](#configuration)
  * [Testing](#testing)
* [Contributing](#contributing)
* [Contact](#contact)
* [Acknowledgements](#acknowledgements)




<!-- ABOUT THE PROJECT -->
## About The Project

Three APIs were used in this project in order to obtain the required information.  All weather data is coming from the [Open Weather](https://openweathermap.org/api/one-call-api) one call API.  The [MapQuest](https://developer.mapquest.com/documentation/geocoding-api/) API was used in order to obtain latitude and longitude coordinates for a city that were then used to query the Open Weather API.  Finally the [Upsplash](https://unsplash.com/developers) API was used in order to provide the frontend with a backgroud image of a specified city.


### Built With

* [Ruby](https://github.com/ruby/ruby)


## Endpoints

### Forecast

#### Request the forecast for a given city: `GET /api/v1/forecast`
example: `http://localhost:3000/api/v1/forecast?location=denver,co`
```
{
  "data": {
      "id": null,
      "type": "forecast",
      "attributes": {
          "current_weather": {
              "datetime": "2021-01-20T07:46:12.000-07:00",
              "sunrise": "2021-01-20T07:16:35.000-07:00",
              "sunset": "2021-01-20T17:05:12.000-07:00",
              "temperature": 30.660000000000025,
              "feels_like": 25.400000000000034,
              "humidity": 49,
              "uvi": 0.19,
              "visibility": 10000,
              "conditions": "clear sky",
              "icon": "01d"
            },
          "daily_weather": [
              {
                "date": "2021-01-20",
                "sunrise": "2021-01-20T14:16:35.000+00:00",
                "sunset": "2021-01-21T00:05:12.000+00:00",
                "max_temp": 42.379999999999995,
                "min_temp": 30.660000000000025,
                "conditions": "clear sky",
                "icon": "01d"
              },
              {...} etc
            ],
          "hourly_weather": [
              {
                "time": "07:01",
                "temperature": 30.660000000000025,
                "wind_speed": "6.89 mph",
                "wind_direction": "from SSW",
                "conditions": "clear sky",
                "icon": "01n"
              },
              {...} etc
            ]
        }
    }
}
```
  
### Background

#### Request a background image for a given city: `GET /api/v1/backgrounds`
example: `http://localhost:3000/api/v1/backgrounds?location=denver,co`
```

{
  "data": {
    "id": null,
    "type": "image",
  "attributes": {
      "image": {
          "location": "denver,co",
          "image_url": "https://images.unsplash.com/photo-1600041161228-519e6dd27bac?crop=entropy&cs=srgb&fm=jpg&ixid=MXwxOTkzMjd8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MHx8fA&ixlib=rb-1.2.1&q=85",
          "raw_image_url": "https://images.unsplash.com/photo-1600041161228-519e6dd27bac?ixid=MXwxOTkzMjd8MHwxfHNlYXJjaHwxfHxkZW52ZXIsY298ZW58MHx8fA&ixlib=rb-1.2.1",
        "credit": {
            "source": "https://unsplash.com",
            "author": "Michael Kilcoyne",
            "author_profile": "https://unsplash.com/@mikekilcoyne"
        }
      }
    }
  }
}
```    
    
### User Registration

#### Register a user and return a unique API key: `POST /api/v1/users`
example: `http://localhost:3000/api/v1/users`<br>
         ```body: {
                "email": "whatever@example.com",
                "password": "password",
                "password_confirmation": "password"
              }```

```
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

### User Login

#### Login a user and return their API key: `POST /api/v1/sessions`
example: `http://localhost:3000/api/v1/sessions`<br>
         ```body: {
                "email": "whatever@example.com",
                "password": "password"
              }```

```
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```
  
### Road Trip

#### Request information for a road trip: `POST /api/v1/road_trip`
example: `http://localhost:3000/api/v1/road_trip`<br>
         ```body: {
                  "origin": "Denver,CO",
                  "destination": "Pueblo,CO",
                  "api_key": "jgn983hy48thw9begh98h4539h4"
                }```

```
{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "Denver, CO",
      "end_city": "Pueblo, CO",
      "travel_time": "01 hours, 44 minutes",
      "weather_at_eta": {
          "temperature": 27.100000000000023,
          "conditions": "clear sky"
      }
    }
  }
}
```

<!-- GETTING STARTED -->
## Getting Started

To use this locally, you can fork or clone [this](git@github.com:s-steel/sweater_weather.git) repo.


### Configuration

1. ```git clone git@github.com:s-steel/sweater_weather.git```
2. ```cd sweater_weather```
3. ```bundle install```
4. ```rake db:{create,migrate,seed}```
5. ```rails s```

From here you can make api calls to your local server. I recommend using [Postman](https://www.postman.com/) in order to make these call and see the results.


### Testing

Sweater Weather has been fully tested. To view the test coverage;

Once inside your terminal within the Sweater Weather directory run the following command.
```
open coverage
```

This will open up a folder with an index.html file. Clicking on this file will show you a list of all lines of code within this project, and whether they have been tested or not.

Additionally, running ```bundle exec rspec``` will show you the quick summary of the test coverage in this application.

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/s-steel/sweater_weather/issues) for a list of proposed features, known issues, and project extensions.


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make this community such an amazing and fun place to learn, grow, and create! Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch ```git checkout -b feature/NewGreatFeature```
3. Commit your Changes ```git commit -m 'Add some NewGreatFeature'```
4. Push to the Branch ```git push origin feature/NewGreatFeature```
5. Open a new Pull Request!


<!-- CONTACT -->
## Contact

Sean Steel &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/sean-steel/) - [GitHub](https://github.com/s-steel)



Project Link: [Sweater Weather](https://github.com/s-steel/sweater_weather)



<!-- ACKNOWLEDGEMENTS -->
<!-- Add resources that were used to help create this project here -->




<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/Jonathan-M-Wilson/rails-engine
[contributors-url]: https://github.com/Jonathan-M-Wilson/rails-engine/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Jonathan-M-Wilson/rails-engine
[forks-url]: https://github.com/Jonathan-M-Wilson/rails-engine/network/members
[stars-shield]: https://img.shields.io/github/stars/Jonathan-M-Wilson/rails-engine
[stars-url]: https://github.com/Jonathan-M-Wilson/rails-engine/stargazers
[issues-shield]: https://img.shields.io/github/issues/Jonathan-M-Wilson/rails-engine
[issues-url]: https://github.com/Jonathan-M-Wilson/rails-engine/issues
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
