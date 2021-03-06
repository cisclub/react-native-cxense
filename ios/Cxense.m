#import "Cxense.h"
@import CxenseSDK;

@implementation Cxense

RCT_EXPORT_MODULE(Cxense)

RCT_EXPORT_METHOD(initWithUsername:(NSString *)username
                  apiKey:(NSString *)apiKey
                  completionHandler:(RCTResponseSenderBlock)completionHandler)
{
    CXConfiguration *config = [[CXConfiguration alloc] initWithUserName:username
                                                                 apiKey:apiKey];
#if DEBUG
    [config setEventsCallback:^(NSString * _Nonnull data, BOOL success, NSError * _Nullable err) {
        NSLog(@"CXense event Callback: event:%@ - succeeded:%i - error:%@", data, success, err.description);
    }];
#endif
    NSError *error = nil;
    [CXCxense initializeWithConfiguration:config
                                    error:&error :^{
        if(error != nil) {
            completionHandler(@[error]);
        } else {
            completionHandler(nil);
        }
    }];
}

RCT_EXPORT_METHOD(trackEventWithName:(NSString *)name
                  siteID:(NSString *)siteID
                  location:(nullable NSString *)location
                  userprofileParameterKey:(nullable NSString *)profileKey value:(nullable NSString *)profileValue
                  customParameterKey:(nullable NSString *)customKey value:(nullable NSString *)customValue
                  extraParameterKey:(nullable NSString *)extraKey value:(nullable NSString *)extraValue
completionHandler:(RCTResponseSenderBlock)completionHandler)
{
    CXPageViewEventBuilder *builder = [CXPageViewEventBuilder makeBuilderWithName:name
                                                                           siteId:siteID];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-result"
    if (location) {
        [builder setLocation:location];
    }
    if (profileKey != nil && profileValue != nil) {
        [builder addUserProfileParameterForKey:profileKey
                                     withValue:profileValue];
    }
    if (customKey != nil && customValue != nil) {
        [builder addCustomParameterForKey:customKey
                                withValue:customValue];
    }
    if (extraKey != nil && extraValue != nil) {
        [builder addParameterForKey:extraKey
                          withValue:extraValue];
    }
#pragma GCC diagnostic pop
    
    NSError *error;
    CXPageViewEvent *event = [builder build:&error];
    if (error != nil) {
        completionHandler(@[error]);
    } else {
        [CXCxense reportEvent:event];
        completionHandler(nil);
    }
}

RCT_EXPORT_METHOD(flushQueue) {
    [CXCxense flushEventQueue];
}

@end
