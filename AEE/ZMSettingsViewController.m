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
#import "User.h"
@interface ZMSettingsViewController ()

@end

@implementation ZMSettingsViewController

@synthesize usernameField;
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
    
    ZMEntityManager *entityManager = [ZMEntityManager sharedInstance];
    User *loggedUser = [entityManager getUser];

    [usernameField setText:[loggedUser username]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)userNameSet:(id)sender {
}

- (IBAction)logout:(id)sender {
    
    [PFUser logOut];
    
    ZMEntityManager *entityManager = [ZMEntityManager sharedInstance];
    [entityManager clearUser];
    self.usernameField.text = @"";
    
}


@end
