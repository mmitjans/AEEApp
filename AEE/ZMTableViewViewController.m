//
//  ZMTableViewViewController.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/12/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMTableViewViewController.h"
#import "ZMClientProcessor.h"
#import "ZMBreakdownsTableViewCell.h"

#import "BreakdownReportSvc.h"

#import "ZMBDownsDetailedTableViewController.h"

#import "ZMGradientView.h"

#import "ZMNewUserViewController.h"
#import "ZMSettingsViewController.h"

#import "ZMEntityManager.h"
#import "User.h"

#import "ZMParseHelper.h"

#import <Parse/Parse.h>

@interface ZMTableViewViewController ()

@property (nonatomic, assign) Boolean loaded;
@property (nonatomic, strong) NSMutableArray* breakDowns;
@property (nonatomic, strong) NSMutableDictionary* breakDownsDetails;

@property (nonatomic, strong) UILabel *activityLabel;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, assign) CGRect frame;
@end

@implementation ZMTableViewViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        // when applicacion comes from the background
        // it process the data again
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(processData)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl = self.refreshControl;
    
    [self.refreshControl addTarget:self
                            action:@selector(handleRefresh:)
                  forControlEvents:UIControlEventValueChanged];
    self.loaded = NO;
    
    [self processData];
}

- (void) handleRefresh:(id)paramSender{
    /* Put a bit of delay between when the refresh control is released
     ￼￼4.14 Displaying a Refresh Control for Table Views | 333
     and when we actually do the refreshing to make the UI look a bit
     smoother than just doing the update without the animation */
    int64_t delayInSeconds = 1.0f;
    dispatch_time_t popTime =
        dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        /* Add the current date to the list of dates that we have
         so that when the table view is refreshed, a new item will appear on the screen so that the user will see the difference between the before and the after of the refresh */

        [self.refreshControl endRefreshing];
        
        [self processData];
        
        [self.tableView reloadData]; });
}

-(void) processData
{
    ZMClientProcessor *client = [[ZMClientProcessor alloc] init];
    self.breakDowns = [client getBreakdowns];
    
    self.breakDownsDetails = [[NSMutableDictionary alloc] init];
    
    [self.breakDowns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ax22_BreakdownSummary* summary = (ax22_BreakdownSummary*) obj;
        
        NSString *townName = summary.r1TownOrCity;
        
        NSMutableArray* townDetails = [client getBreakdownsByTownOrCity:townName];
        
        [self.breakDownsDetails setValue:townDetails forKey:townName];
    }];
    
    self.loaded = YES;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.loaded) {
        return [self.breakDowns count];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self processData];
    
    static NSString *CellIdentifier = @"Cell";
    ZMBreakdownsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    ax22_BreakdownSummary *summary = [self.breakDowns objectAtIndex:indexPath.row];
    
    cell.myLabel.text = summary.r1TownOrCity;
    [cell setBreakdowns:summary.r2TotalBreakdowns];
    
     NSString *totalBreakdoown = [NSString stringWithFormat:@"%@%@", @"Total Breakdowns: ", summary.r2TotalBreakdowns];
    cell.totalOfBreakdowns.text = totalBreakdoown;
    
    cell.backgroundView = [[ZMGradientView alloc] init];

    return cell;
}
- (IBAction)setSettings:(id)sender
{
    __block ZMEntityManager *entityManager = [ZMEntityManager sharedInstance];
    
    User *user = [entityManager getUser];
    
    if(user == nil) {
        __block ZMNewUserViewController *newUserViewController =
        [[ZMNewUserViewController alloc] initWithNibName:@"ZMNewUserViewController" bundle:nil];
        
        [self.navigationController presentViewController:newUserViewController
                                                animated:YES
                                              completion:^{
                                              }];
    } else {
        
        // sets the username and password
        ZMSettingsViewController *settingsController =
            [[ZMSettingsViewController alloc] initWithNibName:@"ZMSettingsViewController" bundle:nil];
        
        [settingsController setUsername:[user username]];
        [settingsController setPassword:[user password]];
        
        [ZMParseHelper logInWithUsername:user.username
                             andPassword:user.password
                           andParseBlock:^(PFUser *user, NSError *error) {
                               
                           }];
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailBreakdown"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        ZMBDownsDetailedTableViewController *destViewController =
            segue.destinationViewController;
        
        ax22_BreakdownSummary *summary = [self.breakDowns objectAtIndex:indexPath.row];
        
        destViewController.townName = [self.breakDownsDetails objectForKey:summary.r1TownOrCity];
        
    } else if ([segue.identifier isEqualToString:@"settingsSegue"]) {
        
        
        
    }
}

- (IBAction)reportBreakdown:(id)sender {
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void) dealloc
{
    // removes observer
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
}

@end
