//
//  OCHomeViewController.m
//  28Occupy
//
//  Created by Jinjun liang on 2018/1/9.
//  Copyright © 2018年 LK. All rights reserved.
//

#import "OCHomeViewController.h"
#import "OCBoxCollectionViewCell.h"
#import <Masonry.h>
#import "OCCalculate.h"
#import "OCRuleViewController.h"
#import "OCColor.h"

static const CGFloat kMargin = 15.f;
static const CGFloat kLineSpacing = 1.0;
static NSString *const kBoxCell = @"boxcell";
#define kLineColor RGB(122, 122, 122)

@interface OCHomeViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSUInteger boxDegree;   // 阶数
}

@property (nonatomic, strong) UICollectionView *boxCollectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *boxLayout;

@property (nonatomic, strong) UISegmentedControl *boxSegcontrol;

@property (nonatomic, strong) NSArray *boxDegreeArray;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSArray *boxColors;
@property (nonatomic, strong) NSArray *boxTextFonts;
@property (nonatomic, assign) CGFloat fontSize;

@end

@implementation OCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rule = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTable(@"RULE", @"Localization", nil) style:UIBarButtonItemStyleDone target:self action:@selector(rule)];
    self.navigationItem.rightBarButtonItem = rule;
    
    [self setupSeg];
    [self setupBox];
}

- (void)rule
{
    [self.navigationController pushViewController:[OCRuleViewController new] animated:YES];
}

- (void)setupSeg {
    
    // 目前支持3-6阶数
    _boxDegreeArray = @[@"3",@"4",@"5",@"6",@"7"];
    _boxSegcontrol = [[UISegmentedControl alloc] initWithItems:_boxDegreeArray];
    [self.view addSubview:_boxSegcontrol];
    CGFloat nav_h = CGRectGetHeight(self.navigationController.navigationBar.frame) + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    [_boxSegcontrol mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(nav_h + 20.f);
        make.left.mas_equalTo(35.f);
        make.right.mas_equalTo(-35.f);
        make.height.mas_equalTo(40.f);
    }];
    _boxSegcontrol.tintColor = [OCColor occupiedColor];
    _boxSegcontrol.selectedSegmentIndex = 0;
    [_boxSegcontrol addTarget:self action:@selector(degreeChange:) forControlEvents:UIControlEventValueChanged];
    [self setupDegree:[[_boxDegreeArray firstObject] integerValue]];
}

- (void)degreeChange:(UISegmentedControl *)segment {
    
    [self setupDegree:[_boxDegreeArray[segment.selectedSegmentIndex] integerValue]];
    self.fontSize = [self.boxTextFonts[segment.selectedSegmentIndex] floatValue];
}

- (void)setupDegree:(NSUInteger )degree {
    
    // 初始化阶数
    boxDegree = degree;
    [self.dataSource removeAllObjects];
    for(int i = 0; i < pow(boxDegree, 2); i ++) {
        [self.dataSource addObject:@(NO)];
    }
    if(self.boxCollectionView) {
        [_boxCollectionView reloadData];
    }
}

