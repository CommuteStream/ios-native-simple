@import Foundation;

#import "Csnmessages.pbobjc.h"

@interface CSNAdReportsBuilder : NSObject
- (instancetype) initWithAdUnit:(NSData *)adUnit deviceID:(CSNPDeviceID *)deviceID ipAddresses:(NSArray<NSData *>*)ipAddresses timeZone:(NSString *)timeZone;
- (void) recordVisibility:(uint64_t)requestID adID:(uint64_t)adID versionID:(uint64_t)versionID componentID:(uint64_t)componentID viewVisibility:(double)viewVisiblity deviceVisibility:(double)deviceVisibility;
- (void) recordInteraction:(uint64_t)requestID adID:(uint64_t)adID versionID:(uint64_t)versionID componentID:(uint64_t)componentID interactionKind:(int32_t)interactionKind;
- (CSNPAdReports *) buildReport;
@end
