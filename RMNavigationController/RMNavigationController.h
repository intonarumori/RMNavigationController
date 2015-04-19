//
//  RMNavigationController.h
//  NavigationBarTest
//
//  Created by Daniel Langh on 17/04/2015.
//  Copyright (c) 2015 Daniel Langh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RMNavigationControllerContentViewController <NSObject>

@optional
- (BOOL)hidesNavigationBar;

@end

#pragma mark -

@interface RMNavigationController : UINavigationController

@end
