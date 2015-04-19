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
    UINavigationController *nvc = [[RMNavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nvc;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
