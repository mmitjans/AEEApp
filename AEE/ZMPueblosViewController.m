//
//  ZMPueblosViewController.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/29/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMPueblosViewController.h"
#import "ZMEntityManager.h"
#import "ZMBarriosViewController.h"

#import "Pueblo.h"

@interface ZMPueblosViewController ()

@end

@implementation ZMPueblosViewController

@synthesize pueblos;

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
    
    ZMEntityManager *entityManager = [ZMEntityManager sharedInstance];
    
    pueblos = [entityManager getAllPueblos];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [pueblos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PuebloCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    Pueblo *pueblo = [pueblos objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [pueblo name];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BarrioSelection"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ZMBarriosViewController *destViewController = segue.destinationViewController;
        
        Pueblo *pueblo = [self.pueblos objectAtIndex:indexPath.row];
        
        NSMutableArray *barrios =
        [[NSMutableArray alloc] initWithArray:[[pueblo relationship] allObjects]];
        
        destViewController.barrios = barrios;
        
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
