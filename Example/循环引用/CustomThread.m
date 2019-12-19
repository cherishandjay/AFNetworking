//
//  CustomThread.m
//  循环引用
//
//  Created by zmodo on 2019/12/17.
//  Copyright © 2019 JeremyLu. All rights reserved.
//

#import "CustomThread.h"

@implementation CustomThread


- (void)dealloc
{
    NSLog(@"%s",__func__);
}
@end
