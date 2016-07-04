//
//  PharmacyStoreMapViewController.m
//  APP
//
//  Created by Meng on 15/5/5.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "PharmacyStoreMapViewController.h"
#import "CusAnnotationView.h"
#define SPAN  MACoordinateSpanMake(0.025, 0.025)
@interface PharmacyStoreMapViewController ()<MAMapViewDelegate>
{
    MAPointAnnotation *pointAnnotation;
}
@property (nonatomic ,strong) MAMapView *mapView;

@end

@implementation PharmacyStoreMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"位置";
    self.mapView = QWGLOBALMANAGER.mapView;
    [self.mapView setFrame:self.view.bounds];
    
    self.mapView.showsUserLocation = NO;
    self.mapView.delegate = self;
    
    
    pointAnnotation = [[MAPointAnnotation alloc] init];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.mapStoreModel.latitude doubleValue], [self.mapStoreModel.longitude doubleValue]);
    pointAnnotation.coordinate = coordinate;
    pointAnnotation.title = [NSString stringWithFormat:@"%@%@%@",self.mapStoreModel.province,self.mapStoreModel.city,self.mapStoreModel.addr];
    
    [self.mapView removeAnnotation:pointAnnotation];
    
    [self.mapView addAnnotation:pointAnnotation];
    
    [self.mapView setRegion:MACoordinateRegionMake(coordinate, SPAN) animated:YES];
    
    
    [self.view addSubview:self.mapView];
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        CusAnnotationView *annotationView = (CusAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[CusAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:customReuseIndetifier];
        }
        
        // must set to NO, so we can show the custom callout view.
        annotationView.canShowCallout   = NO;
        annotationView.calloutOffset    = CGPointMake(0, -5);
        annotationView.annTitle = [NSString stringWithFormat:@"%@%@%@",self.mapStoreModel.province,self.mapStoreModel.city,self.mapStoreModel.addr];
        [annotationView setSelected:YES animated:YES];
        return annotationView;
    }
    
    return nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.mapView removeAnnotation:pointAnnotation];
    self.mapView.delegate = nil;
    [super viewWillDisappear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
