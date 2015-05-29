//
//  TigerSpikeClient.m
//  tigerspikeList
//
//  Created by Paulo Pão on 21/05/15.
//  Copyright (c) 2015 Paulo Pão. All rights reserved.
//

#import "TigerSpikeClient.h"

@implementation TigerSpikeClient

static NSString *const endpoint = @"https://api.myjson.com/bins/1quht";

- (void)getArticles{
    
    NSURL *url = [NSURL URLWithString:endpoint];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            if (error) {
                
                NSLog(@"Failed to load JSON");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loadFailure" object:self];
                
            } else {
                
                NSLog(@"Successfully loaded JSON");
                NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"loadSuccess" object:self userInfo:dictionary];
                
            }
        }];
    });
}

@end
