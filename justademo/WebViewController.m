//
//  WebViewController.m
//  justademo
//
//  Created by admin on 2019/1/7.
//  Copyright © 2019 allyes. All rights reserved.
//


#define zrgba(x, y, z, w) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:w/1.0]

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "JsEchoApi.h"
#import "justademo-Swift.h"
#import "JsApiTest.h"

@interface WebViewController ()<UIGestureRecognizerDelegate>

@end

@implementation WebViewController

//Lazy

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        
        CGFloat offset = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
        if (self.navigationController.navigationBar.hidden) {
            offset = 0;
        }
        _progressView.frame = CGRectMake(0,offset, [UIScreen mainScreen].bounds.size.width, 5);
        [_progressView setTrackTintColor:zrgba(0,106,255,1)];
        _progressView.progressTintColor = zrgba(0,106,255,1);
        
        [self.view addSubview:_progressView];
        [self.view bringSubviewToFront:_progressView];
    }
    return _progressView;
}

- (void)updateProgressViewFrame{
    CGFloat offset = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    if (self.navigationController.navigationBar.hidden) {
        offset = 0;
        self.webView.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }else{
        self.webView.frame=CGRectMake(0, 25, self.view.bounds.size.width, self.view.bounds.size.height-25);
    }
    self.progressView.frame = CGRectMake(0,offset, [UIScreen mainScreen].bounds.size.width, 5);
    

}


//MARK: life cycle

-(void)dealloc{
    
    @try {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
 

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 在这里修改链接路径
    self.URLString = @"https://yuwenweb.xugaoyang.com/lesson-one/#/";
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self cleanCache];
    
    /* backBarButtonItem */
    UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_back"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemOnclick:)];
    customLeftBarButtonItem.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = customLeftBarButtonItem;
  
    
    
    if (!_URLString) {
        self.title = @"test";
    }else{
        self.title = _URLString;
    }
    [self creatTestWebView];

   
}




- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    [self.webView hasJavascriptMethod:@"NATIVE_VIEW_DID_APPEAR" methodExistCallback:^(bool exist) {
        if(exist) {
            [self.webView callHandler:@"NATIVE_VIEW_DID_APPEAR" arguments:NULL];
        }
    }];
    
    
    //后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appGoBackgroudNotification) name:@"程序进入后台" object:nil];
    //前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appGoForegroudNotification) name:@"程序进入前台" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [self.webView hasJavascriptMethod:@"NATIVE_VIEW_DID_DISAPPEAR" methodExistCallback:^(bool exist) {
        if(exist) {
            [self.webView callHandler:@"NATIVE_VIEW_DID_DISAPPEAR" arguments:NULL];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"程序进入后台" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"程序进入前台" object:nil];
}



