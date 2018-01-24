//
//  PushBaseModel.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import <Foundation/Foundation.h>


FOUNDATION_EXPORT NSString * const PUSH_PARAMS_ACCOUNT;//请求参数-接入帐号字段
FOUNDATION_EXPORT NSString * const PUSH_PARAMS_SIGN;//请求参数-参数签名字段

@interface PushBaseModel : NSObject{
    @protected NSDictionary *_params;//参数集合
}

@property(copy,nonatomic)NSString *account;//获取或设置接入帐号
@property(copy,nonatomic)NSString *token;//获取或设置接入密钥

//参数签名
-(NSDictionary *)toSign;

//toSign转化json字符串
-(NSString *)toSignJson;

@end
