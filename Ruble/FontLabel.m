//
//  FontLabel.m
//  Hackie
//
//  Created by Vitaly Berg on 15/12/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "FontLabel.h"

@implementation FontLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.fontName) {
        UIFont *font = [UIFont fontWithName:self.fontName size:self.fontSize];
        self.font = font;
    }
}

@end
