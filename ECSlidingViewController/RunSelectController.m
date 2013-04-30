//
//  RunSelectController.m
//  AVALANCHE
//
//  Created by BehindTheCurtain on 4/16/13.
//
//

#import "RunSelectController.h"

@interface RunSelectController ()

@end

@implementation RunSelectController

@synthesize sensors;
@synthesize selectedRun;
@synthesize typeDict;
@synthesize lastSensor;
@synthesize type;

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

    self.navigationItem.title = @"Select Run";
    self.sensors = [[NSMutableArray alloc] init];
    self.selectedRun = [[RunModel alloc] init];
    self.typeDict = [[NSMutableDictionary alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    int runNum = [[[RunListModel instance:NO] runNames] count];
    
    return  runNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSString *cellIdentifier = @"runCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [[[RunListModel instance:NO] runNames] objectAtIndex:indexPath.row];
    
    return cell;
}

//Necessary for swipe to delete
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//Swipe to delete
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        RunModel* run = [[[RunListModel instance:NO] runList] objectAtIndex:indexPath.row];
        
        [[NSFileManager defaultManager] removeItemAtPath:[run filePath] error:nil];
        
        [[[RunListModel instance:NO] runList] removeObjectAtIndex:indexPath.row];
        
        [tableView reloadData];
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.sensors = [[NSMutableArray alloc] init];
    RunModel* run = [[[RunListModel instance:NO] runList] objectAtIndex:indexPath.row];
    self.selectedRun = run;
    NSString* filePath = [run filePath];
    
        
    NSString* json = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSData* jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSMutableDictionary* runDict = [jsonDict valueForKey:@"run"];
    NSMutableDictionary* sensorsDict = [runDict valueForKey:@"sensors"];
    NSMutableDictionary* sensor = [sensorsDict valueForKey:@"sensor"];
    
    for(NSMutableDictionary* sensorDict in sensor)
    {
        NSString* name = [sensorDict valueForKey:@"name"];
        NSString* typeName = [sensorDict valueForKey:@"type"];
        
        [self.sensors addObject:name];
        [self.typeDict setValue:typeName forKey:name];
    }
    
    [self.sensors sortUsingSelector:@selector(caseInsensitiveCompare:)];
    SensorSelectController* sensorSelect = [self.storyboard instantiateViewControllerWithIdentifier:@"sensorSelect"];
    [sensorSelect setRun:[self selectedRun]];
    [sensorSelect setSensors:[self sensors]];
    [sensorSelect setTypeDict:[self typeDict]];

    [self.navigationController pushViewController:sensorSelect animated:YES];
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}
@end
