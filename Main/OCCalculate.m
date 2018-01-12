//
//  OCCalculate.m
//  28Occupy
//
//  Created by Jinjun liang on 2018/1/9.
//  Copyright © 2018年 LK. All rights reserved.
//

#import "OCCalculate.h"

@implementation OCCalculate

NSArray *newBoxs(NSInteger index, NSArray *allBoxs) {
    
    NSMutableArray *handeled = [NSMutableArray arrayWithCapacity:0];
    NSArray *adjacents = adjacentBox(index, sqrt(allBoxs.count));
    [allBoxs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BOOL status = [obj boolValue];
        if(index == idx || [adjacents containsObject:@(idx)]) {
            status = !status;
        }
        [handeled addObject:@(status)];
    }];
    return handeled;
}


/**
 获取相邻索引
 
 @param index 当前被点击索引
 @param degree 阶数
 @return 相邻索引
 */
NSArray *adjacentBox(NSInteger index, NSInteger degree) {
    
    // 先列出边角
    NSUInteger up_left = 0;
    NSUInteger up_right = degree - 1;
    NSUInteger left_lower = pow(degree, 2) - degree;
    NSUInteger right_lower = pow(degree, 2) - 1;
    // 是边角
    if(index == up_left) {
        // 左上
        return @[@(index + 1),@(index + degree)];
    }
    if(index == up_right) {
        // 右上
        return @[@(index - 1),@(index + degree)];
    }
    if(index == left_lower) {
        // 左下
        return @[@(index - degree),@(index + 1)];
    }
    if(index == right_lower) {
        // 右下
        return @[@(index - 1),@(index - degree)];
    }
    // 是边线
    if(index > up_left && index < up_right) {
        // 上边线
        return @[@(index + degree),@(index - 1),@(index + 1)];
    }
    NSMutableArray *left_lines = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *right_lines = [NSMutableArray arrayWithCapacity:0];
    for(NSUInteger i = degree; i < degree * (degree - 1); i ++) {
        if(i % degree == 0) {
            [left_lines addObject:@(i)];
            [right_lines addObject:@(i + degree - 1)];
        }
    }
    if([left_lines containsObject:@(index)]) {
        // 左边线
        return @[@(index + 1),@(index - degree),@(index + degree)];
    }
    if([right_lines containsObject:@(index)]) {
        // 右边线
        return @[@(index - 1),@(index - degree),@(index + degree)];
    }
    if(index > left_lower && index < right_lower) {
        // 下边线
        return @[@(index - degree),@(index - 1),@(index + 1)];
    }
    // 其他
    return @[@(index - degree),@(index - 1),@(index + degree),@(index + 1)];
}

@end
