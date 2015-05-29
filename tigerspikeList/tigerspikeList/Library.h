//
//  Library.h
//  tigerspikeList
//
//  Created by Paulo Pão on 29/05/15.
//  Copyright (c) 2015 Paulo Pão. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Article.h"

@interface Library : NSObject

+ (Library *)sharedInstance;
- (void)loadArticles;
- (NSArray *)getArticles;
- (void)addArticle:(Article *)article atIndex:(int)index;

@end
