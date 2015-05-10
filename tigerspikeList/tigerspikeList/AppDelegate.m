//
//  AppDelegate.m
//  tigerspikeList
//
//  Created by Paulo Pão on 10/05/15.
//  Copyright (c) 2015 Paulo Pão. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSURL *url = [NSURL URLWithString:@"https://api.myjson.com/bins/1quht"];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            NSLog(@"Failed to load json");
        } else {
            
            NSMutableArray *list = [[NSMutableArray alloc] init];
            NSMutableDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            list = responseDict[@"solutions"];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
            NSString *bundlePath = [paths objectAtIndex:0];
            NSString *plistPath = [bundlePath stringByAppendingPathComponent:@"list.plist"];
            NSFileManager *manager = [NSFileManager defaultManager];
            
            if (![manager fileExistsAtPath:plistPath]){
                // Doesn't exist, write list to the plist
                [list writeToFile:plistPath atomically:YES];
            } else {
                // List plist exists, delete it and write the new one
                [manager removeItemAtPath:plistPath error:&error];
                [list writeToFile:plistPath atomically:YES];
            }
            
        }
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
