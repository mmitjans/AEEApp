//
//  ZMNewUserViewController.m
//  AEE
//
//  Created by Milton D. Mitjans on 7/1/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMNewUserViewController.h"
#import "ZMEntityManager.h"

#import <Parse/Parse.h>

#import "ZMParseHelper.h"

#import "MBProgressHUD.h"

#import <Parse/Parse.h>

@interface ZMNewUserViewController ()

@property (strong, nonatomic) PFUser* authenticatedUser;

- (void)textInputChanged:(NSNotification *)note;
- (BOOL)shouldEnableDoneButton;
@end

@implementation ZMNewUserViewController

@synthesize doneButton;
@synthesize usernameField;
@synthesize passwordField, passwordAgainField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:166 green:221 blue:255 alpha:1];
    
    // Do any additional setup after loading the view from its nib.
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChanged:) name:UITextFieldTextDidChangeNotification object:usernameField];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChanged:) name:UITextFieldTextDidChangeNotification object:passwordField];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChanged:) name:UITextFieldTextDidChangeNotification object:passwordAgainField];
    
    
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
    self.passwordAgainField.delegate = self;
    
	doneButton.enabled = NO;
    
    [usernameField setRequired:YES];
    [usernameField setEmailField:YES];
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:usernameField];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:passwordField];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:passwordAgainField];
}

- (void)viewWillAppear:(BOOL)animated {
	//[usernameField becomeFirstResponder];
	[super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:usernameField];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:passwordField];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:passwordAgainField];
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == usernameField) {
		[passwordField becomeFirstResponder];
	}
	if (textField == passwordField) {
		[passwordAgainField becomeFirstResponder];
	}
	if (textField == passwordAgainField) {
		[passwordAgainField resignFirstResponder];
		[self processNewUserFields];
	}
    
	return YES;
}

#pragma mark - UITextField text field change notifications and helper methods

- (BOOL)shouldEnableDoneButton {
	BOOL enableDoneButton = NO;
	if (usernameField.text != nil &&
		usernameField.text.length > 0 &&
		passwordField.text != nil &&
		passwordField.text.length > 0 &&
		passwordAgainField.text != nil &&
		passwordAgainField.text.length > 0) {
		enableDoneButton = YES;
	}
	return enableDoneButton;
}

- (void)textInputChanged:(NSNotification *)note {
	doneButton.enabled = [self shouldEnableDoneButton];
}

#pragma mark User push button's
- (IBAction)cancel:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender
{
    [usernameField resignFirstResponder];
	[passwordField resignFirstResponder];
	[passwordAgainField resignFirstResponder];
}

- (IBAction)signIn:(id)sender
{
    [usernameField resignFirstResponder];
	[passwordField resignFirstResponder];
    
    if(![self processSignInFieldEntries])
    {
        __weak ZMNewUserViewController *weakSelf = self;
        
        
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Signing in";
        
        [ZMParseHelper logInWithUsername:usernameField.text
                             andPassword:passwordField.text
                           andParseBlock:^(PFUser *user, NSError *error) {
                               
                               weakSelf.authenticatedUser = user;
                               
                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                               
                               if([user isAuthenticated])
                               {
                                   ZMEntityManager *entityManager = [ZMEntityManager sharedInstance];
                                   
                                   [entityManager storeUser:[user username] andPassword:[user password]];
                                   
                                   [weakSelf dismissViewControllerAnimated:YES completion:^{
                                       
                                   }];
                               }
                               
                           }];
    }

}

- (IBAction)registerUser:(id)sender
{
    [passwordAgainField setHidden:NO];
    
    [UIView animateWithDuration:1 delay:0.1
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
        self.signInButton.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [self.realRegisterButton setHidden:NO];
                         // TODO: self.realRegisterButton.alpha = 1.0;
                         
                         self.registerButton.alpha = 0.0;
                         [self.registerButton setHidden:YES];
                     }];

    
}

// This is the action that will register the user
- (IBAction)realRegisterHit:(id)sender
{
    UIAlertView *alertView =
    [[UIAlertView alloc] initWithTitle:@"User Registration"
                               message:@"Do something interesting!"
                              delegate:nil
                     cancelButtonTitle:nil
                     otherButtonTitles:@"Ok", nil];
    
    if (![self validateInputInView:self.view]){
        
        [alertView setMessage:@"Invalid information please review and try again!"];
        [alertView setTitle:@"Registration Failed"];
        
        [alertView show];
    }
    else
    {
        
        [usernameField resignFirstResponder];
        [passwordField resignFirstResponder];
        [passwordAgainField resignFirstResponder];
        
        // Creates the new user
        __block PFUser *user = [PFUser user];
        user.username = self.usernameField.text;
        user.password = self.passwordField.text;
        user.email = self.usernameField.text;

        __weak ZMNewUserViewController *weakSelf = self;
        
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Registering";
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
        {
            if (!error) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                [alertView setMessage:@"Registration completed"];
                [alertView setTitle:@"Registration Successful"];
                
                ZMEntityManager *entityManager = [ZMEntityManager sharedInstance];
                
                [entityManager storeUser:[user username] andPassword:[user password]];
                
                
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
                
            } else {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSString *errorString = [error userInfo][@"error"];
                
                [alertView setMessage:errorString];
                [alertView setTitle:@"Registration Unsuccessful"];
            }
            
            [alertView show];
        }];
    }
    
    
}

