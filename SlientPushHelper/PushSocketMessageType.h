//
//  PushSocketMessageType.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#ifndef PushSocketMessageType_h
#define PushSocketMessageType_h

/**
 *  推送Socket消息类型
 **/
typedef NS_ENUM(NSInteger,PushSocketMessageType){
    PushSocketMessageTypeNone = 0,//未知消息类型
    PushSocketMessageTypeConnect = 1,//连接请求
    PushSocketMessageTypeConnack = 2,//连接请求应答
    PushSocketMessageTypePublish = 3,//推送消息下行
    PushSocketMessageTypePuback  = 4,//推送消息到达请求
    PushSocketMessageTypePubrel  = 6,//推送消息到达请求应答
    PushSocketMessageTypeSubscribe = 8,//用户登录请求
    PushSocketMessageTypeSuback    = 9,//用户登录请求应答
    PushSocketMessageTypeUnsubscribe = 10,//用户注销请求
    PushSocketMessageTypeUnsuback    = 11,//用户注销请求应答
    PushSocketMessageTypePingreq     = 12,//心跳请求
    PushSocketMessageTypePingresp    = 13,//心跳应答
    PushSocketMessageTypeDisconnect  = 14 // 断开请求
};


#endif /* PushSocketMessageType_h */
