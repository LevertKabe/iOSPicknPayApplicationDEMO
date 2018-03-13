
#import "ViewController.h"
#import "WeatherCell.h"
#import "Service-Swift.h"
#import "WeatherApp-Swift.h"


@class swiftService;
@interface ViewController ()

@end


@implementation ViewController

    
- (void)viewDidLoad {
    [super viewDidLoad];
    tableView.estimatedRowHeight = 626;
    tableView.rowHeight = 626;
    tableView.delegate = self;
    tableView.dataSource = self;

    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = (id)self;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    
}

//- (void)viewDidAppear:(BOOL)animated{
//    [self performSegueWithIdentifier:@"homePage" sender:self];
//
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.estimatedRowHeight = 600;
    tableView.rowHeight = 600
    ;
    
    static NSString *simpleTableIdentifier = @"WeatherCellIdentifier";

    WeatherCell *cell = (WeatherCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    if (cell == nil)
    {
        NSArray *objectsArray = [[NSBundle mainBundle] loadNibNamed:@"WeatherCell" owner:self options:nil];

        for (id objectCell in objectsArray)
        {
            cell = (WeatherCell*)objectCell;
        }
      NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WeatherCell" owner:self options:nil];
       cell = [nib objectAtIndex:0];
    }

    //Getting date
    NSDate *now = [NSDate date];
    NSLog(@"count %ld",(long)indexPath.row);
    NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*indexPath.row];
    NSDate *newDate2 = [now dateByAddingTimeInterval:60*60*24*1];
    if((long)indexPath.row == 0)
    {
        cell.dateLbl.text = [NSString stringWithFormat:@"Today"];
    }
    else if((long)indexPath.row == 1)
    {
        cell.dateLbl.text = [NSString stringWithFormat:@"Tomorrow"];
    }
    else
    {
        cell.dateLbl.text = [NSString stringWithFormat:@"%@",newDate1];
    }

    cell.stateLbl.text = [cell.stateLbl.text stringByAppendingString:@""];
    cell.contiLbl.text = [cell.contiLbl.text stringByAppendingString:@""];

    cell.minLbl.text = [NSString stringWithFormat:@"Min: %@ °",[minTempArray objectAtIndex:indexPath.row]];
    cell.maxLbl.text = [NSString stringWithFormat:@"Max: %@ °",[maxTempArray objectAtIndex:indexPath.row]];
    cell.stateLbl.text = [cell.stateLbl.text stringByAppendingString:state];
    cell.contiLbl.text = [cell.contiLbl.text stringByAppendingString:conti];
    cell.summaryLbl.text = [NSString stringWithFormat:@"%@ °",[summaryArray objectAtIndex:indexPath.row]];
    cell.weatherImg.image = [UIImage imageNamed:[weatherImgArray objectAtIndex:indexPath.row]];
   
    return cell;
}


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//
//    CGRect rect = self.view.frame;
//    rect.origin.y =  -scrollView.contentOffset.y;
//    self.view.frame = rect;
//
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSUInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [maxTempArray count];

}

-(void)newWeatherRequestWithLocationCoords:(CLLocationCoordinate2D)coords {
    NSString *urlString = [NSString stringWithFormat:@"https://api.forecast.io/forecast/a858a93fd4a087842bdd8eaf04f476ad/%f,%f",coords.latitude,coords.longitude];

    NSError *error;

    NSURLResponse *response;

    maxTempArray = [[NSMutableArray alloc]init];
    minTempArray = [[NSMutableArray alloc]init];
    dayArray = [[NSMutableArray alloc]init];
    weatherImgArray = [[NSMutableArray alloc]init];
    summaryArray = [[NSMutableArray alloc]init];
    backgroundImgArray = [[NSMutableArray alloc]init];

    NSData*data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] returningResponse:&response error:&error];

    if (data) {

        NSData *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

        NSData *currentData = [jsonData valueForKey:@"currently"];
        NSString *timezone = [jsonData valueForKey:@"timezone"];
        NSLog(@"url %@",timezone);


        NSArray *items = [timezone componentsSeparatedByString:@"/"];

        NSString *str1=[items objectAtIndex:0];
        NSString *str2=[items objectAtIndex:1];

        state = str1;
        conti = str2;

        NSString * temperatureString = [currentData valueForKey:@"temperature"];
        float fahrenheit = temperatureString.floatValue;
        NSString* celsius = [self getCelsius:fahrenheit];

        NSData *dayData = [jsonData valueForKey:@"daily"];
        NSArray *dataArray = [dayData valueForKey:@"data"];

        NSDate *current = [NSDate date];
        NSInteger weekday = [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:current] weekday];


        for (int i = 0; i< dataArray.count; i++) {

            NSData *tmpData = [dataArray objectAtIndex:i];

            NSLog(@"tmpData =  %@",tmpData);

            NSString *minText = [tmpData valueForKey:@"temperatureMin"];
            NSString *maxText = [tmpData valueForKey:@"temperatureMax"];

            NSString* minValue = [self getCelsius:minText.floatValue];
            NSString* maxValue = [self getCelsius:maxText.floatValue];

            [minTempArray addObject:minValue];
            [maxTempArray addObject:maxValue];

            int day = (int)weekday+i;

            NSString *iconString = [tmpData valueForKey:@"icon"];

            swiftService *swiftSer = [[swiftService alloc]init];
            
            NSString *summary = [swiftSer getSummary:iconString ];
            NSString *weatherImage = [swiftSer getWeatherImage:iconString];
            //NBB!!!
            [weatherImgArray addObject:weatherImage];
            [summaryArray addObject:summary];

        }
        [tableView reloadData];
        NSLog(@"MaxArray = %@",maxTempArray);
    }
    else
    {

    }
}

-(NSString*)getCelsius:(float)fahrenheit {

    NSString *returnString = [NSString stringWithFormat:@"%.1f",(fahrenheit-32.0)*(5.0/9.0)];
    return returnString;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {

    CLLocation * currentLocation = [locations lastObject];

    if (currentLocation != nil) {

        CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
        [self newWeatherRequestWithLocationCoords:coords];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
