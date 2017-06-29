@import CSNative;
#import "AppDelegate.h"
#import "ViewController.h"

@interface ViewController ()
@property CSNAdsController *adsController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *fakeStops;
@property NSArray *ads;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _adsController = [[CSNAdsController alloc] initWithAdUnit:@"2562ccec-0788-44c9-a17d-13e0a114ff99"];
    AppDelegate* delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate setAdsController:_adsController ];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _fakeStops = [[NSMutableArray alloc] init];
    NSMutableArray *adRequests = [[NSMutableArray alloc] init];
        CSNTransitStop *transitStop = [[CSNTransitStop alloc] initWithIDs:@"cta" routeID:@"blue" stopID:@"11499"];
        [_fakeStops addObject:transitStop];
        CSNAdRequest *adRequest = [[CSNAdRequest alloc] init];
        [adRequest addStop:transitStop];
        [adRequests addObject:adRequest];
    [_adsController fetchAds:adRequests completed:^(NSArray<CSNOptionalAd *> *ads) {
        _ads = ads;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    }];

    [self.view setNeedsDisplay];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_fakeStops count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NSInteger row = [indexPath row];
    CSNAd *ad = [[_ads objectAtIndex:row] ad];
    CSNTransitStop *stop = [_fakeStops objectAtIndex:row];
    
    if(ad != nil) {
        CSNLogoView *logo = [[CSNLogoView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [cell addSubview:logo];
        CSNHeadlineView *headline = [[CSNHeadlineView alloc] initWithFrame:CGRectMake(50, 0, 200, 50)];
        [cell addSubview:headline];
        [_adsController buildView:cell ad:ad parentTouch:true];
    } else {
        [[cell textLabel] setText:[NSString stringWithFormat:@"%@ - %@", [stop agencyID], [stop stopID]]];
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

