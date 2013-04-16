//
//  SampleTableViewController.m
//  ECSlidingViewController
//
//  Created by Michael Enriquez on 2/13/12.
//  Copyright (c) 2012 EdgeCase. All rights reserved.
//

#import "SampleTableViewController.h"

@interface SampleTableViewController()
@property (nonatomic, strong) NSArray *sampleItems;
@end

@implementation SampleTableViewController
@synthesize sampleItems;

- (void)awakeFromNib
{
  self.sampleItems = [NSArray arrayWithObjects:@"HTTPTest",
                      @"Bluetooth", @"Sensor Configuration", @"FTP Put", @"FTP Get", @"FTP List", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
  return self.sampleItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellIdentifier = @"SampleCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
  }
  
  cell.textLabel.text = [self.sampleItems objectAtIndex:indexPath.row];
  
  return cell;
}

- (IBAction)revealMenu:(id)sender
{
  [self.slidingViewController anchorTopViewTo:ECRight];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
  return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = [self.sampleItems objectAtIndex:indexPath.row];
    
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
