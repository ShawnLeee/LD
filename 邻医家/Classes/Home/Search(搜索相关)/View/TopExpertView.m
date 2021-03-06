//
//  TopExpertView.m
//  邻医家
//
//  Created by Daniel on 15/6/23.
//  Copyright (c) 2015年 DanielGrason. All rights reserved.
//
#import "Common.h"
#import "UIImage+MJ.h"
#import "Doctor.h"
#import "TopExpertView.h"
@interface TopExpertView ()
@property (nonatomic,strong) NSMutableArray *doctorBtns;
@end
@implementation TopExpertView
- (NSMutableArray *)doctorBtns
{
    if (_doctorBtns == nil) {
        _doctorBtns = [NSMutableArray array];
    }
    return _doctorBtns;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = BGCOLOR;
    }
    return self;
}
- (void)clickedBtn:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(topExpertView:clickedBtn:)]) {
        [self.delegate topExpertView:self clickedBtn:button];
    }
}
- (void)addDocBtns
{
    for (int i = 0 ; i < self.doctors.count; i++) {
        NSString *title = [self.doctors[i] name];
        
        UIButton *button = [self setupButtonWithTitle:title];
        button.tag = [self.doctors[i] id];
        [button addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.doctorBtns addObject:button];
    }
}
- (UIButton *)setupButtonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:button];
    return button;
}
- (void)setDoctors:(NSArray *)doctors
{
    _doctors = doctors;
    [self addDocBtns];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    const int columns = 3;
    const int padding = 10;
    CGFloat buttonW = (SCREENWIDTH - 4 * padding)/columns;
    CGFloat buttonH = 30;
    for ( int i = 0 ; i < self.doctorBtns.count; i++) {
        int currentColumn = i % columns;
        int currentRow = i / columns;
        CGFloat buttonX = currentColumn * (padding + buttonW) + padding;
        CGFloat buttonY = currentRow *(padding + buttonH) + padding;
        UIButton *button = [self.doctorBtns objectAtIndex:i];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}
@end
