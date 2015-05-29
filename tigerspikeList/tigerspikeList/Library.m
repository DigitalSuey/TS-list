//
//  Library.m
//  tigerspikeList
//
//  Created by Paulo Pão on 29/05/15.
//  Copyright (c) 2015 Paulo Pão. All rights reserved.
//

#import "Library.h"
#import "PersistenceManager.h"
#import "TigerSpikeClient.h"

@interface Library () {
    
    PersistenceManager *persistenceManager;
    TigerSpikeClient *client;
    
}

@end

@implementation Library

+ (Library *)sharedInstance{
    
    static Library *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[Library alloc] init];
    });
    return _sharedInstance;
    
}

- (id)init{
    
    self = [super init];
    if (self) {
        persistenceManager = [[PersistenceManager alloc] init];
        client = [[TigerSpikeClient alloc] init];
    }
    return self;
    
}

- (void)loadArticles{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadedArticles:) name:@"loadSuccess" object:nil];
    [client getArticles];
    
}

- (void)loadedArticles:(NSNotification *)notification{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSArray *responseArticles = [notification.userInfo objectForKey:@"solutions"];
    NSLog(@"%@", responseArticles);
    
    for (int i = 0; i < [responseArticles count]; i++) {
        [self addArticle:[[Article alloc] initWithTitle:[responseArticles[i] valueForKey:@"name"] description:[responseArticles[i] valueForKey:@"description"] url:[responseArticles[i] valueForKey:@"url"] image:[responseArticles[i] valueForKey:@"icon"]] atIndex:i];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadEnded" object:self];
}

- (NSArray *)getArticles{
    
    return [persistenceManager getArticles];
    
}

- (void)addArticle:(Article *)article atIndex:(int)index{
    
    [persistenceManager addArticle:article atIndex:index];
    
}


@end
