//
//  AgoraButton.m
//  rocketbank
//
//  Created by Vitaly Berg on 21/03/14.
//  Copyright (c) 2014 RocketBank. All rights reserved.
//

#import "AgoraButton.h"

#import "UIFont+Agora.h"

@implementation AgoraButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [self.titleLabel.font agoraFont];
}

@end
