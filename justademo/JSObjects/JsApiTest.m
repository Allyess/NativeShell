//
//  JsApiTest.m
//
//  Created by 杜文 on 16/12/30.
//  Copyright © 2016年 杜文. All rights reserved.
//

#import "JsApiTest.h"
#import "UIColor+Addition.h"
#import "AppDelegate.h"
#import "FCFileManager.h"
#import "SingSound/SSOralEvaluatingManager.h"
#import <AVFoundation/AVFoundation.h>
#import "ServiceManager.h"

#import "UIImage+Compress.h"
#import <MJExtension/MJExtension.h>

#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]
#define mAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)


@interface JsApiTest()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,SSOralEvaluatingManagerDelegate>
{
  NSTimer * timer ;
  void(^hanlder)(id value,BOOL isComplete);
  int value;
}
// cookies
@property(nonatomic, strong) NSMutableDictionary *cookieDict;

// navbars
@property(nonatomic, copy) void(^callbackBlock)(id, bool);

// photos
@property(nonatomic, copy) NSDictionary *imageoptionsDic;
@property(nonatomic, copy) void(^choseCallBack)(NSDictionary *);
@property(nonatomic, copy) void(^takePhotoCallBack)(NSDictionary *);

// record
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSString *currentTokenId;
@property(nonatomic, copy) void(^reinitCallBack)(NSDictionary *);


@end

@implementation JsApiTest

-(instancetype)init{
    if (self = [super init]) {
        //设置代理
        [SSOralEvaluatingManager shareManager].delegate = self;
        [SSOralEvaluatingManager clearAllRecord];//清理缓存的音频数据
    }
    return self;
}
//MARK: lazy
-(NSMutableDictionary *)cookieDict{
    if (!_cookieDict) {
        _cookieDict = [NSMutableDictionary dictionary];
        _cookieDict[@"tst"] = @"123";
    }
    return _cookieDict;
}
//MARK: test functions

- (NSString *) testSyn: (NSString *) msg
{
    return [msg stringByAppendingString:@"[ syn call]"];
}

- (void) testAsyn:(NSString *) msg :(JSCallback) completionHandler
{
    completionHandler([msg stringByAppendingString:@" [ asyn call]"],YES);
}

- (NSString *)testNoArgSyn:(NSDictionary *) args
{
    return  @"testNoArgSyn called [ syn call]";
}

- ( void )testNoArgAsyn:(NSDictionary *) args :(JSCallback)completionHandler
{
    completionHandler(@"testNoArgAsyn called [ asyn call]",YES);
}

- ( void )callProgress:(NSDictionary *) args :(JSCallback)completionHandler
{
    value=10;
    hanlder=completionHandler;
    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(onTimer:)
                                            userInfo:nil
                                             repeats:YES];
}

-(void)onTimer:t{
    if(value!=-1){
        hanlder([NSNumber numberWithInt:value--],NO);
    }else{
        hanlder(0,YES);
        [timer invalidate];
    }
}

/**
 * Note: This method is for Fly.js
 * In browser, Ajax requests are sent by browser, but Fly can
 * redirect requests to native, more about Fly see  https://github.com/wendux/fly
 * @param requestInfo passed by fly.js, more detail reference https://wendux.github.io/dist/#/doc/flyio-en/native
 */
-(void)onAjaxRequest:(NSDictionary *) requestInfo  :(JSCallback)completionHandler{
   
}


//MARK: Cookies & Persistence
- (NSString *)setNativeCookie:(NSDictionary *)dict
{
    [JsApiTest printDebug:@"setNativeCookie" _:dict];
    NSString *key = dict[@"key"];
    NSString *value = dict[@"value"];
    if(key && value && [value isKindOfClass:[NSString class]]) {
        self.cookieDict[key] = value;
    }
    return @"succeed";
}

- (NSString *)getNativeCookie:(NSString *)c_key
{
    [JsApiTest printDebug:@"getNativeCookie" _:@{@"key": c_key?:@""}];
    return self.cookieDict[c_key] ?: nil;
}

