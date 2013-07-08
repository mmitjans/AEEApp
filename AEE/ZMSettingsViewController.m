//
//  ZMSettingsViewController.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/29/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMSettingsViewController.h"
#import <Parse/Parse.h>

@interface ZMSettingsViewController ()

@end

@implementation ZMSettingsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userNameSet:(id)sender {
}

- (IBAction)logout:(id)sender {
    
    [PFUser logOut];
    
}


@end
