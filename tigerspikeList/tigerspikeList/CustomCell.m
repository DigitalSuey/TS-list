//
//  CustomCell.m
//  tigerspikeList
//
//  Created by Paulo Pão on 10/05/15.
//  Copyright (c) 2015 Paulo Pão. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateLabelConstraints{
    
    [self.titleLeftConstraint setConstant:0];
    [self.descriptionLeftConstraint setConstant:0];
    
}

- (void)maintainLabelConstraints{
    
    [self.titleLeftConstraint setConstant:98];
    [self.descriptionLeftConstraint setConstant:98];
    
}

@end
