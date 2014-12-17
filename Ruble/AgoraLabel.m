//
//  AgoraLabel.m
//  rocketbank
//
//  Created by Vitaly Berg on 21/03/14.
//  Copyright (c) 2014 RocketBank. All rights reserved.
//

#import "AgoraLabel.h"

#import "UIFont+Agora.h"

@implementation AgoraLabel

- (void)setFont:(UIFont *)font {
    [super setFont:[font agoraFont]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.font = self.font;
}

@end
