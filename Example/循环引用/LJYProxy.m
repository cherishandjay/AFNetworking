//
//  LJYProxy.m
//  循环引用
//
//  Created by JeremyLu on 2019/3/14.
//  Copyright © 2019年 JeremyLu. All rights reserved.
//

#import "LJYProxy.h"

@implementation LJYProxy

- (void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}

@end
