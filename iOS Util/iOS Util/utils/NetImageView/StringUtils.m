//
//  StringUtils.m
//  TimeBox
//
//  Created by Tu Jianfeng on 12-10-16.
//  Copyright (c) 2012年 VNT. All rights reserved.
//

#import "StringUtils.h"

static NSDateFormatter * sharedFormatter = nil;

@implementation StringUtils

+ (NSString *)strFromDict:(NSDictionary *)dict withKey:(NSString *)key
{
    if ([[dict objectForKey:key] isKindOfClass:[NSNull class]]
        || [[dict objectForKey:key] isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    else if ([[dict objectForKey:key] isKindOfClass:[NSNumber class]]) {
        return [[dict objectForKey:key] stringValue];
    }
    else {
        return [dict objectForKey:key];
    }
}

+ (NSDateFormatter *)sharedFormatter:(NSString *)dateFormat
{
    if (sharedFormatter == nil) {
        sharedFormatter = [[NSDateFormatter alloc] init];
    }
    [sharedFormatter setDateFormat:dateFormat];
    
    return sharedFormatter;
}

+ (BOOL)isEmpty:(NSString *)string
{
    if ([string isKindOfClass:[NSNull class]])
        return YES;
    
    if ([string isKindOfClass:[NSNumber class]])
        return NO;
    
    return [string length] == 0;
}

+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (NSString *)dateStr:(NSDate *)date
{
    NSDateFormatter * formatter = [self sharedFormatter:@"yyyy-MM-dd  HH:mm"];
    return [formatter stringFromDate:date];
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter * formatter = [self sharedFormatter:@"yyyy-MM-dd'T'HH:mm:ss'+08:00'"];
    return [formatter stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)str
{
    NSDateFormatter * formatter = [self sharedFormatter:@"yyyy-MM-dd'T'HH:mm:ss'+08:00'"];
    return [formatter dateFromString:str];
}

+ (NSDate *)dateFromDayStr:(NSString *)str
{
    NSDateFormatter * formatter = [self sharedFormatter:@"yyyy-MM-dd"];
    return [formatter dateFromString:str];
}

+ (NSString *)sectionDisplayStr:(NSDate *)date
{
    NSDateFormatter * formatter = [self sharedFormatter:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}

+ (NSString *)dayStrOfDate:(NSDate *)date
{
    NSDateFormatter * formatter = [self sharedFormatter:@"dd"];
    return [formatter stringFromDate:date];
}

+ (NSString *)monthStrOfDate:(NSDate *)date
{
    NSDateFormatter * formatter = [self sharedFormatter:@"yyyy-MM"];
    return [formatter stringFromDate:date];
}

+ (NSString *)weekdayStr:(NSDate *)date
{
    NSDateFormatter * formatter = [self sharedFormatter:@"EEEE"];
    return [formatter stringFromDate:date];;
}

+ (NSString *)timeStr:(NSDate *)date
{
    NSDateFormatter * formatter = [self sharedFormatter:@"HH:mm"];
    return [formatter stringFromDate:date];
}

+ (NSString *)stringFromByte:(long long)byte
{
    if (byte > 0 && byte < 1024) {
        return [NSString stringWithFormat:@"%lldB",byte];
    }
    else if (byte < 1024 * 1024) {
        return [NSString stringWithFormat:@"%.1lfKB",byte / 1024.0];
    }
    else if (byte < 1024 * 1024 * 1024) {
        return [NSString stringWithFormat:@"%.1lfMB", byte / 1024.0 / 1024.0];
    }
    else if (byte < 1024 * 1024 * 1024 *1024) {
        return [NSString stringWithFormat:@"%.1lfGB", byte / 1024.0 / 1024.0 / 1024.0];
    }
    return @"0B";
}

+ (NSArray *)divideName:(NSString *)name
{
    NSArray *array = [NSArray arrayWithObjects:@"欧阳", @"太史", @"端木", @"上官", @"司马", @"东方", @"独孤", @"南宫", @"万俟", @"闻人", @"夏侯", @"诸葛", @"尉迟", @"公羊", @"赫连", @"澹台", @"皇甫", @"宗政", @"濮阳", @"公冶", @"太叔", @"申屠", @"公孙", @"慕容", @"仲孙", @"钟离", @"长孙", @"宇文", @"司徒", @"鲜于", @"司空", @"闾丘", @"子车", @"亓官", @"司寇", @"巫马", @"公西", @"颛孙", @"壤驷", @"公良", @"漆雕", @"乐正", @"宰父", @"谷梁", @"拓跋", @"夹谷", @"轩辕", @"令狐", @"段干", @"百里", @"呼延", @"东郭", @"南门", @"羊舌", @"微生", @"公户", @"公玉", @"公仪", @"梁丘", @"公仲", @"公上", @"公门", @"公山", @"公坚", @"左丘", @"公伯", @"西门", @"公祖", @"第五", @"公乘", @"贯丘", @"公皙", @"南荣", @"东里", @"东宫", @"仲长", @"子书", @"子桑", @"即墨", @"达奚", @"褚师", @"吴铭", nil];
    NSString *firstName = [NSString string];
    NSString *lastName = [NSString string];
    //中文
    if ([name characterAtIndex:0] > 0x4e00 && [name characterAtIndex:0] < 0x9fff) {
        if (name.length == 1) lastName = name;
        else if (name.length == 2) {
            lastName = [name substringToIndex:1];
            firstName = [name substringFromIndex:1];
        }
        else if (name.length >= 3) {
            //复姓
            if ([array containsObject:[name substringToIndex:2]]) {
                lastName = [name substringToIndex:2];
                firstName = [name substringFromIndex:2];
            }
            //单姓
            else {
                lastName = [name substringToIndex:1];
                firstName = [name substringFromIndex:1];
            }
        }
    }
    //英文
    else {
        NSRange rangeOfFirstSpace = [name rangeOfString:@"_"];
        NSRange rangeOfLastSpace = [name rangeOfString:@"_" options:NSBackwardsSearch];
        if (rangeOfFirstSpace.length || rangeOfLastSpace.length) {
            lastName = [name substringFromIndex:rangeOfLastSpace.location + 1];
            firstName = [name substringToIndex:rangeOfFirstSpace.location];
        }
        else lastName = name;
    }
    return [NSArray arrayWithObjects:lastName, firstName, nil];
}

@end
