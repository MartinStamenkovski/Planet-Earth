# Planet Earth

iOS Application showing data for our planet, currently it's showing data for:

- [x] Weather
- [x] Air Quality
- [ ] Air Quality Rankings
- [x] Earthquakes
- [ ] Wildfires
- [ ] Tsunami
- [ ] Volcano
- [ ] Water information?
- [ ] Litter and Plastic pollution?

## About
The main purpose of this application is to explore and see how far we can go with SwiftUI and Combine.

This application will not be available on the App Store, at least in foreseeable future. 
With that said you will need to clone this repository and install the application through XCode.

## API's

1. **OpenWeather**
    * Weather Information
    * Air Quality
    
    You will need to register your own API Key to use this service, read [here](https://openweathermap.org/appid) how to get your API Key.
    
    **After you obtain OpenWeather API key, you need to set it in [Info.plist](https://github.com/MartinStamenkovski/Planet-Earth/blob/main/OpenWeatherAPI/Info.plist)
    in OpenWeatherAPI module.**
    
2. **Earthquakes**
    * [Volcano Discovery](https://www.volcanodiscovery.com/earthquakes/today.html)
    
    For Earthquakes the website above is parsed using [SwiftSoup](https://github.com/scinfu/SwiftSoup)
    
## Preview

 <p float="left">
   <img src="https://github.com/MartinStamenkovski/Planet-Earth/blob/screenshots/weather_1.png?raw=true" width="200" height="400"/>
   <img src="https://github.com/MartinStamenkovski/Planet-Earth/blob/screenshots/weather_2.png?raw=true" width="200" height="400"/>
   <img src="https://github.com/MartinStamenkovski/Planet-Earth/blob/screenshots/aqi.png?raw=true" width="200" height="400"/>
   <img src="https://github.com/MartinStamenkovski/Planet-Earth/blob/screenshots/earthquakes.png?raw=true" width="200" height="400"/>
   <img src="https://github.com/MartinStamenkovski/Planet-Earth/blob/screenshots/earthquake_map.png?raw=true" width="200" height="400"/>
 </p>
 
## App Icon
Made by [Freepik](https://www.flaticon.com/authors/freepik) from [Flaticon](https://www.flaticon.com/)
