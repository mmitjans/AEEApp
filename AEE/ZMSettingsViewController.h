//
//  ZMSettingsViewController.h
//  AEE
//
//  Created by Milton D. Mitjans on 6/29/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMSettingsViewController : UITableViewController
{
}

@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@end

