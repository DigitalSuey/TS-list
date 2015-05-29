//
//  PersistenceManager.h
//  tigerspikeList
//
//  Created by Paulo Pão on 21/05/15.
//  Copyright (c) 2015 Paulo Pão. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Article.h"

@interface PersistenceManager : NSObject{
    
    NSMutableArray *articles;
    
}

- (NSArray*)getArticles;
- (void)addArticle:(Article *)article atIndex:(int)index;

@end
