//
//  RMNavigationController.h
//  NavigationBarTest
//
//  Created by Daniel Langh on 17/04/2015.
//  Copyright (c) 2015 Daniel Langh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMNavigationBarStyle;

@protocol RMNavigationControllerContentViewController <NSObject>

@optional
- (BOOL)hidesNavigationBar;
- (BOOL)extendsNavigationBar;
- (UIColor *)preferredNavigationBarColor;
- (RMNavigationBarStyle *)navigationBarStyle;

@end

#pragma mark -

@interface RMNavigationBarStyle : NSObject

@property (nonatomic, assign) BOOL translucent;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIImage *shadowImage;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) NSDictionary *titleTextAttributes;

- (instancetype)initWithTranslucent:(BOOL)translucent
                    backgroundColor:(UIColor *)backgroundColor
                        shadowImage:(UIImage *)shadowImage
                    backgroundImage:(UIImage *)backgroundImage
                titleTextAttributes:(NSDictionary *)titleTextAttributes
                          tintColor:(UIColor *)tintColor;


@end

@interface RMNavigationController : UINavigationController

@property (nonatomic) RMNavigationBarStyle *defaultNavigationBarStyle;

@end
