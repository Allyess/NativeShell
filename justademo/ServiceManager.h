//
//  ServiceManager.h
//  demo
//
//  Created by sing on 2018/1/18.
//  Copyright © 2018年 singsound. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ServiceAddressCallback)(NSString *serviceAddress);

@interface ServiceManager : NSObject
+ (instancetype)shareManager;


/**
 注册阿里云httpdns，应用启动的时候调用。
 */
-(void)registerHTTPDNS;

/**
 获取可用服务器地址

 @param appKey 对应的appKey
 @param callback  返回对应的serviceAddress 拿着这个地址 设为评测引擎初始化的服务器地址
 */
-(void)getServiceAddressWithAppkey:(NSString *)appKey callback:(ServiceAddressCallback)callback;



@end
