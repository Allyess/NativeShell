//
//  JsApiTest.h
//  dspider
//
//  Created by 杜文 on 16/12/30.
//  Copyright © 2016年 杜文. All rights reserved.
//
#import "WebViewController.h"

#import <Foundation/Foundation.h>
#import "dsbridge.h"

@class WebViewController;
@interface JsApiTest : NSObject
@property(nonatomic, weak) WebViewController *vc;
+ (void)printDebug:(NSString *)method _:(NSDictionary *)params;

@end
