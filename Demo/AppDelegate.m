//
//  AppDelegate.m
//  Demo
//
//  Created by Yuki on 2020/6/19.
//  Copyright © 2020 Zl. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    manager.enableAutoToolbar = NO;
    manager.keyboardDistanceFromTextField = 40.0f;
    
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[HomeController alloc]init]];
    [self.window makeKeyAndVisible];
    return YES;
}



@end
