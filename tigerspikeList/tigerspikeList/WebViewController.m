//
//  WebViewController.m
//  tigerspikeList
//
//  Created by Paulo Pão on 10/05/15.
//  Copyright (c) 2015 Paulo Pão. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.delegate = self;
    
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
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"STARTED LOADING");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"FINISHED LOADING");
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
