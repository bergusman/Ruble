//
//  Quotes.h
//  Ruble
//
//  Created by Vitaly Berg on 18/12/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Quote.h"

@interface Quotes : NSObject

@property (strong, nonatomic, readonly) NSArray *quotes;

- (Quote *)randomQuote;

+ (instancetype)quotesFromJSONWithName:(NSString *)name;

@end
