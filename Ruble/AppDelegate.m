//
//  AppDelegate.m
//  Ruble
//
//  Created by Vitaly Berg on 17/12/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "AppDelegate.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[CrashlyticsKit]];
    
    return YES;
}

@end
