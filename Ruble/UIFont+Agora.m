//
//  UIFont+Agora.m
//  rocketbank
//
//  Created by Vitaly Berg on 10/04/14.
//  Copyright (c) 2014 RocketBank. All rights reserved.
//

#import "UIFont+Agora.h"

@implementation UIFont (Agora)

+ (UIFont *)agoraBoldFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"PFAgoraSansPro-Bold" size:size];
}

+ (UIFont *)agoraMediumFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"PFAgoraSansPro-Medium" size:size];
}

+ (UIFont *)agoraRegularFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"PFAgoraSansPro-Regular" size:size];
}

+ (UIFont *)agoraLightFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"PFAgoraSansPro-Light" size:size];
}

+ (UIFont *)agoraThinFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"PFAgoraSansPro-Thin" size:size];
}

+ (UIFont *)agoraXThinFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"PFAgoraSansPro-XThin" size:size];
}

+ (UIFont *)agoraFontFromFont:(UIFont *)font {
    NSString *name = [self agoraFontNameFromFontName:font.fontName];
    return [UIFont fontWithName:name size:font.pointSize];
}

+ (NSString *)agoraFontNameFromFontName:(NSString *)fontName {
    NSString *agoraFontName = @"PFAgoraSansPro-Regular";
    
    NSRange styleDelimeterRange = [fontName rangeOfString:@"-" options:NSBackwardsSearch];
    if (styleDelimeterRange.length > 0) {
        NSString *style = [fontName substringFromIndex:(styleDelimeterRange.location + 1)];
        NSString *fontName = [self agoraFontMap][[style lowercaseString]];
        if (fontName) {
            agoraFontName = fontName;
        }
    }
    
    return agoraFontName;
}

+ (NSDictionary *)agoraFontMap {
    static id map = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        map = @{
                @"": @"PFAgoraSansPro-Regular",
                @"xthin": @"PFAgoraSansPro-XThin",
                @"ultrathin": @"PFAgoraSansPro-XThin",
                @"extrathin": @"PFAgoraSansPro-XThin",
                @"thin": @"PFAgoraSansPro-Thin",
                @"ultralight": @"PFAgoraSansPro-XThin",
                @"extralight": @"PFAgoraSansPro-XThin",
                @"light": @"PFAgoraSansPro-Light",
                @"regular": @"PFAgoraSansPro-Regular",
                @"medium": @"PFAgoraSansPro-Medium",
                @"bold": @"PFAgoraSansPro-Bold",
                @"extrabold": @"PFAgoraSansPro-Bold",
                };
    });
    return map;
}

- (UIFont *)agoraFont {
    return [UIFont agoraFontFromFont:self];
}

@end
