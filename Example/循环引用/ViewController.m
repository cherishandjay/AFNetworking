//
//  ViewController.m
//  循环引用
//
//  Created by JeremyLu on 2019/3/14.
//  Copyright © 2019年 JeremyLu. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()<NSURLSessionDelegate,NSURLSessionDataDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong) NSMutableData *mutableData;

@end


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionTask* task = nil;
    NSURL* url = [NSURL URLWithString:@"https://1z4-devmng2.myzmodo.com/zmd/common/globalconfig"];
//    task = [session dataTaskWithURL:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"clienttype=1&language=en&platform=2" dataUsingEncoding:NSUTF8StringEncoding];
    task = [session dataTaskWithRequest:request];
//  task = [session dataTaskWithURL:[NSURL URLWithString:@"https://1z4-devmng2.myzmodo.com/zmd/common/globalconfig?clienttype=1&language=en&platform=2"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//           NSDictionary * result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//           NSLog(@"字符串转到data，再转成json%@",result);
//       }];
    [task resume];

}

#pragma mark -- NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler{
 
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.mutableData appendData:data];
////    if ((dataTask.countOfBytesReceived - dataTask.countOfBytesExpectedToReceive) = 0) {
////
////    }
// NSLog(@"进度：%lld",dataTask.countOfBytesReceived/dataTask.countOfBytesExpectedToReceive);
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask willCacheResponse:(NSCachedURLResponse *)proposedResponse completionHandler:(void (^)(NSCachedURLResponse *cachedResponse))completionHandler
{
     if (completionHandler) {
        completionHandler(NULL);
    }
}


#pragma mark-- NSURLSessionDelegate
 
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    if (error == nil) {
          NSDictionary * result = [NSJSONSerialization JSONObjectWithData:self.mutableData options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"字符串转到data，再转成json%@",result);    }
}

/* If implemented, when a connection level authentication challenge
 * has occurred, this delegate will be given the opportunity to
 * provide authentication credentials to the underlying
 * connection. Some types of authentication will apply to more than
 * one request on a given connection to a server (SSL Server Trust
 * challenges).  If this delegate message is not implemented, the
 * behavior will be to use the default handling, which may involve user
 * interaction.
 */
//- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
// completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
//    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
//    __block NSURLCredential *credential = nil;
////    if (self.sessionDidReceiveAuthenticationChallenge) {
////           disposition = self.sessionDidReceiveAuthenticationChallenge(session, challenge, &credential);
////       } else {
////           if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
////               if ([self.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
//                   credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
////                   if (credential) {
////                       disposition = NSURLSessionAuthChallengeUseCredential;
////                   } else {
////                       disposition = NSURLSessionAuthChallengePerformDefaultHandling;
////                   }
////               } else {
//                   disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
////               }
////           } else {
////           }
////       }
//
//       if (completionHandler) {
//           completionHandler(disposition, credential);
//       }
//}

/* If an application has received an
 * -application:handleEventsForBackgroundURLSession:completionHandler:
 * message, the session delegate will receive this message to indicate
 * that all messages previously enqueued for this session have been
 * delivered.  At this time it is safe to invoke the previously stored
 * completion handler, or to begin any internal updates that will
 * result in invoking the completion handler.
 */
//- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
//{
//
//}



- (NSMutableData *)mutableData {
    if (!_mutableData) {
        _mutableData = [NSMutableData data];
    }
    return _mutableData;
}

@end
