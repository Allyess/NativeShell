//
//  ServiceManager.m
//  demo
//
//  Created by sing on 2018/1/18.
//  Copyright © 2018年 singsound. All rights reserved.
//

#import "ServiceManager.h"
#import <AlicloudHttpDNS/AlicloudHttpDNS.h>
@interface ServiceManager ()<HttpDNSDegradationDelegate,NSURLConnectionDelegate, NSURLSessionTaskDelegate, NSURLConnectionDataDelegate, NSURLSessionDataDelegate>
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic,copy)ServiceAddressCallback callbackBlock;
@property (nonatomic,assign)BOOL isGetAddress;
@property (nonatomic,assign)BOOL isBackAddress;
@property (nonatomic,assign)NSInteger searchIndex;
@property (nonatomic,copy)NSArray *addressArr;
@property (nonatomic,copy)NSString *appKey;
@end
@implementation ServiceManager
+ (instancetype)shareManager {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

-(void)getServiceAddressWithAppkey:(NSString *)appKey callback:(ServiceAddressCallback)callback
{
    //,@"gate-01.api.cloud.ssapi.cn",@"gate-02.api.cloud.ssapi.cn",@"gate-03.api.cloud.ssapi.cn",@"api.cloud.ssapi.cn",@"52.80.61.105",@"106.14.179.138"
    self.callbackBlock = callback;
    self.isGetAddress = NO;
    self.searchIndex = 0;
    self.addressArr =@[@"api.cloud.ssapi.cn",@"gate-01.api.cloud.ssapi.cn",@"gate-02.api.cloud.ssapi.cn",@"gate-03.api.cloud.ssapi.cn",@"52.80.61.105",@"106.14.179.138"];
    //@[@"gate-01.api.cloud.ssapi.cn",@"gate-02.api.cloud.ssapi.cn",@"gate-03.api.cloud.ssapi.cn",@"api.cloud.ssapi.cn",@"52.80.61.105",@"106.14.179.138",@"trial.cloud.ssapi.cn"];
    self.appKey = appKey;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self searchAddressOneByOne];
    });

    
}

-(void)searchAddressOneByOne
{
    NSURL *url = [[NSURL alloc]init];
    __block NSArray *hostArr = [NSArray array];
    __weak typeof(self)wself = self;
    url = [NSURL URLWithString:[NSString stringWithFormat:@"https://%@/entry_param_config?application_id=%@&client_type=app",self.addressArr[self.searchIndex],self.appKey]];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:1.0];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"从服务器获取到数据");
        /*
         对从服务器获取到的数据data进行相应的处理：
         */
        NSLog(@"地址%@错误信息%@",url,error);
        if (error == nil)
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
            NSLog(@"返回的数据%@",dict);
            if (hostArr.count == 0) {
                NSLog(@"uu %@",url);
                
                if (![dict[@"ginger_endpoints"] isKindOfClass:[NSArray class]]) {
                    hostArr =dict[@"ginger_endpoints"][@"wss"];
                    
                    if (hostArr.count == 0) {
                        [self backFirstResult];
                        return ;
                    }
                }else
                {
                    [self stopOrNot];
                }
                for (NSString *str in hostArr) {
                    if (!self.isGetAddress) {
                        [wself beginHTTPSQuery:[NSString stringWithFormat:@"https://%@",str] host:str];
                    }
                }
            }
        }else
        {
            [self stopOrNot];
            
            
        }
    }];
    // 5.最后一步，执行任务（resume也是继续执行）:
    if (hostArr.count == 0) {
        [sessionDataTask resume];
    }
}

-(void)stopOrNot
{
    if (self.searchIndex <self.addressArr.count-1) {
        self.searchIndex++;
        [self searchAddressOneByOne];
    }else
    {
        if (!self.isGetAddress && !self.isBackAddress) {
            
            [self backFirstResult];
        }
        
    }
}

-(void)backFirstResult
{
    self.isBackAddress = 1;
    self.callbackBlock([NSString stringWithFormat:@"wss://%@",self.addressArr[0]]);
}


