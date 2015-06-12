//
//  Detail2ViewController.m
//  RMNavigationControllerExample
//
//  Created by Daniel Langh on 11/06/15.
//  Copyright (c) 2015 rumori. All rights reserved.
//

#import "Detail2ViewController.h"

@interface Detail2ViewController ()

@end

@implementation Detail2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIView *navigationBarExtensionView = [[UIView alloc] init];
    navigationBarExtensionView.backgroundColor = [UIColor whiteColor];
    navigationBarExtensionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:navigationBarExtensionView];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:navigationBarExtensionView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0f constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:navigationBarExtensionView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0f constant:0.0]];
    [navigationBarExtensionView addConstraint:[NSLayoutConstraint constraintWithItem:navigationBarExtensionView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0f constant:60.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:navigationBarExtensionView
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom
                                                                          multiplier:1.0f constant:0.0]];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Push" forState:UIControlStateNormal];
    button.frame = CGRectMake((self.view.bounds.size.width-100)/2.0f, 200, 100, 50);
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)press:(id)sender
{
    Detail2ViewController *vc = [Detail2ViewController new];
    vc.shouldExtendNavigationBar = !self.shouldExtendNavigationBar;
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)extendsNavigationBar
{
    return _shouldExtendNavigationBar;
}

@end
