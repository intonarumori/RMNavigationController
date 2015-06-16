//
//  RMNavigationController.m
//  NavigationBarTest
//
//  Created by Daniel Langh on 17/04/2015.
//  Copyright (c) 2015 Daniel Langh. All rights reserved.
//

#import "RMNavigationController.h"


@implementation RMNavigationBarStyle

- (instancetype)initWithTranslucent:(BOOL)translucent
                    backgroundColor:(UIColor *)backgroundColor
                        shadowImage:(UIImage *)shadowImage
                    backgroundImage:(UIImage *)backgroundImage
                titleTextAttributes:(NSDictionary *)titleTextAttributes
                          tintColor:(UIColor *)tintColor
{
    self = [super init];
    if(self)
    {
        self.tintColor = tintColor;
        self.titleTextAttributes = titleTextAttributes;
        self.translucent = translucent;
        self.backgroundImage = backgroundImage;
        self.backgroundColor = backgroundColor;
        self.shadowImage = shadowImage;
    }
    return self;
}

@end


#pragma mark -

@interface RMNavigationController ()

@end

@implementation RMNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];

    [self updateNavigationBarHiddenWithViewController:viewController animated:animated];
}

- (void)setDefaultNavigationBarStyle:(RMNavigationBarStyle *)defaultNavigationBarStyle
{
    _defaultNavigationBarStyle = defaultNavigationBarStyle;
    [self updateNavigationBarStyle];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    [self updateNavigationBarHiddenWithViewController:self.topViewController animated:animated];
    return vc;
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    [super setViewControllers:viewControllers animated:animated];
    [self updateNavigationBarStyle];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSArray *viewControllers = [super popToViewController:viewController animated:animated];
    [self updateNavigationBarStyle];
    return viewControllers;
}
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    NSArray *viewControllers = [super popToRootViewControllerAnimated:animated];
    [self updateNavigationBarStyle];
    return viewControllers;
}

#pragma mark -

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
    
    RMNavigationBarStyle *style = _defaultNavigationBarStyle;
    if([viewController conformsToProtocol:@protocol(RMNavigationControllerContentViewController)] && [viewController respondsToSelector:@selector(navigationBarStyle)])
    {
        style = [(id<RMNavigationControllerContentViewController>)viewController navigationBarStyle];
    }
    [self applyNavigationBarStyle:style hideShadowImage:shouldHideShadowImage];
}

- (void)updateNavigationBarStyle
{
    RMNavigationBarStyle *style = _defaultNavigationBarStyle;
    if(self.topViewController)
    {
        if([self.topViewController conformsToProtocol:@protocol(RMNavigationControllerContentViewController)] && [self.topViewController respondsToSelector:@selector(navigationBarStyle)])
        {
            style = [(id<RMNavigationControllerContentViewController>)self.topViewController navigationBarStyle];
        }
    }
    [self applyNavigationBarStyle:style hideShadowImage:NO];
}

- (void)applyNavigationBarStyle:(RMNavigationBarStyle *)style hideShadowImage:(BOOL)hideShadowImage
{
    self.navigationBar.translucent = style.translucent;
    [self.navigationBar setTitleTextAttributes:style.titleTextAttributes];
    [self.navigationBar setBackgroundImage:style.backgroundImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage: hideShadowImage ? [UIImage new] : style.shadowImage];
    [self.navigationBar setTintColor:style.tintColor];
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    // TODO: hack
    __weak id weakSelf = self;
    self.interactivePopGestureRecognizer.delegate = weakSelf;

    [super setNavigationBarHidden:hidden animated:animated];
}

@end
