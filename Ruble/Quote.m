//
//  Quote.m
//  Ruble
//
//  Created by Vitaly Berg on 18/12/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "Quote.h"

@implementation Quote

- (instancetype)initWithJSON:(id)json {
    self = [super init];
    if (self) {
        _who = json[@"who"];
        _job = json[@"job"];
        _text = json[@"quote"];
    }
    return self;
}

+ (NSArray *)quotesWithJSON:(id)json {
    NSMutableArray *items = [NSMutableArray array];
    for (id jsonItem in json) {
        id item = [[self alloc] initWithJSON:jsonItem];
        if (item) {
            [items addObject:item];
        }
    }
    return items;
}

@end
