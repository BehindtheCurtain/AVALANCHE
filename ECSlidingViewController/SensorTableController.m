//
//  SensorTableController.m
//  ECSlidingViewController
//
//  Created by BehindTheCurtain on 3/28/13.
//
//

#import "SensorTableController.h"

@interface SensorTableController ()

@end

@implementation SensorTableController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Select Sensor";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)awakeFromNib
{

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [[[ConfigurationModelMap instance] sensorNames] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"SampleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [[[ConfigurationModelMap instance] sensorNames] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [[[[ConfigurationModelMap instance] configurationMap] objectAtIndex:indexPath.row] getType];
    
    return cell;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConfigurationModel* configuration = [[[ConfigurationModelMap instance] configurationMap] objectAtIndex:indexPath.row];
    
    SensorConfigViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"sensorConfigView"];
    [viewController setConfiguration:configuration];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

//Necessary for swipe to delete
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//Swipe to delete
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray* configMap = [[ConfigurationModelMap instance] configurationMap];
        ConfigurationModel* configuration = [[[ConfigurationModelMap instance] configurationMap] objectAtIndex:indexPath.row];
        [configMap removeObjectAtIndex:[configMap indexOfObject:configuration]];
        [self.tableView reloadData];
        [[ConfigurationModelMap instance] archive];
    }
}

@end
