//
//  AppDelegate.m
//  justademo
//
//  Created by admin on 2019/1/7.
//  Copyright © 2019 allyes. All rights reserved.
//

#import "AppDelegate.h"
#import "SingSound/SSOralEvaluatingManager.h"
#import "ServiceManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[ServiceManager shareManager]registerHTTPDNS];
    
    __weak typeof(self)wself = self;
#ifdef DEBUG
    [[ServiceManager shareManager]getServiceAddressWithAppkey:@"t410" callback:^(NSString *serviceAddress) {
        NSLog(@"获取到的地址%@",serviceAddress);
        [wself registerEngineWithService:serviceAddress];
    }];
#else
    [[ServiceManager shareManager]getServiceAddressWithAppkey:@"a410" callback:^(NSString *serviceAddress) {
        NSLog(@"获取到的地址%@",serviceAddress);
        [wself registerEngineWithService:serviceAddress];
#endif

    return YES;
}

-(void)registerEngineWithService:(NSString *)service
{
    SSOralEvaluatingManagerConfig *config = [[SSOralEvaluatingManagerConfig alloc]init];
#ifdef DEBUG
    config.appKey = @"t410";
    config.secretKey = @"1a16f31f2611bf32fb7b3fc38f5b2c73";
#else
    config.appKey = @"a410";
    config.secretKey = @"c11163aa6c834a028da4a4b30955be91";
    
#endif

    //    config.vad = YES;
    //    config.frontTime = 3;
    //    config.backTime = 2;
    [config setValue:service forKey:@"service"];
    [SSOralEvaluatingManager registerEvaluatingManagerConfig:config];
    [[SSOralEvaluatingManager shareManager]registerEvaluatingType:OralEvaluatingTypeLine];
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 进入后台调用的方法
 */
- (void)applicationWillResignActive:(UIApplication *)application {
    //注册通知记录当前方法
    [[NSNotificationCenter defaultCenter] postNotificationName:@"程序进入后台" object:nil];
}

/**
 进入前台的方法
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    //注通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"程序进入前台" object:nil];
    
}



@end
