//
//  AppDelegate.m
//  Ruble
//
//  Created by Vitaly Berg on 17/12/14.
//  Copyright (c) 2014 Vitaly Berg. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <Flurry.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[CrashlyticsKit]];
    [Flurry startSession:@"4X4XYKN8K8ZPD5P3PGDM"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    self.window.rootViewController = mainVC;
    
    return YES;
}

@end
