
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "WeatherApp-Swift.h"

@class SwiftService;

@interface swiftService : NSObject
    +(NSString *)getSummary:(NSString *) summary;
@end

@implementation swiftService : NSObject
    -(NSString *)getSummary:(NSString *) summary
    {
        NSString *finalSummary = @"";
        SwiftService *swi = [SwiftService new];
        finalSummary = [swi getSummaryWithSummary:(summary)];
        return finalSummary;
    }

-(NSString *)getWeatherImage:(NSString *) summary
{
    NSString *weatherImage = @"";
    SwiftService *swi = [SwiftService new];
    weatherImage = [swi getWeatherImageWithSummary:(summary)];
    return weatherImage;
}

@end

