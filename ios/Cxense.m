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
    NSError *error = nil;
    [CXCxense initializeWithConfiguration:config
                                    error:&error :^{
        completionHandler(@[error]);
    }];
}

RCT_EXPORT_METHOD(trackEventWithName:(NSString *)name
                  siteID:(NSString *)siteID
                  location:(nullable NSString *)location
                  userprofileParameterKey:(nullable NSString *)profileKey value:(nullable NSString *)profileValue
                  customParameterKey:(nullable NSString *)customKey value:(nullable NSString *)customValue
                  extraParameterKey:(nullable NSString *)extraKey value:(nullable NSString *)extraValue)
{
    CXPageViewEventBuilder *builder = [CXPageViewEventBuilder makeBuilderWithName:name
                                                                           siteId:siteID];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-result"
    [builder setLocation:location];
    [builder addUserProfileParameterForKey:profileKey
                                 withValue:profileValue];
    [builder addCustomParameterForKey:customKey
                            withValue:customValue];
    [builder addParameterForKey:extraKey
                      withValue:extraValue];
#pragma GCC diagnostic pop
    
    NSError *error;
    CXPageViewEvent *event = [builder build:&error];
    [CXCxense reportEvent:event];
}

@end
