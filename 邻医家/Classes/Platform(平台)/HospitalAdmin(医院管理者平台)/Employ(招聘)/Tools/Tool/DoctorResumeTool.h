//
//  DoctorResumeTool.h
//  邻医家
//
//  Created by Daniel on 15/6/12.
//  Copyright (c) 2015年 DanielGrason. All rights reserved.
//
@class EmployDetailParam,DoctorResumeResult;
#import <Foundation/Foundation.h>

@interface DoctorResumeTool : NSObject
+ (void)getDoctorResumeWithParam:(EmployDetailParam *)param
                         success:(void (^)(DoctorResumeResult *result))success
                         failure:(void (^)(NSError *error))failure;
@end
