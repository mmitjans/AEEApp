//
//  ZMNewUserViewController.m
//  AEE
//
//  Created by Milton D. Mitjans on 7/1/13.
//  Copyright (c) 2013 Milton D. Mitjans. All rights reserved.
//

#import "ZMNewUserViewController.h"
#import "ZMEntityManager.h"

#import "PAWActivityView.h"

#import <Parse/Parse.h>

#import "ZMParseHelper.h"

@interface ZMNewUserViewController ()
- (void)processFieldEntries;
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
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChanged:) name:UITextFieldTextDidChangeNotification object:usernameField];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChanged:) name:UITextFieldTextDidChangeNotification object:passwordField];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textInputChanged:) name:UITextFieldTextDidChangeNotification object:passwordAgainField];
    
	doneButton.enabled = NO;
    
    [usernameField setRequired:YES];
    [usernameField setEmailField:YES];
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:usernameField];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:passwordField];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:passwordAgainField];
    // Release any retained subviews of the main view.
    

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
		[self processFieldEntries];
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
	[self processFieldEntries];
}

- (IBAction)signIn:(id)sender
{
    __weak ZMNewUserViewController *weakSelf = self;
    
    [ZMParseHelper logInWithUsername:usernameField.text
                         andPassword:passwordField.text
                       andParseBlock:^(PFUser *user, NSError *error) {
                           
                           if([user isAuthenticated])
                           {
                               [weakSelf dismissViewControllerAnimated:YES completion:^{
                                   
                               }];
                           }
                           

    }];
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

- (IBAction)realRegisterHit:(id)sender
{
    UIAlertView *alertView =
    [[UIAlertView alloc] initWithTitle:@"Success"
                               message:@"Do something interesting!"
                              delegate:nil
                     cancelButtonTitle:nil
                     otherButtonTitles:@"Ok", nil];
    
    if (![self validateInputInView:self.view]){
        
        [alertView setMessage:@"Invalid information please review and try again!"];
        [alertView setTitle:@"Login Failed"];
    }
    else
    {
        [self processFieldEntries];
    }
    
    [alertView show];
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

- (void)processFieldEntries {
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
		goto showDialog;
	}
	
	// We have non-zero strings.
	// Check for equal password strings.
	if ([password compare:passwordAgain] != NSOrderedSame) {
		textError = YES;
		errorText = [errorText stringByAppendingString:passwordMismatchText];
		[passwordField becomeFirstResponder];
		goto showDialog;
	}
    
showDialog:
	if (textError) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorText message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
		[alertView show];
		return;
	}
    
	// Everything looks good; try to log in.
	// Disable the done button for now.
	doneButton.enabled = NO;
	PAWActivityView *activityView = [[PAWActivityView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height)];
	UILabel *label = activityView.label;
	label.text = @"Signing You Up";
	label.font = [UIFont boldSystemFontOfSize:20.f];
	[activityView.activityIndicator startAnimating];
	[activityView layoutSubviews];
    
	[self.view addSubview:activityView];
    
	// Call into an object somewhere that has code for setting up a user.
	// The app delegate cares about this, but so do a lot of other objects.
	// For now, do this inline.
    
	PFUser *user = [PFUser user];
	user.username = username;
	user.password = password;
	[user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
		if (error) {
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[error userInfo] objectForKey:@"error"] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
			[alertView show];
			doneButton.enabled = [self shouldEnableDoneButton];
			[activityView.activityIndicator stopAnimating];
			[activityView removeFromSuperview];
			// Bring the keyboard back up, because they'll probably need to change something.
			[usernameField becomeFirstResponder];
			return;
		}
        
		// Success!
		[activityView.activityIndicator stopAnimating];
		[activityView removeFromSuperview];
        
        ZMEntityManager *entityManager = [ZMEntityManager sharedInstance];
        
        [entityManager storeUser:user.username andPassword:user.password];
        
//		PAWWallViewController *wallViewController = [[PAWWallViewController alloc] initWithNibName:nil bundle:nil];
//		[(UINavigationController *)self.presentingViewController pushViewController:wallViewController animated:NO];
		[self.presentingViewController dismissViewControllerAnimated:YES completion:^{
            
        }];
	}];

}
@end