- (NSDictionary *)getNativeCookies:(NSString *)c_key
{
    [JsApiTest printDebug:@"getNativeCookies" _:@{@"key": c_key?:@""}];
    return self.cookieDict;
}

- (NSString *)setNativePersistence:(NSDictionary *)dict
{
    [JsApiTest printDebug:@"setNativePersistence" _:dict];
    
    NSString *key = dict[@"key"];
    NSString *value = dict[@"value"];
    
    if(key && [value isEqualToString:@""]) {
        [USER_DEFAULTS removeObjectForKey:[NSString stringWithFormat:@"__web%@", key]];
        return @"succeed";
    }
    if(key && value && [value isKindOfClass:[NSString class]]) {
        [USER_DEFAULTS setObject:value forKey:[NSString stringWithFormat:@"__web%@", key]];
    }
    return @"succeed";
}

- (NSString *)getNativePersistence:(NSString *)c_key
{
    [JsApiTest printDebug:@"getNativePersistence" _:@{@"key": c_key?:@""}];
    
    NSString* result = [USER_DEFAULTS objectForKey:[NSString stringWithFormat:@"__web%@", c_key]];
    return result;
}
//MARK: 导航栏相关
/**
 修改控制器标题
 */
- (NSString *)modifyNativeNavBarTitle:(NSDictionary *)titleDict
{
    [JsApiTest printDebug:@"modifyNativeNavBarTitle" _:titleDict];
    
    if([titleDict isKindOfClass:[NSDictionary class]]) {
        NSString *title = titleDict[@"title"];
        if(title.length) {
            self.vc.title = title;
        }
    }
    return @"succeed";
    
}

/**
 添加导航栏右侧按钮
 
 @param params params description
 //title: 标题title
 //color: 标题颜色
 @param callback  点击响应事件
 */
- (void)nativeAddNavRightItem:(NSDictionary *)params :(void(^)(void))callback
{
    [JsApiTest printDebug:@"nativeAddNavRightItem" _:params];
    
    NSString *title = params[@"title"];
    NSString *color = params[@"color"];
    
    
    self.callbackBlock = [callback copy];
    
    if(!title.length) { return; }
    if(!color.length) { color =@"#000033"; }
    
    
    UIButton *rightButtonItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButtonItem.frame = CGRectMake(0, 0, 70, 44);
    [rightButtonItem setAttributedTitle:
     [[NSAttributedString alloc] initWithString:title
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                                  NSForegroundColorAttributeName: [UIColor colorWithHexString:color]}] forState:UIControlStateNormal];
    [rightButtonItem addTarget:self action:@selector(didTapRightItem) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButtonItem];
    self.vc.navigationItem.rightBarButtonItem = rightItem;
}

- (void)didTapRightItem
{
    self.callbackBlock(@"", NO);
}

/**
 隐藏导航栏右侧按钮
 */
- (NSString *)nativeHideNavRightItem:(id)sender
{
    [JsApiTest printDebug:@"nativeHideNavRightItem" _:sender];
    
    self.vc.navigationItem.rightBarButtonItem = nil;
    return @"succeed";
}

/**
 隐藏导航栏
 */
- (NSString *)nativeHideNavBar:(id)sender
{
    [JsApiTest printDebug:@"nativeHideNavBar" _:sender];
    
    self.vc.navigationController.navigationBar.hidden = YES;
    [self.vc updateProgressViewFrame];
    return @"succeed";
}

/**
 显示导航栏
 */
- (NSString *)nativeShowNavBar:(id)sender
{
    [JsApiTest printDebug:@"nativeShowNavBar" _:sender];
    
    self.vc.navigationController.navigationBar.hidden = NO;
    [self.vc updateProgressViewFrame];

    return @"succeed";
}





//MARK: 界面跳转

/**
 跳转到根控制器
 */
- (NSString *)pushIndex:(id)sender
{
    [JsApiTest printDebug:@"pushIndex" _:sender];
    
    [self.vc.navigationController popToRootViewControllerAnimated:YES];
    return @"succeed";
}

/**
 关闭当前控制器
 
 @param sender sender description
 @return return value description
 */
