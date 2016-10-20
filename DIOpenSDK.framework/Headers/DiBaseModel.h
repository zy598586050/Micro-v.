//
//  DiBaseModel.h
//  DIOpenSDK
//
//  Created by gr4yk3r on 15/10/19.
//  Copyright © 2015年 com.xiaojukeji.didiOpenSdk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DIBaseModel : NSObject
@property (nonatomic, strong) NSString      *errCode;/** < 0:成功，其它错误码*/
@property (nonatomic, strong) NSString      *errmsg;/** < */
@property (nonatomic, strong) NSDictionary  *data;

- (BOOL)isValid;

-(DIBaseModel *)initWithDict:(NSDictionary *)dicData;

@end