#pragma mark - Private methods:

- (BOOL)validateInputInView:(UIView*)view
{
    for(UIView *subView in view.subviews){
        if ([subView isKindOfClass:[UIScrollView class]])
            return [self validateInputInView:subView];
        
        if ([subView isKindOfClass:[MHTextField class]]){
            if (![(MHTextField*)subView validate]){
                return NO;
            }
        }
    }
    
    return YES;
}

#pragma mark Field validation
-(bool)processSignInFieldEntries
{
   	// Check that we have a non-zero username and passwords.
	// Compare password and passwordAgain for equality
	// Throw up a dialog that tells them what they did wrong if they did it wrong.
    
	NSString *username = usernameField.text;
	NSString *password = passwordField.text;
	NSString *errorText = @"Please ";
	NSString *usernameBlankText = @"enter a username";
	NSString *passwordBlankText = @"enter a password";
    NSString *joinText = @", and ";
	
    BOOL textError = NO;
    
	// Messaging nil will return 0, so these checks implicitly check for nil text.
	if (username.length == 0 || password.length == 0) {
		textError = YES;
        
		// Set up the keyboard for the first field missing input:
		if (password.length == 0) {
			[passwordField becomeFirstResponder];
		}
		if (username.length == 0) {
			[usernameField becomeFirstResponder];
		}
        
		if (username.length == 0) {
			errorText = [errorText stringByAppendingString:usernameBlankText];
		}
        
		if (password.length == 0) {
			if (username.length == 0) { // We need some joining text in the error:
				errorText = [errorText stringByAppendingString:joinText];
			}
			errorText = [errorText stringByAppendingString:passwordBlankText];
		}
        
		[self showErrorAlert:errorText];
	}

    return textError;
}

-(void)showErrorAlert:(NSString*)errorText
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorText
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Ok", nil];
    [alertView show];
}

- (void)processNewUserFields
{
	// Check that we have a non-zero username and passwords.
	// Compare password and passwordAgain for equality
	// Throw up a dialog that tells them what they did wrong if they did it wrong.
    
	NSString *username = usernameField.text;
	NSString *password = passwordField.text;
	NSString *passwordAgain = passwordAgainField.text;
	NSString *errorText = @"Please ";
	NSString *usernameBlankText = @"enter a username";
	NSString *passwordBlankText = @"enter a password";
	NSString *joinText = @", and ";
	NSString *passwordMismatchText = @"enter the same password twice";
    
	BOOL textError = NO;
    
	// Messaging nil will return 0, so these checks implicitly check for nil text.
	if (username.length == 0 || password.length == 0 || passwordAgain.length == 0) {
		textError = YES;
        
		// Set up the keyboard for the first field missing input:
		if (passwordAgain.length == 0) {
			[passwordAgainField becomeFirstResponder];
		}
		if (password.length == 0) {
			[passwordField becomeFirstResponder];
		}
		if (username.length == 0) {
			[usernameField becomeFirstResponder];
		}
        
		if (username.length == 0) {
			errorText = [errorText stringByAppendingString:usernameBlankText];
		}
        
		if (password.length == 0 || passwordAgain.length == 0) {
			if (username.length == 0) { // We need some joining text in the error:
				errorText = [errorText stringByAppendingString:joinText];
			}
			errorText = [errorText stringByAppendingString:passwordBlankText];
		}
        
        [self showErrorAlert:errorText];
	}
	
	// We have non-zero strings.
	// Check for equal password strings.
	if ([password compare:passwordAgain] != NSOrderedSame) {
		textError = YES;
		errorText = [errorText stringByAppendingString:passwordMismatchText];
		[passwordField becomeFirstResponder];
		[self showErrorAlert:errorText];
	}


}

- (IBAction)loginWithFacebook:(id)sender
{
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_location"];
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew)
        {
            ZMEntityManager *entityManager = [ZMEntityManager sharedInstance];
            
            [entityManager storeUser:[user username] andPassword:[user password]];
            
        } else {
            NSLog(@"User with facebook logged in!");
            
        }
    }];
    
}


@end
