//
//  AchieveMentCell.h
//  邻医家
//
//  Created by Daniel on 15/6/11.
//  Copyright (c) 2015年 DanielGrason. All rights reserved.
//
@class LDPaper;
#import <UIKit/UIKit.h>

@interface AchieveMentCell : UITableViewCell
@property (nonatomic,strong) LDPaper *paper;
+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@end