//MARK: handle acticons
- (void)leftBarButtonItemOnclick:(id)sender
{
    [self.webView evaluateJavaScript:@"window.dsBridge.default" completionHandler:^(id _Nullable value, NSError * _Nullable error) {
        if(!!value) {
            
            [self.webView hasJavascriptMethod:@"DDWEBVIEW_NAV_BACK" methodExistCallback:^(bool exist) {
                
                if(exist) {
                    [self.webView callHandler:@"DDWEBVIEW_NAV_BACK" completionHandler:^(id  _Nullable value) {
                        
                        if(![value boolValue]) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }];
                }else {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}


- (void)hideLeftNavItem
{
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setHidesBackButton:YES];
}


- (void)showLeftNavItem
{
    if(self.navigationItem.leftBarButtonItem) {
        return;
    }
    [self.navigationItem setHidesBackButton:NO];
    UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_back"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemOnclick:)];
    customLeftBarButtonItem.tintColor = [UIColor blackColor];

    self.navigationItem.leftBarButtonItem = customLeftBarButtonItem;
}

//MARK: ui

- (void)creatTestWebView{
    CGRect bounds=self.view.bounds;
    DWKWebView * dwebview=[[DWKWebView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height)];
    [self.view addSubview:dwebview];
    self.webView = dwebview;
    
    dwebview.navigationDelegate=self;

    JsApiTest * testss = [[JsApiTest alloc]init];
    testss.vc = self;
    // register api object without namespace
    [dwebview addJavascriptObject:testss namespace:nil];
    
    // register api object without namespace
    [dwebview addJavascriptObject:[[ JsApiTestSwift alloc] init] namespace:@"swift"];
    
    // register api object with namespace "echo"
    [dwebview addJavascriptObject:[[JsEchoApi alloc] init] namespace:@"echo"];
    
    // open debug mode, Release mode should disable this.
#ifdef DEBUG
    [dwebview setDebugMode:true];
#else
    [dwebview setDebugMode:false];

#endif

    if (self.URLString) {
        [self setProductWebView:dwebview];
    }else{
        [self setTestWebView:dwebview];
    }

    [self.webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];

    
}

- (void)setProductWebView:(DWKWebView *)dwebview{
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:self.URLString]];
    NSLog(@"\n====== WebView ======\nopen webView %@\n====== END ======", request.URL);
    [dwebview loadRequest:request];
}


- (void)setTestWebView:(DWKWebView *)dwebview{
    
    [dwebview customJavascriptDialogLabelTitles:@{@"alertTitle":@"Notification",@"alertBtn":@"OK"}];
    
    
    // load test.html
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"test"
                                                          ofType:@"html"];
    NSString * htmlContent = [NSString stringWithContentsOfFile:htmlPath
                                                       encoding:NSUTF8StringEncoding
                                                          error:nil];
    [dwebview loadHTMLString:htmlContent baseURL:baseURL];
    
    // call javascript method
    [dwebview callHandler:@"addValue" arguments:@[@3,@4] completionHandler:^(NSNumber * value){
        NSLog(@"%@",value);
    }];
    
    [dwebview callHandler:@"append" arguments:@[@"I",@"love",@"you"] completionHandler:^(NSString * _Nullable value) {
        NSLog(@"call succeed, append string is: %@",value);
    }];
    
    // this invocation will be return 5 times
    [dwebview callHandler:@"startTimer" completionHandler:^(NSNumber * _Nullable value) {
        NSLog(@"Timer: %@",value);
    }];
    
    // namespace syn test
    [dwebview callHandler:@"syn.addValue" arguments:@[@5,@6] completionHandler:^(NSDictionary * _Nullable value) {
        NSLog(@"Namespace syn.addValue(5,6): %@",value);
    }];
    
    [dwebview callHandler:@"syn.getInfo" completionHandler:^(NSDictionary * _Nullable value) {
        NSLog(@"Namespace syn.getInfo: %@",value);
    }];
    
    // namespace asyn test
    [dwebview callHandler:@"asyn.addValue" arguments:@[@5,@6] completionHandler:^(NSDictionary * _Nullable value) {
        NSLog(@"Namespace asyn.addValue(5,6): %@",value);
    }];
    
    [dwebview callHandler:@"asyn.getInfo" completionHandler:^(NSDictionary * _Nullable value) {
        NSLog(@"Namespace asyn.getInfo: %@",value);
    }];
    
    // test if javascript method exists.
    [dwebview hasJavascriptMethod:@"addValue" methodExistCallback:^(bool exist) {
        NSLog(@"method 'addValue' exist : %d",exist);
    }];
    
    [dwebview hasJavascriptMethod:@"XX" methodExistCallback:^(bool exist) {
        NSLog(@"method 'XX' exist : %d",exist);
    }];
    
    [dwebview hasJavascriptMethod:@"asyn.addValue" methodExistCallback:^(bool exist) {
        NSLog(@"method 'asyn.addValue' exist : %d",exist);
    }];
    
    [dwebview hasJavascriptMethod:@"asyn.XX" methodExistCallback:^(bool exist) {
        NSLog(@"method 'asyn.XX' exist : %d",exist);
    }];
    
    // set javascript close listener
    [dwebview setJavascriptCloseWindowListener:^{
        NSLog(@"window.close called");
    } ];
}


//MARK: logic

- (void)appGoBackgroudNotification
{
    [self.webView hasJavascriptMethod:@"NATIVE_APP_GO_BACKGROUND" methodExistCallback:^(bool exist) {
        if(exist) {
            [self.webView callHandler:@"NATIVE_APP_GO_BACKGROUND" arguments:NULL];
        }
    }];
}

- (void)appGoForegroudNotification
{
    [self.webView hasJavascriptMethod:@"NATIVE_APP_GO_FOREGROUND" methodExistCallback:^(bool exist) {
        if(exist) {
            [self.webView callHandler:@"NATIVE_APP_GO_FOREGROUND" arguments:NULL];
        }
    }];
}




- (void)cleanCache{
    double systemVersion =[[[UIDevice currentDevice] systemVersion] doubleValue];
    
    
    
    if (systemVersion >= 9.0) {
        NSSet *websiteDataTypes
        
        = [NSSet setWithArray:@[
                                
                                WKWebsiteDataTypeDiskCache,
                                
                                //WKWebsiteDataTypeOfflineWebApplicationCache,
                                
                                WKWebsiteDataTypeMemoryCache,
                                
                                WKWebsiteDataTypeLocalStorage,
                                
                                WKWebsiteDataTypeCookies,
                                
                                WKWebsiteDataTypeSessionStorage,
                                
                                //WKWebsiteDataTypeIndexedDBDatabases,
                                
                                //WKWebsiteDataTypeWebSQLDatabases
                                
                                ]];
        
        //// Date from
        
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        
        //// Execute
        
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            
            // Done
            
        }];
        
    }else{
        NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                                   NSUserDomainMask, YES)[0];
        NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleIdentifier"];
        NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
        NSString *webKitFolderInCaches = [NSString
                                          stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
        NSString *webKitFolderInCachesfs = [NSString
                                            stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
        
        NSError *error;
        /* iOS8.0 WebView Cache的存放路径 */
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
        [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
        
        /* iOS7.0 WebView Cache的存放路径 */
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
        
    }
}



//MARK:kvo 监听进度
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                      context:(void *)context{
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]
        && object == self.webView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.webView.estimatedProgress animated:animated];
        
        if (self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        
        
    }
}
@end
