//
//  RMNavigationController.m
//  NavigationBarTest
//
//  Created by Daniel Langh on 17/04/2015.
//  Copyright (c) 2015 Daniel Langh. All rights reserved.
//

#import "RMNavigationController.h"

@implementation RMNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];

    [self updateNavigationBarHiddenWithViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    [self updateNavigationBarHiddenWithViewController:self.topViewController animated:animated];
    return vc;
}

- (void)updateNavigationBarHiddenWithViewController:(UIViewController *)viewController
                                           animated:(BOOL)animated
{
    BOOL hidesNavigationBar = NO;
    if([viewController conformsToProtocol:@protocol(RMNavigationControllerContentViewController)])
    {
        id<RMNavigationControllerContentViewController> controller = (id<RMNavigationControllerContentViewController>)viewController;
        if([controller respondsToSelector:@selector(hidesNavigationBar)])
        {
            hidesNavigationBar = (BOOL)[controller performSelector:@selector(hidesNavigationBar)];
        }
    }
    if(self.navigationBarHidden != hidesNavigationBar)
    {
        [self setNavigationBarHidden:hidesNavigationBar animated:animated];
    }
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    // TODO: hack
    __weak id weakSelf = self;
    self.interactivePopGestureRecognizer.delegate = weakSelf;

    [super setNavigationBarHidden:hidden animated:animated];
}

@end
