import Foundation

@objc public class SwiftService : NSObject {
    @objc var weatherSummaries = ["Clear Day", "Clear Day/Night","Rain", "Snow fall", "Sleet", "Light amount of wind", "Fog appears", "Cloudy with high chances of rain", "Most parts partly Cloudy during the day" ];
    
    @objc func getSummary(summary : String) -> String {
        var finalSummary = "";
        if (summary == "clear-day") {
            finalSummary = "Clear Day"
           
        }
        else if (summary == "clear-night") {
            finalSummary = "Clear Day/Night"
           
        }
        else if (summary == "rain") {
            finalSummary = "Rain"
           
        }
        else if (summary == "snow") {
            finalSummary = "Snow fall"
          
        }
        else if (summary == "sleet") {
            finalSummary = "Sleet"
          
        }
        else if (summary == "wind") {
            finalSummary = "Light amount of wind"
          
        }
        else if (summary == "fog") {
            finalSummary = "Fog appears"
          
        }
        else if (summary == "cloudy") {
            finalSummary = "Cloudy with high chances of rain"
        }
        else if (summary == "partly-cloudy-day") {
            finalSummary = "Most parts partly Cloudy at night"
            
        }
        else if (summary == "partly-cloudy-night") {
            finalSummary = "Most parts partly Cloudy at night"
        }
        else
        {
            finalSummary = "Partly cloudy"
        }
        return finalSummary
    }
    
    @objc func getWeatherImage(summary : String) -> String {
        var weatherImage = "";
        if (summary == "clear-day") {
            weatherImage = "sunny.png"
            
        }
        else if (summary == "clear-night") {
            weatherImage = "sunny.png"
            
        }
        else if (summary == "rain") {
            weatherImage = "rain_light.png"
            
        }
        else if (summary == "snow") {
            weatherImage = "Snow.png"
            
        }
        else if (summary == "sleet") {
            weatherImage = "Snow.png"
            
        }
        else if (summary == "wind") {
            weatherImage = "Weather_Icons_09_fog-512.png"
            
        }
        else if (summary == "fog") {
            weatherImage = "simple_weather_icons_cloudy.png"
            
        }
        else if (summary == "cloudy") {
            weatherImage = "partly_cloudy.png"
        }
        else if (summary == "partly-cloudy-day") {
            weatherImage = "partly_cloudy.png"
            
        }
        else if (summary == "partly-cloudy-night") {
            weatherImage = "partly_cloudy.png"
        }
        else
        {
            weatherImage = "partly_cloudy.png"
        }
        return weatherImage
        
    }

}
