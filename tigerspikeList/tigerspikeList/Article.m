//
//  Article.m
//  tigerspikeList
//
//  Created by Paulo Pão on 29/05/15.
//  Copyright (c) 2015 Paulo Pão. All rights reserved.
//

#import "Article.h"

@implementation Article

- (id)initWithTitle:(NSString *)title description:(NSString *)description url:(NSString *)url image:(NSString *)image{
    
    self = [super init];
    if (self) {
        _aTitle = title;
        _aDescription = description;
        _aUrl = url;
        _aImage = image;
    }
    return self;
    
}

@end
