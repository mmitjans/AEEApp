//
//  ZMNewUserViewController.h
//  AEE
//
//  Created by Milton D. Mitjans on 7/1/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMNewUserViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;


@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgainField;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
