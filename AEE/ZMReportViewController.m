//
//  ZMReportViewController.m
//  AEE
//
//  Created by Milton D. Mitjans on 1/1/14.
//  Copyright (c) 2014 Milton D. Mitjans. All rights reserved.
//

#import "ZMReportViewController.h"

@interface ZMReportViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ZMReportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource: @"config" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];

    NSString *html = [dict objectForKey: @"html"];
    
    [self loadURL:html];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * A convenient method to load a given URL in the web view
 * and also set the object to share.
 */
- (void)loadURL:(NSString*)html
{
    
    NSURLRequest *request =
        [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://webapps.prepa.com/pls/web/f?p=107:1:1535769493790800"]];
    [self.webView loadRequest:request];
    //[self.webView loadHTMLString:html
    //                     baseURL:[NSURL URLWithString:@"https://webapps.prepa.com/pls/web/f?p=107:1:1535769493790800"]];
}

#pragma mark
#pragma mark - UIWebView delegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    UIWebViewNavigationType navType = navigationType;
    

    return YES;
}

- (void)displayActivityView
{
}

/*
 * Hide the activity view and turn off the network activity
 * indicator in the status bar.
 */
- (void)hideActivityView
{}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self displayActivityView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideActivityView];
    
    NSString *script = @"document.body";
    NSString *output = [self.webView stringByEvaluatingJavaScriptFromString:script];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:error.localizedDescription
                                                   delegate:nil
                                          cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles:nil];
    [alert show];
    [self hideActivityView];
}


@end
