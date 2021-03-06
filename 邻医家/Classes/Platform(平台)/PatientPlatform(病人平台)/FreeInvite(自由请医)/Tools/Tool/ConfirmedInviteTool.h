//
//  ConfirmedInviteTool.h
//  邻医家
//
//  Created by Daniel on 15/6/15.
//  Copyright (c) 2015年 DanielGrason. All rights reserved.
//
@class AllInviteParam,AllInviteResult;
#import <Foundation/Foundation.h>

@interface ConfirmedInviteTool : NSObject
+ (void)confirmedInviteDataWithParam:(AllInviteParam *)param
                             success:(void (^)(AllInviteResult *result))success
                             failure:(void (^)(NSError *error))failure;
@end
