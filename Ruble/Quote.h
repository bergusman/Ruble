//
//  Quote.h
//  Ruble
//
//  Created by Vitaly Berg on 18/12/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quote : NSObject

@property (strong, nonatomic) NSString *who;
@property (strong, nonatomic) NSString *job;
@property (strong, nonatomic) NSString *text;

- (instancetype)initWithJSON:(id)json;

+ (NSArray *)quotesWithJSON:(id)json;

@end
