//
//  PushSocket+Timer.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushSocket.h"

@interface PushSocket (Timer)

//自动重连处理
-(void)reconnectHandler;

//重启连接处理(按协议延时重连)
-(void)restartHandler;

//开启心跳处理
-(void)startPingHandler;


@end
