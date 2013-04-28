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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    
    NSString* xml = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSData* xmlData = [xml dataUsingEncoding:NSUTF8StringEncoding];
    
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:xmlData];
    [parser setDelegate:self];
    [parser parse];

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"sensor"])
    {
        [self setLastSensor:[attributeDict valueForKey:@"name"]];
        [self.sensors addObject:[attributeDict valueForKey:@"name"]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self setType:string];
}
         
 - (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"type"])
    {
        [self.typeDict setValue:[self type] forKey:[self lastSensor]];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
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
