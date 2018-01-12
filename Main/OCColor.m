//
//  OCColor.m
//  28Occupy
//
//  Created by Jinjun liang on 2018/1/9.
//  Copyright © 2018年 LK. All rights reserved.
//

#import "OCColor.h"

static NSString *const kColorKey = @"colorkey";

@implementation OCColor

+ (UIColor *)occupiedColor {
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:kColorKey]) {
        
        NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:kColorKey];
        NSArray *strings = [string componentsSeparatedByString:@","];
        return RGB([strings[0] integerValue], [strings[1] integerValue], [strings[2] integerValue]);
    }
    return RGB(244, 89, 27);
}

+ (UIColor *)transformColor:(NSString *)string
{
    NSArray *strings = [string componentsSeparatedByString:@","];
    return RGB([strings[0] integerValue], [strings[1] integerValue], [strings[2] integerValue]);
}


+ (void)changeColor:(NSString *)string
{
    [[NSUserDefaults standardUserDefaults] setValue:string forKey:kColorKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
