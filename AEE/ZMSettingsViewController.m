//
//  ZMSettingsViewController.m
//  AEE
//
//  Created by Milton D. Mitjans on 6/29/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMSettingsViewController.h"
#import <Parse/Parse.h>
#import "ZMEntityManager.h"

@interface ZMSettingsViewController ()

@end

@implementation ZMSettingsViewController

@synthesize usernameField;
@synthesize passwordField;
@synthesize username;
@synthesize password;

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
    
    [usernameField setText:username];
    [passwordField setText:password];
}

- (void)viewWillAppear:(BOOL)animated
{
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
    
    // clears the text fields
    self.passwordField.text = @"";
    
    ZMEntityManager *entityManager = [ZMEntityManager sharedInstance];
    
    [entityManager clearUser];
    
}


@end
