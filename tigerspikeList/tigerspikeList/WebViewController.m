//
//  WebViewController.m
//  tigerspikeList
//
//  Created by Paulo Pão on 10/05/15.
//  Copyright (c) 2015 Paulo Pão. All rights reserved.
//

#import "WebViewController.h"
// Used MBProgressHUD class from https://github.com/jdg/MBProgressHUD
// It is a load progress monitoring class that is very easily integrated and displays something is in progress
// In this case it was used to "10) Provide feedback to the user when performing any network request."
#import "MBProgressHUD.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.delegate = self;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIWebViewDelegate

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"ERROR LOADING: %@", error);
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"STARTED LOADING");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"FINISHED LOADING");
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
