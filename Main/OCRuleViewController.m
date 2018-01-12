//
//  OCRuleViewController.m
//  28Occupy
//
//  Created by Jinjun liang on 2018/1/9.
//  Copyright © 2018年 LK. All rights reserved.
//

#import "OCRuleViewController.h"
#import <Masonry.h>

@interface OCRuleViewController ()

@end

@implementation OCRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedStringFromTable(@"RULE", @"Localization", nil);
    NSString *ruleString = NSLocalizedStringFromTable(@"RULE_CONTENT", @"Localization", nil);
    UILabel *rule = [[UILabel alloc] init];
    rule.font = [UIFont systemFontOfSize:16];
    rule.textColor = RGB(102, 102, 102);
    rule.numberOfLines = 0;
    [self.view addSubview:rule];
    CGFloat nav_h = CGRectGetHeight(self.navigationController.navigationBar.frame) + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    [rule mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(nav_h + 10.f);
    }];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:ruleString];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8.f;
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [ruleString length])];
    rule.attributedText = attributedString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
