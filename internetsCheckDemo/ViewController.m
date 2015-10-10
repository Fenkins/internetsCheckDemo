//
//  ViewController.m
//  internetsCheckDemo
//
//  Created by Fenkins on 10/10/15.
//  Copyright © 2015 Fenkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    Reachability* internetReachableCheck;
    BOOL _isNetworkReachable;
}

@end

@implementation ViewController

-(void)testInternetConnection {
    internetReachableCheck = [Reachability reachabilityWithHostName:@"www.google.com"];
    // If internet is reachable
    internetReachableCheck.reachableBlock = ^(Reachability*reach) {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            _isNetworkReachable = YES;
            NSLog(@"yea");
        });
    };
    // If internet is not reachable
    internetReachableCheck.unreachableBlock = ^(Reachability*reach) {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            _isNetworkReachable = NO;
            NSLog(@"nope");
        });
    };
    [internetReachableCheck startNotifier];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Running that method up there to check if we are connected to the internets
    [self testInternetConnection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)amIConnectedButton:(UIButton *)sender {
    if (_isNetworkReachable) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network status" message:@"Network online" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network status" message:@"Network offline" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    }
}
@end
