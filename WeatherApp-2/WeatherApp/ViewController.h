
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WeatherCell.h"


@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>{
    //@property (assign, nonatomic)IBOutlet WeatherCell *weatherCell;
    
    NSMutableArray *maxTempArray;
    NSMutableArray *minTempArray;
    NSMutableArray *dayArray;
    NSMutableArray *weatherImgArray;
    NSMutableArray *summaryArray;
    NSMutableArray *backgroundImgArray;
    NSString *state ;
    NSString *conti;
    
    IBOutlet WeatherCell *weatherCell;
    
    
    
    IBOutlet UITableView *tableView;
    
    CLLocationManager *locationManager;
}

@end


