//
//  MDLSearchViewController.m
//  iCane
//
//  Created by Luffy on 3/14/14.
//  Copyright (c) 2014 Dumbass inc. All rights reserved.
//

#import "MDLSearchViewController.h"
#import "MDLStartupViewController.h"
#import "MDLMapViewController.h"
#import "MDLSpeechModule.h"

@interface MDLSearchViewController ()

@property MDLSpeechModule *speechModule;
@property NSString *detectedSpeech;

@end

@implementation MDLSearchViewController

@synthesize speechModule;
@synthesize searchRequest;
@synthesize destIndex;
@synthesize query;
@synthesize detectedSpeech;


/*
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    UIButton *addReloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addReloadButton setTitle:@"Reload" forState:UIControlStateNormal];
    [addReloadButton addTarget:self action:@selector(reloadData:) forControlEvents:UIControlEventTouchUpInside];
    addReloadButton.frame = CGRectMake(0, 0, 5, 5); //set some large width to ur title
    //[footerView addSubview:addReloadButton];
    //return footerView;
    return addReloadButton;
}

- (void)reloadData:(id)sender {
    [self.tableView reloadData];
}
*/

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //make search
    self.searchRequest = [[MDLSearch alloc] init];
    [self.searchRequest makeSearchRequestWithQuery:self.query];
    [self addObserver:self forKeyPath:@"searchRequest.results" options:NSKeyValueObservingOptionNew context:nil];
    
    NSArray * words = [NSArray arrayWithObjects:@"ONE", @"TWO", @"THREE", @"FOUR", @"FIVE", @"SIX", @"ROUTE",nil];
    speechModule = [[MDLSpeechModule alloc] initWithWords:words];
    [speechModule detectSpeech];
    [self addObserver:self forKeyPath:@"speechModule.detected" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.searchRequest.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    MKMapItem *item = [self.searchRequest.results objectAtIndex:(NSInteger)[indexPath row]];
    NSString *destinationString = @"";
    destinationString = [destinationString stringByAppendingString:item.name];
    destinationString = [destinationString stringByAppendingString:@"    "];
    
    cell.textLabel.text = destinationString;
    
    return cell;
}
                                

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.destIndex = [indexPath row];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"searchRequest.results"])
    {
        //innunciate the results
        for (MKMapItem *item in searchRequest.results)
        {
            [speechModule echoString:item.name];
        }
        
        [self.tableView reloadData];
    }
    else if([keyPath isEqualToString:@"speechModule.detected"])
    {
        NSString *newVal = [change objectForKey:NSKeyValueChangeNewKey];
        if([newVal isEqualToString:@"ROUTE"])
        {
            NSString *toEcho = @"Initializing route for ";
            MKMapItem *item = [searchRequest.results objectAtIndex:destIndex];
            toEcho = [toEcho stringByAppendingString:item.name];
            [speechModule echoString:toEcho];
            
            [speechModule stop];
            [self performSegueWithIdentifier:@"navigateSegue" sender:self];
        }
        else
        {
            detectedSpeech = [change objectForKey:NSKeyValueChangeNewKey];
            if([detectedSpeech isEqualToString:@"ONE"])
            {
                destIndex = 0;
                
                NSString *toEcho = @"You picked ";
                MKMapItem *item = [searchRequest.results objectAtIndex:destIndex];
                toEcho = [toEcho stringByAppendingString:item.name];
                [speechModule echoString:toEcho];
            }
            else if([detectedSpeech isEqualToString:@"TWO"])
            {
                destIndex = 1;
                NSString *toEcho = @"You picked ";
                MKMapItem *item = [searchRequest.results objectAtIndex:destIndex];
                toEcho = [toEcho stringByAppendingString:item.name];
                [speechModule echoString:toEcho];
            }
            else if([detectedSpeech isEqualToString:@"THREE"])
            {
                destIndex = 2;
                NSString *toEcho = @"You picked ";
                MKMapItem *item = [searchRequest.results objectAtIndex:destIndex];
                toEcho = [toEcho stringByAppendingString:item.name];
                [speechModule echoString:toEcho];
            }
            else if([detectedSpeech isEqualToString:@"FOUR"])
            {
                destIndex = 3;
                NSString *toEcho = @"You picked ";
                MKMapItem *item = [searchRequest.results objectAtIndex:destIndex];
                toEcho = [toEcho stringByAppendingString:item.name];
                [speechModule echoString:toEcho];
            }
            else if([detectedSpeech isEqualToString:@"FIVE"])
            {
                destIndex = 4;
                NSString *toEcho = @"You picked ";
                MKMapItem *item = [searchRequest.results objectAtIndex:destIndex];
                toEcho = [toEcho stringByAppendingString:item.name];
                [speechModule echoString:toEcho];
            }
            else if([detectedSpeech isEqualToString:@"SIX"])
            {
                destIndex = 5;
                NSString *toEcho = @"You picked ";
                MKMapItem *item = [searchRequest.results objectAtIndex:destIndex];
                toEcho = [toEcho stringByAppendingString:item.name];
                [speechModule echoString:toEcho];
            }
        }
    }
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //((MDLSearchViewController *)segue.destinationViewController).query = [[NSString alloc] initWithString:self.query.text];
    ((MDLMapViewController *)segue.destinationViewController).destination = [self.searchRequest.results objectAtIndex:self.destIndex];
}


@end
