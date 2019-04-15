//
//  SecondViewController.m
//  NumberTileGame
//
//  Created by huangchengdu on 2018/5/2.
//

#import "SecondViewController.h"
#import <React/RCTRootView.h>
#import "ReactNativeBridgeManager.h"


@interface SecondViewController ()
@property(nonatomic,strong)ReactNativeBridgeManager *bridgeManager;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"第二页";
    self.nativeView.backgroundColor = [UIColor greenColor];
    self.rnView.backgroundColor = [UIColor redColor];
    
    self.bridgeManager = [[ReactNativeBridgeManager alloc]init];
    
    [self pushModule:@"NativeBridge" params:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pop) name:navigatorPopEvent object:nil];
    
}
/*
 *native主动发送消息给rn
 */
- (IBAction)nativeSendMessageToRN:(id)sender {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"name" object:@{@"name":@"huang"}];
//    [self.bridgeManager sendEventWithName:@"nativeEvent" body:@{@"name":@"huang"}];
    [ReactNativeBridgeManager emit:@"name" args:@{@"name":@"huang"}];
}

- (IBAction)clickNavigator:(id)sender {
    [self pushModuleVC:@"NavigatorModule" params:nil];
}

-(void)pop{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController popViewControllerAnimated:YES];
    });
    
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
    rootView.frame = CGRectMake(0, 0, self.rnView.bounds.size.width, self.rnView.bounds.size.height);
    [self.rnView addSubview:rootView];
}

-(void)pushModuleVC:(NSString *)module params:(NSDictionary *)params{
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
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
