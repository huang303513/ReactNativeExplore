//
//  F3HViewController.m
//  NumberTileGame
//
//  Created by Austin Zheng on 3/22/14.
//
//

#import "F3HViewController.h"

#import <React/RCTRootView.h>


@interface F3HViewController ()
@end

@implementation F3HViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title =@"首页";
    self.navigationController.navigationBar.translucent = NO;
}

- (IBAction)clickHighScore:(id)sender {
    
    NSDictionary *params = @{
                             @"scores" : @[
                                     @{
                                         @"name" : @"Alex",
                                         @"value": @"42"},
                                     @{
                                         @"name" : @"Joel",
                                         @"value": @"10"
                                         }
                                     ]
                             };
     [self pushModule:@"RNHighScores" params:params];
}

- (IBAction)clickState:(id)sender {
    [self pushModule:@"BlinkApp" params:nil];
}

- (IBAction)clickStyle:(id)sender {
    [self pushModule:@"StyleModule" params:nil];
}
- (IBAction)clickButton:(id)sender {
    [self pushModule:@"ButtonModule" params:nil];
}
- (IBAction)clickList:(id)sender {
    [self pushModule:@"ListModule" params:nil];
}
- (IBAction)clickPlatform:(id)sender {
    [self pushModule:@"PlatformModule" params:nil];
}
- (IBAction)bridgeNative:(id)sender {
    [self pushModule:@"BridgeModule" params:nil];
}

- (IBAction)clickMapView:(id)sender {
    [self pushModule:@"MapViewModule" params:nil];
}



-(void)pushModule:(NSString *)module params:(NSDictionary *)params{
    NSURL *jsCodeLocation;
    if(DEBUG){
        jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
    }else{
        NSString *local = [[NSBundle mainBundle] pathForResource:@"assets/index.ios.bundle.js" ofType:nil];
        jsCodeLocation = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",local]];
    }
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL: jsCodeLocation
                                                        moduleName: module
                                                 initialProperties:params launchOptions: nil];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