- (NSString *)dissmissCurrentVc:(id)sender
{
    //    [JsApiTest printDebug:@"dissmissCurrentVc" _:sender];
    [self.vc.navigationController popViewControllerAnimated:YES];
    return @"succeed";
}











/**
 隐藏左侧按钮

 @param sender sender description
 @return return value description
 */
- (NSString *)hideNavLeftButton:(id)sender
{
    [JsApiTest printDebug:@"hideNavLeftButton" _:sender];
    
    [self.vc hideLeftNavItem];
    return @"succeed";
}

/**
 显示左侧按钮

 @param sender sender description
 @return return value description
 */
- (NSString *)showNavLeftButton:(id)sender
{
    [JsApiTest printDebug:@"showNavLeftButton" _:sender];
    
    [self.vc showLeftNavItem];
    return @"succeed";
}



- (NSString *)printInfoToNative:(NSDictionary *)dict
{
    NSLog(@"\n====== webView =======\n%@\n====== END =======", dict);
    return @"succeed";
}

+ (void)printDebug:(NSString *)method _:(NSDictionary *)params
{
    NSLog(@"\n====== webView =======\nMethod:\n-->%@\nParams:\n%@\n====== END =======",method ,params);
}



//MARK: 系统基础功能


/**
 唤起原生浏览器
 
 @param params {"tbUrl","value"}
 key: tbUrl value: url链接
 @return return value description
 */
- (NSString*)openURL:(NSDictionary*)params{
    [JsApiTest printDebug:@"openURL" _:params];
    
    NSString *str = [NSString stringWithFormat:@"%@", params[@"Url"]];
    if (str) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    return @"succeed";
}




/**
 打电话

 @param sender sender description
 @return return value description
 */
- (NSString *)callPhone:(NSDictionary *)sender
{
    [JsApiTest printDebug:@"callPhone" _:sender];
    NSString *phone = sender[@"phoneNum"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phone]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    return @"succeed";
}

/**
 打开相机
 
 @param params params description
 @param callback callback description
 */
- (void)openCamare:(NSDictionary *)params :(void(^)(NSDictionary*, BOOL))callback
{
    self.imageoptionsDic = params;
    self.choseCallBack = [callback copy];

    NSUInteger sourceType = 0;
    // 判断系统是否支持相机
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.delegate = self; //设置代理
        NSString *allowsEditing = params[@"allowsEditing"];
        imagePickerController.allowsEditing = [allowsEditing boolValue];
        imagePickerController.sourceType = sourceType; //图片来源
        
        //拍照
        sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.sourceType = sourceType;
        [self.vc presentViewController:imagePickerController animated:YES completion:nil];
    }else{
        if(self.choseCallBack) {
            self.choseCallBack(@{@"ErrCode":@"4",
                                 @"ErrDes":@"设备不支持相机"
                                 });
            self.choseCallBack = nil;
            
        }
    }
}

/**
 打开相册

 @param params params description
 @param callback callback description
 */
- (void)openGallery:(NSDictionary *)params :(void(^)(NSDictionary*, BOOL))callback
{
    self.imageoptionsDic = params;

    [JsApiTest printDebug:@"openGallery" _:params];
    
    self.choseCallBack = [callback copy];
    //1.弹出UIImagePickerController
    UIImagePickerController *imgControl = [[UIImagePickerController alloc] init];
    //2.设置代理
    imgControl.delegate = self;
    //3.是否允许编辑
    NSString *allowsEditing = params[@"allowsEditing"];
    imgControl.allowsEditing = [allowsEditing boolValue];
    //4.指定数据源类型
    imgControl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //6.弹出模态试图
    [self.vc presentViewController:imgControl animated:YES completion:nil];
}




