

- [使用的框架](#%E4%BD%BF%E7%94%A8%E7%9A%84%E6%A1%86%E6%9E%B6)
- [交互 Demo](#%E4%BA%A4%E4%BA%92-demo)
  - [js 调用 Native](#js-%E8%B0%83%E7%94%A8-native)
  - [js 注册方法供 Native 调用](#js-%E6%B3%A8%E5%86%8C%E6%96%B9%E6%B3%95%E4%BE%9B-native-%E8%B0%83%E7%94%A8)
- [Navtive 提供方法](#navtive-%E6%8F%90%E4%BE%9B%E6%96%B9%E6%B3%95)
    - [修改导航栏方法](#%E4%BF%AE%E6%94%B9%E5%AF%BC%E8%88%AA%E6%A0%8F%E6%96%B9%E6%B3%95)
      - [修改控制器标题](#%E4%BF%AE%E6%94%B9%E6%8E%A7%E5%88%B6%E5%99%A8%E6%A0%87%E9%A2%98)
      - [隐藏导航栏左侧按钮](#%E9%9A%90%E8%97%8F%E5%AF%BC%E8%88%AA%E6%A0%8F%E5%B7%A6%E4%BE%A7%E6%8C%89%E9%92%AE)
      - [显示导航栏左侧按钮](#%E6%98%BE%E7%A4%BA%E5%AF%BC%E8%88%AA%E6%A0%8F%E5%B7%A6%E4%BE%A7%E6%8C%89%E9%92%AE)
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
