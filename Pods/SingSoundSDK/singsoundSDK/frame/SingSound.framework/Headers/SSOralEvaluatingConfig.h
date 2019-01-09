//
//  SSOralEvaluatingConfig.h
//  singSoundDemo
//
//  Created by sing on 16/11/18.
//  Copyright © 2016年 an. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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