/**
 *  成功获得相片还是视频后的回调
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    //获取媒体类型
    // 完成之后的取消方法
    [picker dismissViewControllerAnimated:NO completion:NULL];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:@"public.image"]) {
            // 获取的最新的image
            UIImage *image;
            if ([self.imageoptionsDic[@"allowsEditing"]boolValue]) {
              image  = [info objectForKey:UIImagePickerControllerEditedImage];

            }else{
                image  = [info objectForKey:UIImagePickerControllerOriginalImage];
            }
            
            NSString *compressScale = self.imageoptionsDic[@"compressScale"] ? : @"1";
            NSString *compressQuality = self.imageoptionsDic[@"compressQuality"] ? : @"0.8";


            image = [image imageByCompressToScale:[compressScale floatValue] toQuality:[compressQuality floatValue]];
            
            NSString *imgName = self.imageoptionsDic[@"imgName"] ? :[NSString stringWithFormat:@"%.0f",[NSDate date].timeIntervalSince1970];
            NSString *testPath =[NSString stringWithFormat:@"%@.png",imgName];
            NSString *testPathTemp = [FCFileManager pathForTemporaryDirectoryWithPath:testPath];
            NSData *imageData = UIImagePNGRepresentation(image);
            if ([FCFileManager existsItemAtPath:testPathTemp]) {
                [FCFileManager removeItemAtPath:testPathTemp];
            }
            
            NSString *base64String = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

            BOOL success =  [FCFileManager createFileAtPath:testPathTemp withContent:imageData];
            
            if (success) {
                if(self.choseCallBack) {
                    self.choseCallBack(@{@"imagePath":testPathTemp,
                                         @"base64Str":base64String,
                                             @"ErrCode":@"0"
                                             });
                    self.choseCallBack = nil;
                }
            }else{
                if(self.choseCallBack) {
                    self.choseCallBack(@{@"ErrCode":@"3",
                                         @"base64Str":base64String,
                                        @"ErrDes":@"图片存储失败"
                                             });
                    self.choseCallBack = nil;

                }
            }
            
        }else{
            if(self.choseCallBack) {
                self.choseCallBack(@{@"ErrCode":@"2",
                                     @"ErrDes":@"选择的类型不是图片"
                                     });
                self.choseCallBack = nil;
            }
        }
        
    });
}
/**
 *  取消相册的代理
 *
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if(self.choseCallBack) {
        self.choseCallBack(@{@"ErrCode":@"1",
                             @"ErrDes":@"用户取消"
                             });
        self.choseCallBack = nil;
    }

    [self.vc dismissViewControllerAnimated:YES completion:nil];
}

//MARK: Singsound SDK functions

/**
 重新初始化SDK

 @param params params description
 @return return value description
 */
-(NSString *)reinit:(NSDictionary *)params
{
    [[ServiceManager shareManager]registerHTTPDNS];

    __weak typeof(self)wself = self;
#ifdef DEBUG
    [[ServiceManager shareManager]getServiceAddressWithAppkey:@"t410" callback:^(NSString *serviceAddress) {
        NSLog(@"获取到的地址%@",serviceAddress);
        [wself registerEngineWithService:serviceAddress params:params];
    }];
#else
    [[ServiceManager shareManager]getServiceAddressWithAppkey:@"a410" callback:^(NSString *serviceAddress) {
        NSLog(@"获取到的地址%@",serviceAddress);
        [wself registerEngineWithService:serviceAddress params:params];
    }];
#endif
    return @"succeed";
}

-(void)registerEngineWithService:(NSString *)service params:(NSDictionary *)params
{
    
    SSOralEvaluatingManagerConfig *config = [SSOralEvaluatingManagerConfig mj_objectWithKeyValues:params];
    [SSOralEvaluatingManager registerEvaluatingManagerConfig:config];
    [[SSOralEvaluatingManager shareManager]registerEvaluatingType:OralEvaluatingTypeLine];
}

/**
 停止录音
 
 @param params params description
 */
- (NSString *)stopRecord:(NSDictionary *)params
{
    [[SSOralEvaluatingManager shareManager] stopEvaluate];
    return @"succeed";
}


/**
 开始录音
 
 @param params params description
 */
- (NSString *)startRecord:(NSDictionary *)params
{
    SSOralEvaluatingConfig *config = [SSOralEvaluatingConfig mj_objectWithKeyValues:params];

    [[SSOralEvaluatingManager shareManager] startEvaluateOralWithConfig:config];
    return @"succeed";
}

/**
 开始播放录音
 
 @param params params description
 */
