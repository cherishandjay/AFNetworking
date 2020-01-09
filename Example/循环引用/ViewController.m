//
//  ViewController.m
//  循环引用
//
//  Created by JeremyLu on 2019/3/14.
//  Copyright © 2019年 JeremyLu. All rights reserved.
//

#import "ViewController.h"
#import "ZSWebInterface.h"
#import "HKtextfield.h"


@interface ViewController ()<NSURLSessionDelegate,NSURLSessionDataDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;


@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITextView* text = [[UITextView alloc]initWithFrame:CGRectMake(100, 120, 120, 84)];
    text.backgroundColor = [UIColor lightGrayColor];
    text.text = @"AVFFF";
    [self.view addSubview:text];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
//    NSInteger identifier = [[ZSWebInterface sharedInstance]taskIndentifierCoreWebInterfaceWithPostRequest:@"common/globalconfig" pararms:@{@"clienttype":@"1",@"language":@"cn",@"platform":@"2"} success:^(NSDictionary * _Nonnull data) {
//        NSLog(@"success:%@",data);
//    } failure:^(NSDictionary * _Nonnull data) {
//        NSLog(@"Failure:%@",data);
//    }];
//
//    [[ZSWebInterface sharedInstance]cacelTaskId:identifier];
    
    [self.navigationController pushViewController:[NSClassFromString(@"AViewController") new] animated:YES];
    
}

@end
