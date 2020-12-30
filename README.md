# Planet-Earth

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
2. **Earthquakes**
    * [Volcano Discovery](https://www.volcanodiscovery.com/earthquakes/today.html)
    
    For Earthquakes the website above is parsed using [SwiftSoup](https://github.com/scinfu/SwiftSoup)
