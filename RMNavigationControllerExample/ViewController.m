//
//  ViewController.m
//  NavigationBarTest
//
//  Created by Daniel Langh on 17/04/2015.
//  Copyright (c) 2015 Daniel Langh. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "Detail2ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Cells";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 480, 30)];
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.title;
    self.navigationItem.titleView = label;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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

#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row % 2)
    {
        DetailViewController *vc = [[DetailViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        Detail2ViewController *vc = [[Detail2ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
