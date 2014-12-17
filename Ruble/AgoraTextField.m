//
//  AgoraTextField.m
//  rocketbank
//
//  Created by Vitaly Berg on 22/04/14.
//  Copyright (c) 2014 RocketBank. All rights reserved.
//

#import "AgoraTextField.h"

#import "UIFont+Agora.h"

@implementation AgoraTextField

- (CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect rect = [super caretRectForPosition:position];
    rect.origin.y -= ceil(rect.size.height * 0.05);
    return rect;
}

- (void)setFont:(UIFont *)font {
    [super setFont:[font agoraFont]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.font = self.font;
}

@end
