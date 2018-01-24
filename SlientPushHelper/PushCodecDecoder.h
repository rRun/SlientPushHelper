//
//  PushCodecDecoder.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/18.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushCodec.h"

@protocol PushCodecDecoderDelegate;
@interface PushCodecDecoder : PushCodec

@property(assign, nonatomic)id<PushCodecDecoderDelegate> delegate;//获取或设置消息解码器委托

//解析
-(void)decodeWithAppendData:(NSData *)source;

@end

@protocol PushCodecDecoderDelegate <NSObject>

/**
 * @brief 解码数据处理。
 * @param type 消息类型。
 * @param model 解码后的消息模型数据对象。
 **/
-(void)decodeWithType:(PushSocketMessageType)type andAckModel:(id)model;

@end
