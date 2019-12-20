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
     NSInteger identifier = [[ZSWebInterface sharedInstance]taskIndentifierCoreWebInterfaceWithPostRequest:@"common/globalconfig" pararms:@{@"clienttype":@"1",@"language":@"en",@"platform":@"2"} success:^(NSDictionary * _Nonnull data) {
        if (weakself.success) {
            weakself.success(data);
        }

          } failure:^(NSDictionary * _Nonnull data) {
              NSLog(@"Failure:%@",data);
          }];
//    [[ZSWebInterface sharedInstance]cacelTaskId:identifier];
   
}


- (void)dealloc
{
    NSLog(@"AViewController dealloc");
    self.success = nil;
    
}

@end
