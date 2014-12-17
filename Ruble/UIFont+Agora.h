//
//  UIFont+Agora.h
//  rocketbank
//
//  Created by Vitaly Berg on 10/04/14.
//  Copyright (c) 2014 RocketBank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Agora)

+ (UIFont *)agoraBoldFontWithSize:(CGFloat)size;
+ (UIFont *)agoraMediumFontWithSize:(CGFloat)size;
+ (UIFont *)agoraRegularFontWithSize:(CGFloat)size;
+ (UIFont *)agoraLightFontWithSize:(CGFloat)size;
+ (UIFont *)agoraThinFontWithSize:(CGFloat)size;
+ (UIFont *)agoraXThinFontWithSize:(CGFloat)size;

+ (UIFont *)agoraFontFromFont:(UIFont *)font;
+ (NSString *)agoraFontNameFromFontName:(NSString *)fontName;

- (UIFont *)agoraFont;

@end
