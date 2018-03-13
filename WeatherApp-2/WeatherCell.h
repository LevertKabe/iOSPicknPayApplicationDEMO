#import <UIKit/UIKit.h>

@interface WeatherCell : UITableViewCell

    @property(nonatomic,weak)IBOutlet UILabel *minLbl;
    @property(nonatomic,weak)IBOutlet UILabel *maxLbl;
    @property(nonatomic,weak)IBOutlet UIImageView * weatherImg;
    @property(nonatomic,weak)IBOutlet UIImageView * bgWeatherImg;
    @property (weak, nonatomic) IBOutlet UILabel *dateLbl;
    @property (weak, nonatomic) IBOutlet UILabel *contiLbl;
    @property (weak, nonatomic) IBOutlet UILabel *stateLbl;
    @property (weak, nonatomic) IBOutlet UILabel *summaryLbl;

    +(NSString *)reuseIdentifier;

@end