- (void)setupBox {
    
    self.view.backgroundColor = RGB(249, 249, 249);
    _boxLayout = [[UICollectionViewFlowLayout alloc] init];
    _boxLayout.minimumLineSpacing = kLineSpacing;
    _boxLayout.minimumInteritemSpacing = kLineSpacing;
    _boxCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.boxLayout];
    _boxCollectionView.dataSource = self;
    _boxCollectionView.delegate = self;
    _boxCollectionView.backgroundColor = kLineColor;
    _boxCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_boxCollectionView];
    [_boxCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_boxSegcontrol.mas_bottom).with.offset(25.f);
        make.left.mas_equalTo(kMargin);
        make.right.mas_equalTo(-kMargin);
        make.height.equalTo(_boxCollectionView.mas_width);
    }];
    [_boxCollectionView registerClass:[OCBoxCollectionViewCell class] forCellWithReuseIdentifier:kBoxCell];
    
    UIView *line_top = frameline();
    [self.view addSubview:line_top];
    UIView *line_left = frameline();
    [self.view addSubview:line_left];
    UIView *line_bottom = frameline();
    [self.view addSubview:line_bottom];
    UIView *line_right = frameline();
    [self.view addSubview:line_right];
    [line_top mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_boxCollectionView.mas_left);
        make.height.mas_equalTo(kLineSpacing);
        make.width.equalTo(_boxCollectionView.mas_width);
        make.bottom.equalTo(_boxCollectionView.mas_top);
    }];
    [line_left mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line_top.mas_top);
        make.right.equalTo(_boxCollectionView.mas_left);
        make.width.mas_equalTo(kLineSpacing);
        make.bottom.equalTo(line_bottom.mas_top);
    }];
    [line_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_boxCollectionView.mas_bottom);
        make.left.equalTo(line_left.mas_left);
        make.right.equalTo(line_right.mas_left);
        make.height.mas_equalTo(kLineSpacing);
    }];
    [line_right mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_boxCollectionView.mas_right);
        make.top.equalTo(line_top.mas_top);
        make.width.mas_equalTo(kLineSpacing);
        make.bottom.equalTo(line_bottom.mas_bottom);
    }];
    
    // 多颜色选择
    //_boxColors = @[RGB(244, 89, 27),RGB(220, 82, 74),RGB(23, 145, 205),RGB(58, 219, 255),RGB(35, 160, 96),RGB(254, 205, 81),RGB(149, 156, 157)];
    _boxColors = @[@"220,82,74",@"254,205,81",@"58,219,255",@"35,160,96",@"23,145,205",@"149,156,157", @"229,89,27"];
    _boxTextFonts = @[@(40), @(38), @(32), @(28), @(20)];
    self.fontSize = 40;
    [self setupColorsView:_boxColors];
}

- (void)setupColorsView:(NSArray *)colors {
    
    CGFloat margin = 10.f;
    CGFloat colorWidthHeight = (kScreenWidth - margin * (colors.count + 1)) / colors.count;
    __block UIView *lastView = nil;
    [colors enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = idx;
        button.backgroundColor = [OCColor transformColor:obj];
        [button addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        if(lastView) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(lastView.mas_right).with.offset(margin);
                make.top.equalTo(lastView);
                make.width.height.equalTo(lastView);
            }];
        }
        else {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(margin);
                make.top.equalTo(_boxCollectionView.mas_bottom).with.offset(15.f);
                make.width.height.mas_equalTo(colorWidthHeight);
            }];
        }
        lastView = button;
        
    }];
    UIButton *random = [UIButton buttonWithType:UIButtonTypeCustom];
    random.tag = 100;
    [self.view addSubview:random];
    [random addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
    [random setTitle:NSLocalizedStringFromTable(@"RANDOM", @"Localization", nil) forState:UIControlStateNormal];
    random.backgroundColor = [OCColor occupiedColor];
    [random mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_bottom).offset(20.f);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(colorWidthHeight * 2.f, colorWidthHeight));
    }];
}

- (void)changeColor:(UIButton *)sender {
    NSString *colorString = _boxColors[0];
    if (sender.tag == 100) {
        colorString = [self randomColor];
        sender.backgroundColor = [OCColor transformColor:colorString];
    } else {
        colorString = _boxColors[sender.tag];
    }
    [OCColor changeColor:colorString];
    _boxSegcontrol.tintColor = [OCColor occupiedColor];
    [_boxCollectionView reloadData];
}

- (NSString *)randomColor
{
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    NSString *randColorString = [NSString stringWithFormat:@"%ld,%ld,%ld", aRedValue, aGreenValue, aBlueValue];
    return randColorString;
}


UIView *frameline() {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kLineColor;
    return line;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return pow(boxDegree, 2);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (CGRectGetWidth(collectionView.bounds) - kLineSpacing * (boxDegree - 1)) / boxDegree;
    CGFloat height = width;
    return CGSizeMake(width, height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    OCBoxCollectionViewCell *cell = (OCBoxCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kBoxCell forIndexPath:indexPath];
    BOOL isOccupyed = [self.dataSource[indexPath.row] boolValue];
    cell.label.text = isOccupyed ? @"2" : @"8";
    cell.label.font = [UIFont systemFontOfSize:self.fontSize];
    cell.backgroundColor = isOccupyed?[OCColor occupiedColor]:[UIColor whiteColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = [NSArray arrayWithArray:self.dataSource];
    [self.dataSource removeAllObjects];
    [newBoxs(indexPath.row, array) enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self.dataSource addObject:obj];
    }];
    [_boxCollectionView reloadData];
}

- (NSMutableArray *)dataSource {
    
    if(!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
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

