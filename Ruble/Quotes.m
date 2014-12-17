//
//  Quotes.m
//  Ruble
//
//  Created by Vitaly Berg on 18/12/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "Quotes.h"

@interface Quotes ()

@property (strong, nonatomic, readwrite) NSArray *quotes;

@end

@implementation Quotes

- (Quote *)randomQuote {
    return self.quotes[arc4random() % self.quotes.count];
}

+ (instancetype)quotesFromJSONWithName:(NSString *)name {
    NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:nil];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (!data) {
        return nil;
    }
    
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if (!json) {
        return nil;
    }
    
    NSArray *quotes = [Quote quotesWithJSON:json];
    if (!quotes) {
        return nil;
    }

    Quotes *q = [[Quotes alloc] init];
    q.quotes = quotes;
    return q;
}

@end
