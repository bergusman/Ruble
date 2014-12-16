//
//  PlayerLayerView.m
//  Ruble
//
//  Created by Vitaly Berg on 17/12/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "PlayerLayerView.h"

#import <AVFoundation/AVFoundation.h>

@implementation PlayerLayerView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

@end
