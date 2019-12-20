//
//  ViewController.m
//  循环引用
//
//  Created by JeremyLu on 2019/3/14.
//  Copyright © 2019年 JeremyLu. All rights reserved.
//

#import "ViewController.h"
#import "ZSWebInterface.h"


@interface ViewController ()<NSURLSessionDelegate,NSURLSessionDataDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;


@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    NSOperationQueue* queue = [[NSOperationQueue alloc]init];
//    queue.name = @"subthread";
//    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:queue];
//    NSURLSessionTask* task = nil;
//    NSURL* url = [NSURL URLWithString:@"https://1z4-devmng2.myzmodo.com/zmd/common/globalconfig"];
//    task = [session dataTaskWithURL:url];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = @"POST";
//    request.HTTPBody = [@"clienttype=1&language=en&platform=2" dataUsingEncoding:NSUTF8StringEncoding];
//    task = [session dataTaskWithRequest:request];
//  task = [session dataTaskWithURL:[NSURL URLWithString:@"https://1z4-devmng2.myzmodo.com/zmd/common/globalconfig?clienttype=1&language=en&platform=2"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//           NSDictionary * result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//           NSLog(@"字符串转到data，再转成json%@",result);
//       }];
//    [task resume];

    [[ZSWebInterface sharedInstance]taskIndentifierCoreWebInterfaceWithPostRequest:@"common/globalconfig" pararms:@{@"clienttype":@"1",@"language":@"en",@"platform":@"2"} success:^(NSDictionary * _Nonnull data) {
        NSLog(@"success:%@",data);
    } failure:^(NSDictionary * _Nonnull data) {
        NSLog(@"Failure:%@",data);
    }];
    
}


@end
