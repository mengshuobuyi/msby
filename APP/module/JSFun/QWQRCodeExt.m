

#import "QWQRCodeExt.h"
#import "QWWebViewController.h"

#define SUCCESS 0
#define UNKNOWN_ERROR 1
#define OPEN_SMS_FAIL_ERROR 2

@implementation QWQRCodeExt

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"QRCODE_SCAN" object:nil];
}

-(void)scanQRCode:(NSArray *)arguments withDict:(NSDictionary *)options{
    DDLogVerbose(@"THE arguments is %@, the dic is %@",arguments, options);
    NSString* callbackId = [arguments objectAtIndex:0];
    self.jsCallbackId_ = callbackId;

}

- (void)callBackCalled
{
        dispatch_async(dispatch_get_main_queue(), ^{
    [self writeScript:self.jsCallbackId_ messageString:@"aaa" state:SUCCESS keepCallback:NO];
            
             });
}

- (void)scanSuccess:(NSString *)qrcodeStr
{
      [self writeScript:self.jsCallbackId_ messageString:qrcodeStr state:SUCCESS keepCallback:NO];
}

@end