-(void)registerHTTPDNS
{
    HttpDnsService *httpdns = [[HttpDnsService alloc] initWithAccountID:187654];
    [httpdns setCachedIPEnabled:YES];
    //鉴权方式初始化
    //HttpDnsService *httpdns = [[HttpDnsService alloc] initWithAccountID:0000 secretKey:@"XXXX"];
    
    // 为HTTPDNS服务设置降级机制
   // [httpdns setDelegateForDegradationFilter:self];
    // 允许返回过期的IP
    [httpdns setExpiredIPEnabled:NO];
    // 打开HTTPDNS Log，线上建议关闭
    [httpdns setLogEnabled:YES];
    /*
     *  设置HTTPDNS域名解析请求类型(HTTP/HTTPS)，若不调用该接口，默认为HTTP请求；
     *  SDK内部HTTP请求基于CFNetwork实现，不受ATS限制。
     */
    //[httpdns setHTTPSRequestEnabled:YES];
    // edited
    
    NSArray *preResolveHosts = @[@"api.cloud.ssapi.cn",@"trial.cloud.ssapi.cn"];
    //@[@"gate-01.api.cloud.ssapi.cn",@"gate-02.api.cloud.ssapi.cn",@"gate-03.api.cloud.ssapi.cn",@"api.cloud.ssapi.cn",@"52.80.61.105",@"106.14.179.138"];
    // NSArray* preResolveHosts = @[@"pic1cdn.igetget.com"];
    // 设置预解析域名列表
    [httpdns setPreResolveHosts:preResolveHosts];
}

//- (void)beginHTTPQuery:(NSString *)originalUrl {
//    // Do any additional setup after loading the view, typically from a nib.
//
//    // 初始化HTTPDNS
//    HttpDnsService *httpdns = [HttpDnsService sharedInstance];
//
//    //自定义超时时间，默认15秒
//    //httpdns.timeoutInterval = 15;
//
//    // 异步网络请求
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        //        NSString *originalUrl = @"http://www.aliyun.com";
//        NSURL *url = [NSURL URLWithString:originalUrl];
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//
//        /**
//         * 异步接口获取IP
//         * 为了适配IPv6的使用场景，我们使用 `-[HttpDnsService getIpByHostAsyncInURLFormat:]` 接口
//         * 注意：当您使用IP形式的URL进行网络请求时，IPv4与IPv6的IP地址使用方式略有不同：
//         *         IPv4: http://1.1.1.1/path
//         *         IPv6: http://[2001:db8:c000:221::]/path
//         * 因此我们专门提供了适配URL格式的IP获取接口 `-[HttpDnsService getIpByHostAsyncInURLFormat:]`
//         * 如果您只是为了获取IP信息而已，可以直接使用 `-[HttpDnsService getIpByHostAsync:]`接口
//         */
//
//        NSString *ip = [httpdns getIpByHostAsyncInURLFormat:url.host];
//        if (ip) {
//            // 通过HTTPDNS获取IP成功，进行URL替换和HOST头设置
//            NSLog(@"Get IP(%@) for host(%@) from HTTPDNS Successfully!", ip, url.host);
//
//
//            NSRange hostFirstRange = [originalUrl rangeOfString:url.host];
//            if (NSNotFound != hostFirstRange.location) {
//                NSString *newUrl = [originalUrl stringByReplacingCharactersInRange:hostFirstRange withString:ip];
//                NSLog(@"New URL: %@", newUrl);
//
//                request.URL =[NSURL URLWithString:[NSString stringWithFormat:@"%@/healthy_check",newUrl]];
//                [request setValue:url.host forHTTPHeaderField:@"host"];
//            }
//        }
//        NSHTTPURLResponse* response;
//        NSError *error;
//        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//
//        if (error != nil) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"Response: %@",response);
//
//            if (!self.isGetAddress) {
//                self.isGetAddress = 1;
//                NSString *backStr =[request.URL.absoluteString stringByReplacingOccurrencesOfString:@"http" withString:@"ws"];
//                self.callbackBlock(backStr);
//            }
//
//        }
//
//        // 测试黑名单中的域名
//        //        ip = [httpdns getIpByHostAsyncInURLFormat:@"www.taobao.com"];
//        //        if (!ip) {
//        //            NSLog(@"由于在降级策略中过滤了www.taobao.com，无法从HTTPDNS服务中获取对应域名的IP信息");
//        //        }
//    });
//}

