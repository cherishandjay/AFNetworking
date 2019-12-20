//
//  TaskObject.m
//  循环引用
//
//  Created by zmodo on 2019/12/20.
//  Copyright © 2019 JeremyLu. All rights reserved.
//

#import "TaskObject.h"

@implementation TaskObject

-(instancetype)initWithTask:(NSURLSessionTask*)task
{
    if (self = [super init]) {
        self.task = task;
    }
    return self;
}


- (NSMutableData *)mutableData {
    if (!_mutableData) {
        _mutableData = [NSMutableData data];
    }
    return _mutableData;
}

@end
