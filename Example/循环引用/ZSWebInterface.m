//
//  ZSWebInterface.m
//  循环引用
//
//  Created by zmodo on 2019/12/20.
//  Copyright © 2019 JeremyLu. All rights reserved.
//

#import "ZSWebInterface.h"
#import "TaskObject.h"

@interface ZSWebInterface()<NSURLSessionDelegate,NSURLSessionDataDelegate>

@property (nonatomic, strong) NSOperationQueue *myqueue;

@property (nonatomic, strong) NSURLSession *session;

@property (nonatomic, strong) NSString *baseUrlString;

@property (nonatomic, strong) NSMutableDictionary<NSNumber*,TaskObject *>*taskDic;

@end


@implementation ZSWebInterface

static ZSWebInterface* objc = nil;

- (instancetype)init{

    if (self = [super init]) {
        [self createSession];
    }
    return self;

}

+(instancetype)sharedInstance
{
     static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objc = [[super allocWithZone:NULL]init];
    });
    return objc;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [ZSWebInterface sharedInstance];
}


- (void)createSession {
    
    NSOperationQueue* queue = [[NSOperationQueue alloc]init];
    self.myqueue = queue;
    queue.name = @"subthread";
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:queue];
    self.baseUrlString = @"https://1z4-devmng2.myzmodo.com/zmd/";
    
}


- (NSUInteger)taskIndentifierCoreWebInterfaceWithPostRequest:(NSString *)requestPath
                                pararms:(NSDictionary *)dict
                                success:(void (^)(NSDictionary *))success
                                failure:(void (^)(NSDictionary *))failure
{
    //@"clienttype=1&language=en&platform=2"
    NSURLSessionTask* task = nil;
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.baseUrlString,requestPath]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [AFQueryStringFromParameters(dict) dataUsingEncoding:NSUTF8StringEncoding];
    task = [self.session dataTaskWithRequest:request];
      //  task = [session dataTaskWithURL:[NSURL URLWithString:@"https://1z4-devmng2.myzmodo.com/zmd/common/globalconfig?clienttype=1&language=en&platform=2"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      //           NSDictionary * result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
      //           NSLog(@"字符串转到data，再转成json%@",result);
      //       }];
    [task resume];
    TaskObject* taskobjc = [[TaskObject alloc]initWithTask:task];
    taskobjc.successBlock = success;
    taskobjc.failureBlock = failure;
    
    [self.taskDic setObject:taskobjc forKey:@(task.taskIdentifier)];
    
    return task.taskIdentifier;
}

NSString * AFQueryStringFromParameters(NSDictionary *parameters) {
    __block NSMutableArray *mutablePairs = [NSMutableArray array];
//    for (AFQueryStringPair *pair in AFQueryStringPairsFromDictionary(parameters)) {
//        [mutablePairs addObject:[pair URLEncodedStringValue]];
//    }
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [mutablePairs addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
    }];
    return [mutablePairs componentsJoinedByString:@"&"];
}


#pragma mark -- NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler{
 
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.taskDic[@(dataTask.taskIdentifier)].mutableData appendData:data];
    
    
    NSLog(@"%@",[NSThread currentThread]);
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
    TaskObject* objctask = self.taskDic[@(task.taskIdentifier)];
    if (error == nil) {
        NSDictionary * result = [NSJSONSerialization JSONObjectWithData:objctask.mutableData options:NSJSONReadingMutableLeaves error:nil];
        objctask.successBlock(result);
        [self.taskDic removeObjectForKey:@(task.taskIdentifier)];
//        NSLog(@"%@的result:%@",objctask.task.originalRequest.URL.absoluteString,result);
    }else{
        objctask.failureBlock([error userInfo]);
        [self.taskDic removeObjectForKey:@(task.taskIdentifier)];
    }
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

 

- (NSMutableDictionary *)taskDic {
    if (!_taskDic) {
        _taskDic = [NSMutableDictionary dictionary];
    }
    return _taskDic;
}


@end
