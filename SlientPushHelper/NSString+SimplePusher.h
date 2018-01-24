//
//  NSString+SimplePusher.h
//  SlientPushHelper
//
//  Created by 何霞雨 on 2017/5/17.
//  Copyright © 2017年 何霞雨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SimplePusher)
/**
 * @brief 清除字符串中的空格。
 * @return 清除前后空格后的字符串。
 **/
-(NSString *)trim;

/**
 * @brief 字符串进行MD5加密。
 * @return MD5加密后的Hex格式字符串。
 **/
-(NSString *)md5;

/**
 * @brief 将NSData转换为Hex格式
 **/
+(NSString *)dataToHex:(NSData *)data;

@end
