//
//  StringUtils.h
//  TimeBox
//
//  Created by Tu Jianfeng on 12-10-16.
//  Copyright (c) 2012年 VNT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

+ (BOOL)isEmpty:(NSString *)string;
+ (BOOL)isValidateEmail:(NSString *)email;
+ (NSString *)strFromDict:(NSDictionary *)dict withKey:(NSString *)key;
+ (NSString *)dateStr:(NSDate *)date;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSDate *)dateFromString:(NSString *)str;
+ (NSDate *)dateFromDayStr:(NSString *)str;
+ (NSString *)sectionDisplayStr:(NSDate *)date;
+ (NSString *)dayStrOfDate:(NSDate *)date;
+ (NSString *)monthStrOfDate:(NSDate *)date;
+ (NSString *)timeStr:(NSDate *)date;
+ (NSString *)weekdayStr:(NSDate *)date;
+ (NSString *)stringFromByte:(long long)byte;
+ (NSArray *)divideName:(NSString *)name;

@end
