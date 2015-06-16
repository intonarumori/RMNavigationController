//
//  AppDelegate.m
//  NavigationBarTest
//
//  Created by Daniel Langh on 17/04/2015.
//  Copyright (c) 2015 Daniel Langh. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "RMNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    ViewController *vc = [ViewController new];
    RMNavigationController *nvc = [[RMNavigationController alloc] initWithRootViewController:vc];
    nvc.defaultNavigationBarStyle = [[RMNavigationBarStyle alloc] initWithTranslucent:NO backgroundColor:[UIColor redColor] shadowImage:nil backgroundImage:[UIImage imageNamed:@"White"] titleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} tintColor:nil];
    [nvc.navigationBar setBackgroundImage:[UIImage imageNamed:@"White"] forBarMetrics:UIBarMetricsDefault];
    self.window.rootViewController = nvc;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