- (NSString *)startPlayRecord:(NSDictionary *)params
{
    NSString *tokenId = params[@"tokenId"];
    NSString *volume = params[@"volume"];

    if (self.player.isPlaying) {
        [self.player stop];
    }
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    NSString *path = [SSOralEvaluatingManager recordPathWithTokenId:tokenId];
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:path] error:nil];
    self.player.volume = [volume floatValue];
    [self.player prepareToPlay];
    [self.player play];
    return @"succeed";
}

/**
 停止播放录音
 
 @param params params description
 */
- (NSString *)stopPlayRecord:(NSDictionary *)params
{
    if (self.player.isPlaying) {
        [self.player stop];
    }
    return @"succeed";
}

/**
 获取录音路径
 
 @param params params description
 */
- (NSString *)getRecordPath:(NSDictionary *)params
{
    NSString *tokenId = params[@"tokenId"];
    
    NSString *path = [SSOralEvaluatingManager recordPathWithTokenId:tokenId];
    return path;
}

/**
 获取录音base64文件
 
 @param params params description
 */
- (NSString *)getRecordBase64StringData:(NSDictionary *)params
{
    NSString *tokenId = params[@"tokenId"];
    
    NSString *path = [SSOralEvaluatingManager recordPathWithTokenId:tokenId];
    
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSString *base64String = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    

    return base64String;
}



//MARK: OralEvaluatingManagerDelegate

/**
 引擎初始化成功
 */
- (void)oralEvaluatingInitSuccess{
        [self.vc.webView callHandler:@"oralEvaluatingInitSuccess" arguments:nil completionHandler:nil];
}

/**
 评测开始
 */
- (void)oralEvaluatingDidStart{
    [self.vc.webView callHandler:@"oralEvaluatingDidStart" arguments:nil completionHandler:nil];
}

/**
 评测停止
 */
- (void)oralEvaluatingDidStop{
    [self.vc.webView callHandler:@"oralEvaluatingDidStop" arguments:nil completionHandler:nil];
}

/**
 评测完成后的结果
 */
- (void)oralEvaluatingDidEndWithResult: (NSDictionary *)result isLast:(BOOL)isLast{
    [self.vc.webView callHandler:@"oralEvaluatingDidEndWithResult" arguments:@[result,@(isLast)] completionHandler:nil];
}
/**
 边读边评---实时回调
 */
-(void)oralEvaluatingRealTimeCallBack:(NSDictionary *)result{
    [self.vc.webView callHandler:@"oralEvaluatingRealTimeCallBack" arguments:@[result] completionHandler:nil];

}

/**
 评测失败回调
 */
- (void)oralEvaluatingDidEndError: (NSError *)error{
    [self.vc.webView callHandler:@"oralEvaluatingDidEndError" arguments:@[error.description] completionHandler:nil];

}

/**
 录音数据回调
 */
- (void)oralEvaluatingRecordingBuffer: (NSData *)recordingData{
    
}

/**
 录音音量大小回调
 */
- (void)oralEvaluatingDidUpdateVolume: (int)volume{
    [self.vc.webView callHandler:@"oralEvaluatingDidUpdateVolume" arguments:@[@(volume)] completionHandler:nil];
}

/**
 VAD(前置时间）超时回调
 */
- (void)oralEvaluatingDidVADFrontTimeOut{
    [self.vc.webView callHandler:@"oralEvaluatingDidVADFrontTimeOut" arguments:nil completionHandler:nil];
}

/**
 VAD(后置时间）超时回调
 */
- (void)oralEvaluatingDidVADBackTimeOut{
    [self.vc.webView callHandler:@"oralEvaluatingDidVADBackTimeOut" arguments:nil completionHandler:nil];

}

/**
 录音即将超时（只支持在线模式，单词20s，句子40s)
 */
- (void)oralEvaluatingDidRecorderWillTimeOut{
    [self.vc.webView callHandler:@"oralEvaluatingDidRecorderWillTimeOut" arguments:nil completionHandler:nil];

}

/**
 录音文件id回调
 */
- (void)oralEvaluatingReturnRecordId: (NSString *)recordId{
    [self.vc.webView callHandler:@"oralEvaluatingReturnRecordId" arguments:@[recordId] completionHandler:nil];
}

@end
