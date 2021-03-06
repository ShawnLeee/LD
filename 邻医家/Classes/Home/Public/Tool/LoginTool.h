//
//  LoginTool.h
//  邻医家
//
//  Created by Daniel on 15/5/21.
//  Copyright (c) 2015年 DanielGrason. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SignUpParam,LoginResult,ChangParam,BaseResult;
@interface LoginTool : NSObject
+ (void)loginWithParam:(SignUpParam *)param success:(void (^)(LoginResult *result))success failure:(void (^)(NSError *error))failure;
+ (void)changePWDWithParam:(ChangParam *)param success:(void (^)(BaseResult *result))success failure:(void  (^)(NSError *error))failure;
@end
