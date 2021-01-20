# require 'rails_helper'

# describe 'Location poro' do
#   before :each do
#     @response_data = {:current_weather=>
#       #<WeatherCurrent:0x00007fba0975abc8
#        @conditions="clear sky",
#        @datetime=2021-01-19 21:03:52 -0700,
#        @feels_like=33.18000000000001,
#        @humidity=93,
#        @icon="01n",
#        @sunrise=2021-01-19 08:48:30 -0700,
#        @sunset=2021-01-19 18:03:32 -0700,
#        @temperature=35.85000000000002,
#        @uvi=0,
#        @visibility=10000>,
#      :daily_weather=>
#       [#<WeatherDaily:0x00007fba09758d78
#         @conditions="scattered clouds",
#         @date="2021-01-19",
#         @icon="03d",
#         @max_temp=44.28000000000003,
#         @min_temp=35.85000000000002,
#         @sunrise=Tue, 19 Jan 2021 15:48:30 +0000,
#         @sunset=Wed, 20 Jan 2021 01:03:32 +0000>,
#        #<WeatherDaily:0x00007fba097585a8
#         @conditions="overcast clouds",
#         @date="2021-01-20",
#         @icon="04d",
#         @max_temp=43.09000000000003,
#         @min_temp=37.370000000000005,
#         @sunrise=Wed, 20 Jan 2021 15:47:44 +0000,
#         @sunset=Thu, 21 Jan 2021 01:04:54 +0000>,
#        #<WeatherDaily:0x00007fba09758300
#         @conditions="light rain",
#         @date="2021-01-21",
#         @icon="10d",
#         @max_temp=39.710000000000036,
#         @min_temp=39.19,
#         @sunrise=Thu, 21 Jan 2021 15:46:56 +0000,
#         @sunset=Fri, 22 Jan 2021 01:06:16 +0000>,
#        #<WeatherDaily:0x00007fba09758058
#         @conditions="light rain",
#         @date="2021-01-22",
#         @icon="10d",
#         @max_temp=40.68000000000001,
#         @min_temp=36.31,
#         @sunrise=Fri, 22 Jan 2021 15:46:06 +0000,
#         @sunset=Sat, 23 Jan 2021 01:07:40 +0000>,
#        #<WeatherDaily:0x00007fba09353d18
#         @conditions="broken clouds",
#         @date="2021-01-23",
#         @icon="04d",
#         @max_temp=38.82000000000005,
#         @min_temp=33.58000000000004,
#         @sunrise=Sat, 23 Jan 2021 15:45:14 +0000,
#         @sunset=Sun, 24 Jan 2021 01:09:04 +0000>],
#      :hourly_weather=>
#       [#<WeatherHourly:0x00007fba097623f0 @conditions="clear sky", @icon="01n", @temperature=35.85000000000002, @time="21:01", @wind_direction="from E", @wind_speed="3.62 mph">,
#        #<WeatherHourly:0x00007fba09762260 @conditions="scattered clouds", @icon="03n", @temperature=36.93000000000001, @time="22:01", @wind_direction="from E", @wind_speed="3.58 mph">,
#        #<WeatherHourly:0x00007fba097620d0 @conditions="broken clouds", @icon="04n", @temperature=37.54000000000002, @time="23:01", @wind_direction="from ESE", @wind_speed="3.65 mph">,
#        #<WeatherHourly:0x00007fba09761f40 @conditions="overcast clouds", @icon="04n", @temperature=37.76000000000005, @time="00:01", @wind_direction="from E", @wind_speed="3.47 mph">,
#        #<WeatherHourly:0x00007fba09761db0 @conditions="overcast clouds", @icon="04n", @temperature=37.670000000000016, @time="01:01", @wind_direction="from E", @wind_speed="2.93 mph">,
#        #<WeatherHourly:0x00007fba09761c20 @conditions="overcast clouds", @icon="04n", @temperature=37.59000000000003, @time="02:01", @wind_direction="from E", @wind_speed="2.95 mph">,
#        #<WeatherHourly:0x00007fba09761a90 @conditions="overcast clouds", @icon="04n", @temperature=37.670000000000016, @time="03:01", @wind_direction="from E", @wind_speed="2.89 mph">,
#        #<WeatherHourly:0x00007fba09761900 @conditions="overcast clouds", @icon="04n", @temperature=37.52000000000004, @time="04:01", @wind_direction="from E", @wind_speed="2.89 mph">]}
#   end

#   it 'creates location objects' do
#     location_poro = Location.new(@response_data)
#     expect(location_poro.latitude).to eq(@response_data[:results][0][:locations][0][:latLng][:lat])
#     expect(location_poro.longitude).to eq(@response_data[:results][0][:locations][0][:latLng][:lng])
#   end
# end
