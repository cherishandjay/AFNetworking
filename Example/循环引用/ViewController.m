//
//  ViewController.m
//  循环引用
//
//  Created by JeremyLu on 2019/3/14.
//  Copyright © 2019年 JeremyLu. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@property(nonatomic, strong)dispatch_source_t timer;

@property (nonatomic, copy) NSMutableArray *array;

@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableString* string = [NSMutableString stringWithString:@"a"];
     NSArray* array = @[@[string,@"b",@"c",@"d"],@"bb",@"cd",@"dd"];
   
     NSMutableArray * stringArray1  = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:array]];

    [string appendString:@"dddd"];
    NSLog(@"%@-%@",stringArray1,[array mutableCopy]);
     
//    __block NSInteger num = 0;
//    __weak typeof(self) weakself = self;
//    
    
//    NSTimer* timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        num ++;
////        NSLog(@"---%ld",num);
//        weakself.label.text = [NSString stringWithFormat:@"%ld",num];
//
//    }];
//    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
    /** GCD 定时器的使用 五大步 */
    
    /** step1 创建义个定时器类型的 Runlopp InputSource
     参数1:source的类型 timer
     参数2:对参数1的描述默认传0,
     参数3:对参数1的更详细描述默认传0,
     参数4:timer source 执行的队列 (mainQueue 主线程,非mainQueue 子线程)
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    
    
    
    /** step2: 设置runloop 的inputSource
     参数1: timer 类型的inputSource
     参数2: 从什么时间开始  DISPATCH_TIME_NOW 现在
     参数3: 定时间个时间 2秒1次
     参数4: 允许的定时误差,0 表示精准
     
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    
    /** step3: 定时器执行的事件 */
//    dispatch_source_set_event_handler(timer, ^{
//        num ++;
//         weakself.label.text = [NSString stringWithFormat:@"%ld",num];
//        NSLog(@"timer heart beats");
//    });
    
    /**step4: 开启定时器 (定时器默认是挂起的) */
    dispatch_resume(timer);
    
    /** step5:  包住定时器的名 */
    self.timer = timer;
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    dispatch_queue_t queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
     dispatch_queue_t queue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    //1.异步函数
    dispatch_async(queue, ^{
        for (NSInteger i =0 ; i < 5 ; i++){
            NSLog(@"download1 -- %zd -- %@",i,[NSThread currentThread]);
         }
    });

    dispatch_async(queue, ^{
        for (NSInteger i =0 ; i < 5 ; i++){
            NSLog(@"download2 -- %zd -- %@",i,[NSThread currentThread]);
 
        }
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"++++++++++++++-- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3];
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i =0 ; i < 5 ; i++){
            NSLog(@"download3 -- %zd -- %@",i,[NSThread currentThread]);
        }
    });
    
//    dispatch_barrier_sync(queue, ^{
//        NSLog(@"+++++++++++++++");
//    });
    
    dispatch_async(queue, ^{
        for (NSInteger i =0 ; i < 5 ; i++){
            NSLog(@"download4 -- %zd -- %@",i,[NSThread currentThread]);
        }
    });
    
    
}


- (void)test {
    
    NSLog(@"viewcontroller");
}
@end
