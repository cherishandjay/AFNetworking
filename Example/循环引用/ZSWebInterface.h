//
//  ZSWebInterface.h
//  循环引用
//
//  Created by zmodo on 2019/12/20.
//  Copyright © 2019 JeremyLu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZSWebInterface : NSObject

+(instancetype)sharedInstance;

- (NSUInteger)taskIndentifierCoreWebInterfaceWithPostRequest:(NSString *)requestPath
                                pararms:(NSDictionary *)dict
                                success:(void (^)(NSDictionary *))success
                                                     failure:(void (^)(NSDictionary *))failure;

- (void)cacelTaskId:(NSInteger)taskId;

@end

NS_ASSUME_NONNULL_END
