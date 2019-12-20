//
//  TaskObject.h
//  循环引用
//
//  Created by zmodo on 2019/12/20.
//  Copyright © 2019 JeremyLu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessHanler)(NSDictionary*);

typedef void(^FailureHanler)(NSDictionary*);

@interface TaskObject : NSObject

@property (nonatomic, strong) NSURLSessionTask *task;

@property (nonatomic, strong) NSMutableData *mutableData;

@property (nonatomic, copy) SuccessHanler successBlock;

@property (nonatomic, copy) FailureHanler failureBlock;

- (instancetype)initWithTask:(NSURLSessionTask*)task;

@end

NS_ASSUME_NONNULL_END
