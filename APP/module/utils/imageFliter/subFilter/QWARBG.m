//
//  1.m
//  QWCore
//
//  Created by QW on 12-11-22.
//
//

#import "QWARBG.h"

@implementation QWARBG



+(QWImagePoint)getPointFromData:(NSData *)imageData
                      pointIndex:(CGPoint)pointIndex
                       imageSize:(CGSize)imageSize
{
    int bitmapBytesPerRow = imageSize.width*4;
    
    NSUInteger index = pointIndex.x* 4 + (pointIndex.y * bitmapBytesPerRow);
    
    const unsigned char * bytes = (const unsigned char *)[imageData bytes];
    
    QWImagePoint point = {0};
    point.alpha = bytes[index];
    point.red = bytes[index+1];
    point.green = bytes[index+2];
    point.blue = bytes[index+3];
    

    
    return point;
}

+(QWImagePoint)getPointFromData:(NSData *)imageData
                           index:(int)index
                       imageSize:(CGSize)imageSize
{
    int bitmapBytesPerRow = imageSize.width;
    
    int x = index%bitmapBytesPerRow;
    int y = index/bitmapBytesPerRow;
    
    return [QWARBG getPointFromData:imageData pointIndex:CGPointMake(x,y) imageSize:imageSize];
}

+(void)printPoint:(QWImagePoint)point
{
    DDLogVerbose(@"a=%d,r=%d,g=%d,b=%d",point.alpha,point.red,point.green,point.blue);
}
@end