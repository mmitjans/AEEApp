//
//  ZMUserConfigViewController.h
//  AEE
//
//  Created by Milton D. Mitjans on 6/17/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Parse/Parse.h>

@interface ZMUserConfigViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;

- (IBAction)logOutButtonTapAction:(id)sender;

@end
