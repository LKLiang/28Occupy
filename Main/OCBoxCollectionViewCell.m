//
//  OCBoxCollectionViewCell.m
//  28Occupy
//
//  Created by Jinjun liang on 2018/1/9.
//  Copyright © 2018年 LK. All rights reserved.
//

#import "OCBoxCollectionViewCell.h"

@interface OCBoxCollectionViewCell()

@property (nonatomic, strong) UILabel *label;

@end

@implementation OCBoxCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.label setFrame:self.bounds];
}

- (UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:32];
    }
    return _label;
}

@end
