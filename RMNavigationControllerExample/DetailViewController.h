//
//  DetailViewController.h
//  NavigationBarTest
//
//  Created by Daniel Langh on 17/04/2015.
//  Copyright (c) 2015 Daniel Langh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMViewController.h"
#import "RMNavigationController.h"

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, RMNavigationControllerContentViewController>

@property (nonatomic) UITableView *tableView;

- (BOOL)hidesNavigationBar;

@end
