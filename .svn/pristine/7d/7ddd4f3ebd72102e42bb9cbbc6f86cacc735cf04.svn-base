 

#import "QWWebView.h"

@implementation QWWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (CGFloat)getWebViewHeight{
    
    if(self.loading){
        return 0.0f;
    }else{
        return [[self stringByEvaluatingJavaScriptFromString:@"document.getElementById('bizInfo').scrollHeight"] floatValue];
    }
}

-(void)dealloc
{
  
}

@end
