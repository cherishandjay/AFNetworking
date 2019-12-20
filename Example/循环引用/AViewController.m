//
//  AViewController.m
//  循环引用
//
//  Created by zmodo on 2019/12/20.
//  Copyright © 2019 JeremyLu. All rights reserved.
//

#import "AViewController.h"
#import "ZSWebInterface.h"

@interface AViewController ()

@property (nonatomic, copy) SuccessHanler success;
@end

@implementation AViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view, typically from a nib.
    self.success = ^(NSDictionary * _Nonnull data) {
        NSLog(@"%@",data);
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
 
    __weak typeof(self) weakself = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSInteger identifier = [[ZSWebInterface sharedInstance]taskIndentifierCoreWebInterfaceWithPostRequest:@"common/globalconfig" pararms:@{@"clienttype":@"1",@"language":@"en",@"platform":@"2"} success:^(NSDictionary * _Nonnull data) {
//                  NSLog(@"ZSWebInterface:%@",data);
////            if (weakself == nil) {
////                return ;
////            }
//            weakself.view.backgroundColor = [UIColor whiteColor];
////            weakself.success(data);
//
//              } failure:^(NSDictionary * _Nonnull data) {
//                  NSLog(@"Failure:%@",data);
//              }];
//           });
   
    TaskObject* objc = [TaskObject new];
    objc.successBlock = ^(NSDictionary * _Nonnull data) {
        NSLog(@"data:%@",data);
    };
    objc = nil;
    
    objc.successBlock(@{@"1":@"3"});
    
}


- (void)dealloc
{
    NSLog(@"AViewController dealloc");
}

@end
