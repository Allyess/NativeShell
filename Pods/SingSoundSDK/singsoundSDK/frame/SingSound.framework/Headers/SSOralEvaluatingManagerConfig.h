//
//  SSOralEvaluatingManagerConfig.h
//  SingSound
//
//  Created by sing on 17/2/14.
//  Copyright © 2017年 sing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, offLineSource) {
    enSource         = 0,     //英文离线资源
    cnSource,             //中文离线资源
    allSource,            //默认，中文+英文
};

@interface SSOralEvaluatingManagerConfig : NSObject

/**
 appkey
 */
@property (nonatomic, copy) NSString *appKey;

/**
 secretKey
 */
@property (nonatomic, copy) NSString *secretKey;

/**
 服务器超时时间 default is 60s
 */
@property (nonatomic, assign) NSTimeInterval serverTimeout;

/**
 连接超时时间 default is 20s
 */
@property (nonatomic, assign) NSTimeInterval connectTimeout;

/**
 开启关闭vad,default is NO
 */
@property (nonatomic, assign) BOOL vad;

/**
 vad 前置超时时间
 */
@property (nonatomic, assign) NSTimeInterval frontTime;


/**
 vad 后置超时时间
 
 */
@property (nonatomic, assign) NSTimeInterval backTime;

/**
 logPath log信息路径默认为nil
 */
@property (nonatomic, strong) NSString *logPath;

/**
 logLevel log信息级别，可传@1,@2,@3,@4
 */
@property (nonatomic, strong) NSNumber *logLevel;

/**
 offLineSource 离线资源类型 0表示英文资源 1表示只中文资源 2中文和英文 默认0英文
 */
@property (nonatomic,assign) NSInteger offLineSource;







/**
 是否打印log，并在本地记录报错日志（日志路径 ~/Documents/SSError）
 */
@property (nonatomic,assign) BOOL isOutputLog;

/**
 允许使用动态服务器配置，设为YES时，无需手动配置服务器地址，将会自动从服务器获取可用地址。
 */
@property (nonatomic,assign)BOOL allowDynamicService;


@end