- (void)beginHTTPSQuery:(NSString *)originalUrl host:(NSString *)host {
    // 初始化httpdns实例
    if (self.isBackAddress) {
        return;
    }
    HttpDnsService *httpdns = [HttpDnsService sharedInstance];
    
    //    NSString *originalUrl = @"https://www.apple.com";
    NSURL *url = [NSURL URLWithString:originalUrl];
    self.request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/healthy_check",url]]];
    [self.request setTimeoutInterval:2.0];
   [self.request setValue:host forHTTPHeaderField:@"host"];
    
    
    NSString *ip = [httpdns getIpByHostAsync:url.host];
    if (ip) {
        // 通过HTTPDNS获取IP成功，进行URL替换和HOST头设置
        NSLog(@"Get IP(%@) for host(%@) from HTTPDNS Successfully!", ip, url.host);
        NSLog(@"ip %@ %@---host %@",ip,originalUrl,host);
        NSRange hostFirstRange = [originalUrl rangeOfString:url.host];
        if (NSNotFound != hostFirstRange.location) {
            NSString *newUrl = [originalUrl stringByReplacingCharactersInRange:hostFirstRange withString:ip];
            NSLog(@"New URL: %@", newUrl);
            self.request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/healthy_check",newUrl]];
        }
    }
    // NSURLConnection例子
    // NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:YES];
    
    // NSURLSession例子
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURLSessionTask *task = [session dataTaskWithRequest:self.request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"健康检查 %@--- url = %@", error,response.URL);
            [self stopOrNot];
            
        } else {
            NSLog(@"response: %@", response);
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
          
            if (!self.isGetAddress && [str isEqualToString:@"OK"]) {
                self.isGetAddress = 1;
                [self.request.URL.absoluteString stringByReplacingOccurrencesOfString:@"https" withString:@"wss"];
                NSString *backStr = [NSString string];
                if (ip.length) {
                    backStr= [NSString stringWithFormat:@"wss://%@",ip];
                }else
                {
                    backStr= [url.absoluteString stringByReplacingOccurrencesOfString:@"https" withString:@"wss"];;
                }
                
                if (!self.isBackAddress) {
                    self.isBackAddress = 1;
                    self.callbackBlock(backStr);
                }
                
                
            }else
            {
                [self stopOrNot];
            }
            
        }
    }];
    [task resume];
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    NSURLCredential *card = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential,card);
}


- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
                  forDomain:(NSString *)domain {
    /*
     * 创建证书校验策略
     */
    NSMutableArray *policies = [NSMutableArray array];
    if (domain) {
        [policies addObject:(__bridge_transfer id) SecPolicyCreateSSL(true, (__bridge CFStringRef) domain)];
    } else {
        [policies addObject:(__bridge_transfer id) SecPolicyCreateBasicX509()];
    }
    /*
     * 绑定校验策略到服务端的证书上
     */
    SecTrustSetPolicies(serverTrust, (__bridge CFArrayRef) policies);
    /*
     * 评估当前serverTrust是否可信任，
     * 官方建议在result = kSecTrustResultUnspecified 或 kSecTrustResultProceed
     * 的情况下serverTrust可以被验证通过，https://developer.apple.com/library/ios/technotes/tn2232/_index.html
     * 关于SecTrustResultType的详细信息请参考SecTrust.h
     */
    SecTrustResultType result;
    SecTrustEvaluate(serverTrust, &result);
    return (result == kSecTrustResultUnspecified || result == kSecTrustResultProceed);
}

#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if (!challenge) {
        return;
    }
    /*
     * URL里面的host在使用HTTPDNS的情况下被设置成了IP，此处从HTTP Header中获取真实域名
     */
    NSString *host = [[self.request allHTTPHeaderFields] objectForKey:@"host"];
    if (!host) {
        host = self.request.URL.host;
    }
    /*
     * 判断challenge的身份验证方法是否是NSURLAuthenticationMethodServerTrust（HTTPS模式下会进行该身份验证流程），
     * 在没有配置身份验证方法的情况下进行默认的网络请求流程。
     */
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([self evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:host]) {
            /*
             * 验证完以后，需要构造一个NSURLCredential发送给发起方
             */
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
        } else {
            /*
             * 验证失败，取消这次验证流程
             */
            [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
        }
    } else {
        /*
         * 对于其他验证方法直接进行处理流程
         */
        [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error: %@", error);
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"cancel authentication");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"response: %@", response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"data: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    return request;
}

#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *_Nullable))completionHandler {
    if (!challenge) {
        return;
    }
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    NSURLCredential *credential = nil;
    /*
     * 获取原始域名信息。
     */
    NSString *host = [[self.request allHTTPHeaderFields] objectForKey:@"host"];
    if (!host) {
        host = self.request.URL.host;
    }
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([self evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:host]) {
            disposition = NSURLSessionAuthChallengeUseCredential;
            credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    // 对于其他的challenges直接使用默认的验证方案
    completionHandler(disposition, credential);
}


/*
 * 降级过滤器，您可以自己定义HTTPDNS降级机制
 */
//- (BOOL)shouldDegradeHTTPDNS:(NSString *)hostName {
//    NSLog(@"Enters Degradation filter.");
//    // 根据HTTPDNS使用说明，存在网络代理情况下需降级为Local DNS
//    if ([NetworkManager configureProxies]) {
//        NSLog(@"Proxy was set. Degrade!");
//        return YES;
//    }
//
//    // 假设您禁止"www.taobao.com"域名通过HTTPDNS进行解析
//    //    if ([hostName isEqualToString:@"www.taobao.com"]) {
//    //        NSLog(@"The host is in blacklist. Degrade!");
//    //        return YES;
//    //    }
//
//    return NO;
//}




@end


