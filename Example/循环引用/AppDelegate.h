//
//  AppDelegate.h
//  循环引用
//
//  Created by JeremyLu on 2019/3/14.
//  Copyright © 2019年 JeremyLu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomThread.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) CustomThread *thread;

@end

