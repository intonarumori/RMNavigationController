//
//  DetailViewController.m
//  NavigationBarTest
//
//  Created by Daniel Langh on 17/04/2015.
//  Copyright (c) 2015 Daniel Langh. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"

@interface DetailViewController ()

@property (nonatomic) UINavigationBar *navBar;
@property (nonatomic) UIView *containerView;
@property (nonatomic) CGFloat headerHeight;

@end

@implementation DetailViewController

- (void)loadView
{
    _headerHeight = 300.0f;
    
    CGRect frame = CGRectMake(0, 0, 320, 480);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"Detail";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /////////
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, _headerHeight)];
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [self.tableView addSubview:self.containerView];
    
    [self setup];
}

- (void)setup
{
    UIImage *image = [UIImage imageNamed:@"car.jpg"];
    self.headerHeight = (self.view.bounds.size.width / image.size.width) * image.size.height;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = self.containerView.bounds;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self.containerView addSubview:imageView];
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44.0f)];
    [self.containerView addSubview:navigationBar];
    navigationBar.shadowImage = [UIImage new];
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    navigationBar.translucent = YES;
    self.navBar = navigationBar;
    
    UIFont *font = [UIFont boldSystemFontOfSize:17];
    UIColor *color = [UIColor whiteColor];
    NSDictionary *attributes = @{NSFontAttributeName:font, NSForegroundColorAttributeName:color};
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    [navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    [navigationItem.leftBarButtonItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Action" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    [navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    [navigationItem.rightBarButtonItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [navigationBar setTitleTextAttributes:attributes];
    navigationItem.title = @"Detail";
    self.navBar.items = @[navigationItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
    if(indexPaths.count > 0)
    {
        for(NSIndexPath *indexPath in indexPaths)
        {
            [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
        }
    }
}

- (void)setHeaderHeight:(CGFloat)headerHeight
{
    _headerHeight = headerHeight;
    self.tableView.contentInset = UIEdgeInsetsMake(_headerHeight, 0, 0, 0);
}

#pragma mark -

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //NSLog(@"didlayout %f", [self.topLayoutGuide length]);
    
    //self.containerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    
    self.navBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.topLayoutGuide.length + 44.0f);
    //self.navBar.items = @[self.navigationItem];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    
    CGFloat availableHeight = -contentOffsetY;
    CGFloat navigationHeaderHeight = [self.topLayoutGuide length] + 44.0f;
    CGFloat height = MAX(navigationHeaderHeight, availableHeight);
    CGFloat diff = contentOffsetY + height;
    CGFloat offsetY = -height + diff;

    //NSLog(@"top %f | %f %f %f %f", diff, offsetY, availableHeight, height, contentOffsetY);
    
    self.containerView.frame = CGRectMake(0, offsetY, self.tableView.bounds.size.width, height);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(height, 0, 0, 0);
}

#pragma mark -

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -

- (BOOL) hidesNavigationBar
{
    return YES;
}

- (BOOL)extendsNavigationBar
{
    return YES;
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"row";
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}


@end
