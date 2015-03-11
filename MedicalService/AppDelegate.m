//
//  AppDelegate.m
//  MedicalService
//
//  Created by 张琼芳 on 13-8-5.
//  Copyright (c) 2013年 www.fenghuait.cn  镇江风华信息科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "rootVC.h"

#import "AWVersionAgent.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.connectionTimer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.connectionTimer forMode:NSDefaultRunLoopMode];
    do{
        [[NSRunLoop currentRunLoop]runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    }while (!done);
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    // Override point for customization after application launch.
    
    _rootView = [[rootVC alloc] initWithNibNameSupportIPhone5AndIPad:@"rootVC"];
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:_rootView];
    
    self.window.rootViewController = navigation;
    
    [[AWVersionAgent sharedAgent] setDebug:YES];
    [[AWVersionAgent sharedAgent] checkNewVersionForApp:@"700322811"];
    
    [self.window addSubview:navigation.view];
    
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)timerFired:(NSTimer *)timer{
    done=YES;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
