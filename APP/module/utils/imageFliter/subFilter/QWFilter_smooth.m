//
//  QWFilter_smooth.m
//  QWCore
//
//  Created by QW on 12-11-22.
//
//

#import "QWFilter_smooth.h"
#import "QWARBG.h"

@implementation QWFilter_smooth

@synthesize m_imageData;


//必须奇数
#define Matrix_Num 3

-(id)initWithImage:(NSData *)imageData imageSize:(CGSize)imageSize
{
    self = [super init];
    if (self) {
        m_imageData = imageData  ;
        m_imageSize = imageSize;
    }
    return self;
}

-(void)dealloc
{
 
}

-(QWImagePoint)getSmoothPoint:(int)index
{
    int bitmapBytesPerRow = m_imageSize.width;
    int bitmapRow = m_imageSize.height;
    
    int x = index%bitmapBytesPerRow;
    int y = index/bitmapBytesPerRow;
    int matrixHalf = Matrix_Num/2;
    
    
    //点在图片边上
    //行
    if (x<matrixHalf || x > bitmapBytesPerRow - matrixHalf ||
        y<matrixHalf || y > bitmapRow - matrixHalf) {
        return [QWARBG getPointFromData:m_imageData index:index imageSize:m_imageSize];
    }
    
    //矩阵中各值之和
    int t_r = 0;
    int t_g = 0;
    int t_b = 0;
    Byte a = 0;
    
    
    for (int i = x - matrixHalf; i<= x + matrixHalf; i++) {
        
        for (int j = y - matrixHalf; j<= y + matrixHalf; j++) {
            QWImagePoint point = [QWARBG getPointFromData:m_imageData
                                                 pointIndex:CGPointMake(i, j)
                                                  imageSize:m_imageSize];
            t_r +=point.red;
            t_g +=point.green;
            t_b +=point.blue;
            
            if (i == x && j == y) {
                a = point.alpha;
                
            
            }
        }
        
        
    }
    
    
    QWImagePoint newPoint;
    newPoint.alpha = a;
    newPoint.red = t_r/(Matrix_Num * Matrix_Num);
    newPoint.green = t_g/(Matrix_Num * Matrix_Num);
    newPoint.blue = t_b/(Matrix_Num * Matrix_Num);

    
    return newPoint;
}

-(NSData *)getNewImageData
{
    
    NSMutableData * newData = [[NSMutableData alloc] init];
    
    for (int i = 0 ; i<m_imageSize.width * m_imageSize.height; i++) {
    
        
        QWImagePoint point = [self getSmoothPoint:i];
        
        [newData appendBytes:&point.alpha length:sizeof(char)];
        [newData appendBytes:&point.red length:sizeof(char)];
        [newData appendBytes:&point.green length:sizeof(char)];
        [newData appendBytes:&point.blue length:sizeof(char)];
        
    }
    

    return  newData  ;
}

@end
