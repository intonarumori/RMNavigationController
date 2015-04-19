//
//  RMViewController.m
//  NavigationBarTest
//
//  Created by Daniel Langh on 17/04/2015.
//  Copyright (c) 2015 Daniel Langh. All rights reserved.
//

#import "RMViewController.h"

@interface RMViewController ()

@property (nonatomic) UINavigationBar *translucentNavigationBar;

@end

@implementation RMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UINavigationItem *item = [self translucentNavigationItem];
    if(item)
    {
        self.navigationController.navigationBarHidden = YES;
        
        [self addTranslucentNavigationBarWithItem:item];
    }
    else
    {
        self.navigationController.navigationBarHidden = NO;
        
    }
}

- (void)addTranslucentNavigationBarWithItem:(UINavigationItem *)item
{
    if(_translucentNavigationBar == nil)
    {
        UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44.0f)];
        [self.view addSubview:navigationBar];
        navigationBar.shadowImage = [UIImage new];
        [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        navigationBar.translucent = YES;
        _translucentNavigationBar = navigationBar;
    }
    _translucentNavigationBar.items = @[item];
    [self.view addSubview:_translucentNavigationBar];
    [[self view] setNeedsLayout];
}

- (void)removeTranslucentNavigationBar
{
    [_translucentNavigationBar removeFromSuperview];
    [self.view setNeedsLayout];
}

#pragma mark -

- (UINavigationItem *)translucentNavigationItem
{
    return nil;
}


@end
