//
//  OCColor.h
//  28Occupy
//
//  Created by Jinjun liang on 2018/1/9.
//  Copyright © 2018年 LK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCColor : NSObject

+ (UIColor *)occupiedColor;

+ (UIColor *)transformColor:(NSString *)string;

+ (void)changeColor:(NSString *)string;

@end
