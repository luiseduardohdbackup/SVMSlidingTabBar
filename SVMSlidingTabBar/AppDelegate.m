//
//  AppDelegate.m
//  SVMSlidingTabBar
//
//  Created by staticVoidMan on 20/01/14.
//  Copyright (c) 2014 svmLogics. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.vcObj = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [self.window setRootViewController:self.vcObj];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
