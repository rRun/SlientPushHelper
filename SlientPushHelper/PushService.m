//
//  PushService.m
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/17.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import "PushService.h"
#import "AFNetworking.h"
#import "PushSocket.h"

#import "PushServiceData.h"
#import "PushHttpRequestData.h"

#import "NSString+SimplePusher.h"


@implementation PushService{
    PushServiceData *_serviceData;
    PushSocket *_socket;
}

+(instancetype)sharedHttpServer{
    static PushService * _instance = nil;
    //
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[PushService alloc] init];
    });
    return _instance;
}

#pragma mark -- 访问HTTP服务器获取配置
-(void)accessHttpServer{
    //构建参数集合
    NSDictionary *params = [[[PushHttpRequestData alloc] initWithAccess:_serviceData] toSignParameters];
    //网络请求处理
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *jsonResponseSerializer = [AFJSONResponseSerializer serializer];
    jsonResponseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                     @"text/json",
                                                     @"text/javascript",
                                                     @"text/html",nil];
    manager.responseSerializer = jsonResponseSerializer;
    [manager POST:@"" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"获取推送socket服务器数据成功:%@", responseObject);
        NSInteger result  = [responseObject[@"result"] integerValue];
        if(result == 0){//获取Socket服务器配置成功
            NSDictionary *dict = responseObject[@"setting"];
            NSLog(@"socket-settings=>%@", dict);
           // [_accessData addOrUpdateConfigWithSocket:dict];
            [self startSocketClient];
        }else{
            NSString *message = responseObject[@"message"];
            //[self sendErrorWithType:PushClientSDKErrorTypeSrvConf message:[NSString stringWithFormat:@"%zd-%@", result, message]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络异常=>%@", error);
        //[self sendErrorWithType:PushClientSDKErrorTypeConnect message:error.localizedDescription];
    }];

}

-(void)setServiceSetting:(PushServiceData *)data{
    _serviceData = data;
}
-(BOOL)addOrUpdateDeviceUserWithAlias:(NSString *)alias{
    if(!alias || !alias.length){
        alias = @"";
    }else{
        alias = [alias trim];
    }
    return YES;
}


#pragma mark -- 启动socket客户端
-(void)startSocketClient{
    NSLog(@"startSocketClient...");
    if(!_socket.delegate){
        _socket.delegate = self;
    }
    //启动
    [_socket start];
}

#pragma mark -- 关闭socket客户端
-(void)stopSocketClient{
    NSLog(@"stopSocketClient...");
    if(_socket){
        [_socket stop];
    }
}



@end
