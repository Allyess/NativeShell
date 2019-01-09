//
//  WebViewController.h
//  justademo
//
//  Created by admin on 2019/1/7.
//  Copyright © 2019 allyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dsbridge.h"

NS_ASSUME_NONNULL_BEGIN

@class JsApiTest;
@interface WebViewController : UIViewController <WKNavigationDelegate>
{
    JsApiTest *jsApi;
}
@property (nonatomic,copy) NSString* URLString;
@property(nonatomic, strong) DWKWebView *webView;

- (void)hideLeftNavItem;


- (void)showLeftNavItem;
@end

NS_ASSUME_NONNULL_END
