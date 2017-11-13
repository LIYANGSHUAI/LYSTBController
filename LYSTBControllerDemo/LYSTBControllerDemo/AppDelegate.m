//
//  AppDelegate.m
//  LYSTBControllerDemo
//
//  Created by HENAN on 2017/11/13.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "AppDelegate.h"
#import "LYSTBController.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    ViewController *vc1 = [[ViewController alloc] init];
    vc1.navigationItem.title = @"首页";
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    
    ViewController *vc2 = [[ViewController alloc] init];
    vc2.navigationItem.title = @"商店";
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    
    ViewController *vc3 = [[ViewController alloc] init];
    vc3.navigationItem.title = @"附近";
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    
    ViewController *vc4 = [[ViewController alloc] init];
    vc4.navigationItem.title = @"商店";
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    
    ViewController *vc5 = [[ViewController alloc] init];
    vc5.navigationItem.title = @"附近";
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    
    ViewController *vc6 = [[ViewController alloc] init];
    vc6.navigationItem.title = @"我的";
    UINavigationController *nav6 = [[UINavigationController alloc] initWithRootViewController:vc6];
    
    LYSTBBarItem *item1 = [[LYSTBBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"home_default"]];
    LYSTBBarItem *item2 = [[LYSTBBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"home_default"]];
    LYSTBBarItem *item3 = [[LYSTBBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"home_default"]];
    LYSTBBarItem *item4 = [[LYSTBBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"home_default"]];
    LYSTBBarItem *item5 = [[LYSTBBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"home_default"]];
    LYSTBBarItem *item6 = [[LYSTBBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"home_default"]];
    
    
    LYSTabBarView *barView = [[LYSTabBarView alloc] init];
    
    barView.tabBarItems = @[item1,item2,item3,item4,item5,item6];
    
    LYSTBController *vc = [[LYSTBController alloc] initWithTabBarView:barView];
    
    vc.viewControllerAry = @[nav1,nav2,nav3,nav4,nav5,nav6];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
