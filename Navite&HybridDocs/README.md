

- [使用的框架](#%E4%BD%BF%E7%94%A8%E7%9A%84%E6%A1%86%E6%9E%B6)
- [交互 Demo](#%E4%BA%A4%E4%BA%92-demo)
  - [js 调用 Native](#js-%E8%B0%83%E7%94%A8-native)
  - [js 注册方法供 Native 调用](#js-%E6%B3%A8%E5%86%8C%E6%96%B9%E6%B3%95%E4%BE%9B-native-%E8%B0%83%E7%94%A8)
- [Navtive 提供方法](#navtive-%E6%8F%90%E4%BE%9B%E6%96%B9%E6%B3%95)
    - [修改导航栏方法](#%E4%BF%AE%E6%94%B9%E5%AF%BC%E8%88%AA%E6%A0%8F%E6%96%B9%E6%B3%95)
      - [修改控制器标题](#%E4%BF%AE%E6%94%B9%E6%8E%A7%E5%88%B6%E5%99%A8%E6%A0%87%E9%A2%98)
      - [隐藏导航栏左侧按钮](#%E9%9A%90%E8%97%8F%E5%AF%BC%E8%88%AA%E6%A0%8F%E5%B7%A6%E4%BE%A7%E6%8C%89%E9%92%AE)
      - [显示导航栏左侧按钮](#%E6%98%BE%E7%A4%BA%E5%AF%BC%E8%88%AA%E6%A0%8F%E5%B7%A6%E4%BE%A7%E6%8C%89%E9%92%AE)
      - [显示导航栏](#%E6%98%BE%E7%A4%BA%E5%AF%BC%E8%88%AA%E6%A0%8F)
      - [隐藏导航栏](#%E9%9A%90%E8%97%8F%E5%AF%BC%E8%88%AA%E6%A0%8F)
    - [页面跳转](#%E9%A1%B5%E9%9D%A2%E8%B7%B3%E8%BD%AC)
      - [跳转首页](#%E8%B7%B3%E8%BD%AC%E9%A6%96%E9%A1%B5)
      - [消除当前页面](#%E6%B6%88%E9%99%A4%E5%BD%93%E5%89%8D%E9%A1%B5%E9%9D%A2)
    - [系统基础功能](#%E7%B3%BB%E7%BB%9F%E5%9F%BA%E7%A1%80%E5%8A%9F%E8%83%BD)
      - [打开外部App](#%E6%89%93%E5%BC%80%E5%A4%96%E9%83%A8app)
      - [打电话](#%E6%89%93%E7%94%B5%E8%AF%9D)
      - [调用相册](#%E8%B0%83%E7%94%A8%E7%9B%B8%E5%86%8C)
      - [调用相机](#%E8%B0%83%E7%94%A8%E7%9B%B8%E6%9C%BA)
    - [Singsound SDK functions](#singsound-sdk-functions)
      - [重新初始化SDK](#%E9%87%8D%E6%96%B0%E5%88%9D%E5%A7%8B%E5%8C%96sdk)
      - [停止录音](#%E5%81%9C%E6%AD%A2%E5%BD%95%E9%9F%B3)
      - [开始录音](#%E5%BC%80%E5%A7%8B%E5%BD%95%E9%9F%B3)
      - [开始播放录音](#%E5%BC%80%E5%A7%8B%E6%92%AD%E6%94%BE%E5%BD%95%E9%9F%B3)
      - [停止播放录音](#%E5%81%9C%E6%AD%A2%E6%92%AD%E6%94%BE%E5%BD%95%E9%9F%B3)
      - [获取录音路径](#%E8%8E%B7%E5%8F%96%E5%BD%95%E9%9F%B3%E8%B7%AF%E5%BE%84)
    - [Cookies & Persistence](#cookies--persistence)
      - [设置客户端缓存](#%E8%AE%BE%E7%BD%AE%E5%AE%A2%E6%88%B7%E7%AB%AF%E7%BC%93%E5%AD%98)
      - [读取客户端缓存](#%E8%AF%BB%E5%8F%96%E5%AE%A2%E6%88%B7%E7%AB%AF%E7%BC%93%E5%AD%98)
      - [读取所有客户端缓存](#%E8%AF%BB%E5%8F%96%E6%89%80%E6%9C%89%E5%AE%A2%E6%88%B7%E7%AB%AF%E7%BC%93%E5%AD%98)
      - [设置客户端持久化数据](#%E8%AE%BE%E7%BD%AE%E5%AE%A2%E6%88%B7%E7%AB%AF%E6%8C%81%E4%B9%85%E5%8C%96%E6%95%B0%E6%8D%AE)
      - [读取客户端持久化数据](#%E8%AF%BB%E5%8F%96%E5%AE%A2%E6%88%B7%E7%AB%AF%E6%8C%81%E4%B9%85%E5%8C%96%E6%95%B0%E6%8D%AE)
- [Javascript 提供方法 (Hook 方法)](#javascript-%E6%8F%90%E4%BE%9B%E6%96%B9%E6%B3%95-hook-%E6%96%B9%E6%B3%95)
  - [点击事件](#%E7%82%B9%E5%87%BB%E4%BA%8B%E4%BB%B6)
      - [Navtive 是否响应返回按钮事件](#navtive-%E6%98%AF%E5%90%A6%E5%93%8D%E5%BA%94%E8%BF%94%E5%9B%9E%E6%8C%89%E9%92%AE%E4%BA%8B%E4%BB%B6)
  - [生命周期](#%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F)
      - [页面出现](#%E9%A1%B5%E9%9D%A2%E5%87%BA%E7%8E%B0)
      - [页面消失](#%E9%A1%B5%E9%9D%A2%E6%B6%88%E5%A4%B1)
      - [app进入前台](#app%E8%BF%9B%E5%85%A5%E5%89%8D%E5%8F%B0)
      - [app进入后台](#app%E8%BF%9B%E5%85%A5%E5%90%8E%E5%8F%B0)
  - [SDK 回调](#sdk-%E5%9B%9E%E8%B0%83)
      - [引擎初始化成功](#%E5%BC%95%E6%93%8E%E5%88%9D%E5%A7%8B%E5%8C%96%E6%88%90%E5%8A%9F)
      - [评测开始](#%E8%AF%84%E6%B5%8B%E5%BC%80%E5%A7%8B)
      - [评测停止](#%E8%AF%84%E6%B5%8B%E5%81%9C%E6%AD%A2)
      - [评测完成后的结果](#%E8%AF%84%E6%B5%8B%E5%AE%8C%E6%88%90%E5%90%8E%E7%9A%84%E7%BB%93%E6%9E%9C)
      - [边读边评---实时回调](#%E8%BE%B9%E8%AF%BB%E8%BE%B9%E8%AF%84---%E5%AE%9E%E6%97%B6%E5%9B%9E%E8%B0%83)
      - [评测失败回调](#%E8%AF%84%E6%B5%8B%E5%A4%B1%E8%B4%A5%E5%9B%9E%E8%B0%83)
      - [录音音量大小回调](#%E5%BD%95%E9%9F%B3%E9%9F%B3%E9%87%8F%E5%A4%A7%E5%B0%8F%E5%9B%9E%E8%B0%83)
      - [VAD(前置时间）超时回调](#vad%E5%89%8D%E7%BD%AE%E6%97%B6%E9%97%B4%E8%B6%85%E6%97%B6%E5%9B%9E%E8%B0%83)
      - [VAD(后置时间）超时回调](#vad%E5%90%8E%E7%BD%AE%E6%97%B6%E9%97%B4%E8%B6%85%E6%97%B6%E5%9B%9E%E8%B0%83)
      - [录音即将超时（只支持在线模式，单词20s，句子40s)](#%E5%BD%95%E9%9F%B3%E5%8D%B3%E5%B0%86%E8%B6%85%E6%97%B6%E5%8F%AA%E6%94%AF%E6%8C%81%E5%9C%A8%E7%BA%BF%E6%A8%A1%E5%BC%8F%E5%8D%95%E8%AF%8D20s%E5%8F%A5%E5%AD%9040s)
      - [录音文件id回调](#%E5%BD%95%E9%9F%B3%E6%96%87%E4%BB%B6id%E5%9B%9E%E8%B0%83)
 
# 使用的框架 

[DSBridge-iOS](https://github.com/wendux/DSBridge-IOS)  
[DSBridge-Android](https://github.com/wendux/DSBridge-Android)
[DSBridge-JS](https://unpkg.com/dsbridge@3.0.8/dist/dsbridge.js)  







# 交互 Demo

## js 调用 Native  

```Javascript

    //Init dsBridge
    //cdn/放置服务器
    //<script src="https://unpkg.com/dsbridge@3.0.8/dist/dsbridge.js"></script>
    //npm
    //npm install dsbridge@3.0.8
    var dsBridge=require("dsbridge")

    //Call synchronously 同步（不推荐）
    var str=dsBridge.call("testSyn","testSyn");

    //Call asynchronously 异步回调
    dsBridge.call("functionName","param", function (v) {
        alert(v);
    })

```

## js 注册方法供 Native 调用  

```Javascript
    //Register javascript API for Native
    dsBridge.register('functionName',function(l,r){
        return l+r;
    })
```



# Navtive 提供方法



### 修改导航栏方法

#### 修改控制器标题

```JS
	  //functionName: modifyNativeNavBarTitle(object)
	  dsBridge.call('modifyNativeNavBarTitle', {"title": "Foo"})
```

| name | type | des | required |
| --- | --- | --- | --- |
| title  | string | 标题 | 1 |



#### 隐藏导航栏左侧按钮

```JS
    hideNavLeftButton()
```

#### 显示导航栏左侧按钮

```JS
    showNavLeftButton()
```

#### 显示导航栏

```JS
    nativeShowNavBar()
```

#### 隐藏导航栏

```JS
    nativeHideNavBar()
```



### 页面跳转

#### 跳转首页

```JS
    pushIndex()
```

#### 消除当前页面

```JS
    dissmissCurrentVc()
```


### 系统基础功能
#### 打开外部App

```js
dsBridge.call("openURL", {"Url":"https://www.baidu.com"});
```

| name | type | des | required |
| --- | --- | --- | --- |
| Url  | string | 外部URL | 1 |

#### 打电话

```JS
dsBridge.call("callPhone",{"phoneNum":"10086"});
```

| name | type | des | required |
| --- | --- | --- | --- |
| phoneNum  | string | 电话号码 | 1 |

#### 调用相册
   //callback(object)
    //object{imageId: "1111", error: object}
    openGallery(obejct, callback)
    
```JS
dsBridge.call("openGallery", {"allowsEditing":"1","compressScale":"0.5","compressQuality":"0.5","imgName":"123"}, function (v) {
                      console.log(v)
                      });

```


req：

| name | type | des | required | remark |
| --- | --- | --- | --- | --- |
| allowsEditing  | string | 是否允许编辑图片 | 1 | 0 不允许 1允许|
| compressScale | string |图片压缩比例 | 0 | 0～1，默认0.5|
| compressQuality  | string | 图片压缩质量 | 0 | 0～1，默认0.5|
| imgName  | string | imgName | 0 | 默认时间戳|

res：

| name | type | des | remark |
| --- | --- | --- | --- |
| callback.base64Str | string | 图片数据（base64） |  |
| callback.imagePath  | string | 图片路径 | |
| callback.ErrDes  | string | 错误描述 | |
| callback.ErrCode  | string | 错误描述 | 0表示没错误，4设备不支持相机，3存储失败，2选择的类型不是图片，1用户取消 |



#### 调用相机
```JS
 dsBridge.call("openCamare", {"allowsEditing":"1","compressScale":"0.5","compressQuality":"0.5","imgName":"123"}, function (v) {
                      console.log(v)
                      });
```

req：

| name | type | des | required | remark |
| --- | --- | --- | --- | --- |
| allowsEditing  | string | 是否允许编辑图片 | 1 | 0 不允许 1允许|
| compressScale | string |图片压缩比例 | 0 | 0～1，默认0.5|
| compressQuality  | string | 图片压缩质量 | 0 | 0～1，默认0.5|
| imgName  | string | imgName | 0 | 默认时间戳|

res：

| name | type | des | remark |
| --- | --- | --- | --- |
| callback.base64Str | string | 图片数据（base64） |  |
| callback.imagePath  | string | 图片路径 | |
| callback.ErrDes  | string | 错误描述 | |
| callback.ErrCode  | string | 错误描述 | 0表示没错误，4设备不支持相机，3存储失败，2选择的类型不是图片，1用户取消 |


###  Singsound SDK functions


#### 重新初始化SDK

```JS
console.log(dsBridge.call("reinit", {"appKey":"t410","secretKey":"1a16f31f2611bf32fb7b3fc38f5b2c73"}));
```

req：

| name | type | des | required | remark |
| --- | --- | --- | --- | --- |
| appKey  | string | appKey | 1 | |
| secretKey | string |secretKey | 1 |  |

更多参数见`SSOralEvaluatingManagerConfig`类，传值都为字符串即可：
 ```objectivec

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


 ```

####  停止录音

```JS
dsBridge.call("stopRecord")
```

#### 开始录音

```JS
dsBridge.call("startRecord", {"oralType":"8","openFeed":"1","oralContent":"中国人民银行"})
```

req：

| name | type | des | required | remark |
| --- | --- | --- | --- | --- |
| oralType  | string | 题型(必选) | 1 | 见SDK|
| openFeed | string | 是否开启边读边评，实时返回数据，目前支持 句子、段落类型 | 1 | 见SDK |
| oralContent | string | 内容(非必选） | 0 | 见SDK |
更多参数见`SSOralEvaluatingConfig`类，传值都为字符串即可：
 ```objectivec
//评测的题型
typedef NS_ENUM(NSInteger, OralType) {
    OralTypeWord = 1,                               //单词
    OralTypeSentence,                               //语句
    OralTypeParagraph,                              //段落
    OralTypeChoose,                                 //选择题
    OralTypeEssayQuestion,                          //问答题
    OralTypePicture,                                //看图作文
    OralTypeChineseWord,                            //中文单词
    OralTypeChineseSentence,                        //中文句子
    OralTypeChinesePcha,                            //中文有限分支识别评测,这个题型需要设置anwserArr
    OralTypeChinesePred,                            //中文段落
    OralTypeEnglishPcha,                            //英文有限分支识别评测,这个题型需要设置anwserArr
    OralTypeAlpha,                                  //音标评测
    OralTypeRec,                                    //自由识别
    OralTypePcha,                                   //句子选读
    OralTypeRetell,                                 //故事复述
    OralTypePche,                                   //扩展选择
    
};

//评分精确度
typedef NS_ENUM(NSInteger, EvaluatingPrecision) {
    EvaluatingPrecisionSmall,     //0.1
    EvaluatingPrecisionMedium,    //0.5
    EvaluatingPrecisionHigh,      //1
};
//混合模式下强制选择在线评测，离线评测。
typedef NS_ENUM(NSInteger, MixedType) {
    MixedTypeDefault,   //默认情况有网用在线，无网用离线
    MixedTypeOnline,   //强制使用在线
    MixedTypeOffline,   //强制使用离线
};

@class SSOralEvaluatingAnswer;

@interface SSOralEvaluatingConfig : NSObject


/**
 声音格式 defaults is "wav"
 */
@property (nonatomic, strong) NSString *audioType;

/**
 采样率 defaults is 16000,
 Options are 8000,16000,44000.
 */
@property (nonatomic, assign) NSInteger sampleRate;

/**
 声道 defaults is 1
 */
@property (nonatomic, assign) NSInteger channel;

/**
 每采样字节数 defaults is 2,
 */
@property (nonatomic, assign) NSInteger sampleBytes;

/**
 题型(必选）
 */
@property (nonatomic, assign) OralType oralType;

/**
 混合模式下强制选择在线评测，离线评测。
 */
@property (nonatomic, assign) MixedType mixedType;


/**
 内容(非必选）
 */
@property (nonatomic, copy) NSString *oralContent;

/**
 分值(非必选 default:100）
 */
@property (nonatomic, assign) NSUInteger rank;

/**
 是否开启边读边评，实时返回数据，目前支持 句子、段落类型
 */
@property (nonatomic, assign) BOOL openFeed;

/**
 是否开启比较音频数据，开启后会在评测完成的结果里返回和标准音频对比数据---字段： result_compare
 ***目前仅支持 OralTypeSentence（句子）***
 */
@property (nonatomic, assign) BOOL openCompareAudio;

/**
 标准音频地址---上线前需要给平台提前报备标准音频的基本信息。基本信息包括：音频文本，音频url
 */
@property (nonatomic, copy) NSString * stdAudioUrl;

/**
 用户ID(非必选 default:@"this-is-user-id"）
 */
@property (nonatomic, copy) NSString *userId;

/**
 评分精确度(非必选 default:EvaluatingPrecisionHigh）EvaluatingPrecisionSmall:0.1 EvaluatingPrecisionMedium:0.5 EvaluatingPrecisionHigh:1
 */
@property (nonatomic, assign) EvaluatingPrecision precision;

/**
 评分松紧度，范围0.8~1.5，数值越小，打分越严厉
 */
@property (nonatomic, assign) CGFloat rateScale;

/**
 评分松紧度，可传 1，2，3，4。越来越松，1最严格，4最松。和rateScale不能同时传
 */
@property (nonatomic, assign) NSUInteger typeThres;

/**
 指定单词的发音 例如：{"conversion":"b uh k","hello":"b uh k"}，只支持单词评测。
 */
@property (nonatomic, copy) NSDictionary *phonesDic;

/**
 答案（非必选）  中文有限分支识别评测，必须填写这个字段
 */
@property (nonatomic, strong) NSArray<__kindof SSOralEvaluatingAnswer *> *answerArray;

/**
 此字段 用于英文扩展选择题 只能设置 0 和 1 (非必选 default:0）
 1 ：表示总分包含发音分。50% + 50% * 发音分
 0 ：默认值;表示总分只可能是满分或者 0 分两种情况
 */
@property (nonatomic, assign) NSUInteger pronScale;

/**
 关键字数组（非必选）
 */
@property (nonatomic, strong) NSArray<__kindof NSString *> *keywordArray;

/**
 要点数组（非必选）
 */
@property (nonatomic, strong) NSArray<__kindof NSString *> *pointsArray;

/**
 错误答案数组（非必选） pche 必选
 */
@property (nonatomic, strong) NSArray<__kindof NSString *> *wrongWordArray;



/**
 问题 （非必选）
 */
@property (nonatomic, strong) NSString *question;

/**
 录音文本（非必选）
 */
@property (nonatomic, strong) NSString *recorderContent;

/**
 句子评测中是否输出每个单词的音标分
 */
@property (nonatomic, assign) BOOL isOutputPhonogramForSentence;

/**
 英文单词，英文句子 是否开启音素检错
 */
@property (nonatomic, assign) BOOL checkPhones;


/**
 重传机制类型：
 0 不重传；
 1表示重传，出现这类异常时，等待测评时间很短，重传不会影响用户体验。默认1
 2表示重传，出现这类异常时，等待测评的时间很长，重传可能会导致用户等待很久。（2包含1重传的情况）
 */
@property (nonatomic, assign) NSInteger enableRetry;

/**
 评测音节信息，只支持单词评测，YES/1表示使用此功能，默认NO不使用
 */
@property (nonatomic,assign)BOOL isSyllable;

/**
 如果单词前有多个连续标点，只显示第一个标点;如果单词结尾有多个连续 标点，只输出靠近结尾单词最近的三个标点
 默认开启
 */
@property (nonatomic, assign) BOOL openSymbol;



/**
 grade  学段  1表示初中 2表示高中  非必填
 */
@property (nonatomic,assign) NSInteger grade;

/**
 录音回调时间间隔 int类型 单位毫秒
 */
@property (nonatomic,assign) int recordTimeinterval;


@property (nonatomic,copy)NSDictionary  *examParam;


/**：
 是否由外部设置AVAudioSession category
 默认 NO 在sdk内部设置
 YES 由外部设置AVAudioSession category
 **** category 只能设置 AVAudioSessionCategoryPlayAndRecord 或者 AVAudioSessionCategoryRecord
 **** 如果设置为YES , 必须在（ startEvaluateOralWithConfig：）开始测评方法 触发之前设置AVAudioSession category
 */
@property (nonatomic,assign) BOOL initiativeSetAudio;


@end




#pragma mark - SSOralEvaluatingAnswer
@interface SSOralEvaluatingAnswer:NSObject

/**
 分值
 */
@property (nonatomic, assign) CGFloat rank;

/**
 答案
 */
@property (nonatomic, strong) NSString *answer;

@property (nonatomic,assign)BOOL isGinger;

@end


 ```

#### 开始播放录音

```JS
dsBridge.call("startPlayRecord", {"tokenId":xxx,"volume":"0.9"})
```

req：

| name | type | des | required | remark |
| --- | --- | --- | --- | --- |
| tokenId  | string | tokenId | 1 | |
| volume | string |volume | 1 | 0~1 |

#### 停止播放录音


```JS
dsBridge.call("stopPlayRecord")
```


#### 获取录音路径


```JS
        console.log(dsBridge.call("getRecordPath", {"tokenId":xxx}));

// retuen path
```

req：

| name | type | des | required | remark |
| --- | --- | --- | --- | --- |
| tokenId  | string | tokenId | 1 | |


### Cookies & Persistence


#### 设置客户端缓存

```JS
dsBridge.call("setNativeCookie", {"key":"setNativeCookie","value":"654321"});
```

req：

| name | type | des | required | remark |
| --- | --- | --- | --- | --- |
| key  | string | key | 1 | |
| value | string |value | 1 |  |

#### 读取客户端缓存

```JS
alert( dsBridge.call("getNativeCookie", "setNativeCookie"));
```

req：

| name | type | des | required | remark |
| --- | --- | --- | --- | --- |
| key  | string | key | 1 | |

不存在则返回“”


#### 读取所有客户端缓存

```JS
    //key: string
    getNativeCookies()

    //e.g
       dsBridge.call("getNativeCookies", "")


    //key不存在返回 “”
```


#### 设置客户端持久化数据


 @return  "succeed" or "failed"

```JS
    //key: string, value: string
    setNativePersistence({key, value})

    //e.g
        dsBridge.call("setNativePersistence", {"key":"getNativePersistence","value":"123456"});
```

req：

| name | type | des | required | remark |
| --- | --- | --- | --- | --- |
| key  | string | key | 1 | |
| value | string |value | 1 |  |
#### 读取客户端持久化数据

```JS
    //key: string
    getNativePersistence(key)

    //e.g
       alert( dsBridge.call("getNativePersistence", "getNativePersistence"));
    //key不存在返回 “”
```

req：

| name | type | des | required | remark |
| --- | --- | --- | --- | --- |
| key  | string | key | 1 | |

不存在则返回“”






# Javascript 提供方法 (Hook 方法)

## 点击事件
#### Navtive 是否响应返回按钮事件

```Obj-C
    //functionName: DDWEBVIEW_NAV_BACK
    //callback(value) 0 响应，Navtive处理；1 不响应，交由H5处理
```
```js
dsBridge.register('NATIVE_APP_GO_BACKGROUND', function () {
                      alert('NATIVE_APP_GO_BACKGROUND')
                      return ;
                      })

```
## 生命周期


#### 页面出现

```Obj-C
    //func NATIVE_VIEW_DID_APPEAR
```
#### 页面消失

```Obj-C
    //func NATIVE_VIEW_DID_DISAPPEAR
```

#### app进入前台

```Obj-C
    //func NATIVE_APP_GO_FOREGROUND
```
#### app进入后台

```Obj-C
    //func NATIVE_APP_GO_BACKGROUND
```



## SDK 回调
####  引擎初始化成功

```Obj-C
    //func oralEvaluatingInitSuccess
```
####   评测开始

```Obj-C
    //func oralEvaluatingDidStart
```
####   评测停止

```Obj-C
    //func oralEvaluatingDidStop
```
####   评测完成后的结果

```js
    //func oralEvaluatingDidEndWithResult
    //params1 result
    //params2 isLast
    
    //eg:
  dsBridge.register('oralEvaluatingDidEndWithResult', function (result,isLast) {
                      console.log('oralEvaluatingDidEndWithResult')
                      console.log(result)
                      console.log(isLast)

                      return ;
                      })
```
####  边读边评---实时回调

```Obj-C
    //func oralEvaluatingRealTimeCallBack
    //params1 result

```
####   评测失败回调


```Obj-C
    //func oralEvaluatingDidEndError
   //params1 错误描述

```
####   录音音量大小回调


```Obj-C
    //func oralEvaluatingDidUpdateVolume
       //params1 音量

```
####  VAD(前置时间）超时回调

```Obj-C
    //func oralEvaluatingDidVADFrontTimeOut
```
####  VAD(后置时间）超时回调

```Obj-C
    //func oralEvaluatingDidVADBackTimeOut
```
####   录音即将超时（只支持在线模式，单词20s，句子40s)

```Obj-C
    //func oralEvaluatingDidRecorderWillTimeOut
```
####  录音文件id回调

```Obj-C
    //func oralEvaluatingReturnRecordId
   //params1 id
```
