//
//  LJYProxy.h
//  循环引用
//
//  Created by JeremyLu on 2019/3/14.
//  Copyright © 2019年 JeremyLu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJYProxy : NSProxy

@property (nonatomic ,weak)id target;

@end

NS_ASSUME_NONNULL_END
