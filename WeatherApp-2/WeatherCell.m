#import "WeatherCell.h"

@implementation WeatherCell
@synthesize maxLbl = _maxLbl;
@synthesize minLbl = _minLbl;
@synthesize weatherImg = _weatherImg;
//@synthesize dayLbl = _dayLbl;
@synthesize dateLbl = _dateLbl;
@synthesize contiLbl = _contiLbl;
@synthesize bgWeatherImg;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier {
    return @"WeatherCellIdentifier";
}

@end
