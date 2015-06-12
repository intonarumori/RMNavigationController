//
//  RMNavigationController.m
//  NavigationBarTest
//
//  Created by Daniel Langh on 17/04/2015.
//  Copyright (c) 2015 Daniel Langh. All rights reserved.
//

#import "RMNavigationController.h"

@interface RMNavigationController ()

@property (nonatomic) UIImage *originalShadowImage;
@property (nonatomic) UIImage *replacementShadowImage;

@end

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
    BOOL extendsNavigationBar = NO;
    
    if([viewController conformsToProtocol:@protocol(RMNavigationControllerContentViewController)])
    {
        id<RMNavigationControllerContentViewController> controller = (id<RMNavigationControllerContentViewController>)viewController;
        if([controller respondsToSelector:@selector(hidesNavigationBar)])
        {
            hidesNavigationBar = (BOOL)[controller performSelector:@selector(hidesNavigationBar)];
        }
        if([controller respondsToSelector:@selector(extendsNavigationBar)])
        {
            extendsNavigationBar = (BOOL)[controller performSelector:@selector(extendsNavigationBar)];
        }
    }
    if(self.navigationBarHidden != hidesNavigationBar)
    {
        [self setNavigationBarHidden:hidesNavigationBar animated:animated];
    }
    
    BOOL shouldHideShadowImage = extendsNavigationBar;
    
    if(_replacementShadowImage == nil) _replacementShadowImage = [UIImage new];

    
    UIImage *currentShadowImage = [self.navigationBar shadowImage];
    UIImage *backgroundImage = [self.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    
    if(shouldHideShadowImage)
    {
        if(backgroundImage == nil)
        {
            NSLog(@"Warning: you should set a background image before extending navigation bars, so the Shadow image can be hidden.");
        }
        else
        {
            if(currentShadowImage != _replacementShadowImage)
            {
                self.originalShadowImage = currentShadowImage;
                [self.navigationBar setShadowImage:_replacementShadowImage];
            }
        }
    }
    else
    {
        if(currentShadowImage != _originalShadowImage)
        {
            [self.navigationBar setShadowImage:_originalShadowImage];
        }
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
