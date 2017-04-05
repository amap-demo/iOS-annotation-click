//
//  ViewController.m
//  iOS-annotation-click
//
//  Created by shaobin on 2017/4/5.
//  Copyright © 2017年 autonavi. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface ViewController ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onClick:(UITapGestureRecognizer *)gesture {
    NSLog(@"=== annotation clicked");
    MAAnnotationView *annoView = (MAAnnotationView*) gesture.view;
    if(annoView.annotation == self.mapView.selectedAnnotations.firstObject) {
        if(annoView.selected == NO) {
            [annoView setSelected:YES animated:YES];
        }
        return;
    } else {
        [self.mapView selectAnnotation:annoView.annotation animated:YES];
    }
}

#pragma mark - mapview delegate
- (void)mapInitComplete:(MAMapView *)mapView {
    CLLocationCoordinate2D coordinates[9] = {
        {39.992520, 116.336170},
        {39.998293, 116.352343},
        {40.004087, 116.348904},
        {40.001442, 116.353915},
        {39.989105, 116.353915},
        {39.989098, 116.360200},
        {39.998439, 116.360201},
        {39.979590, 116.324219},
        {39.978234, 116.352792}};
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:9];
    for (int i = 0; i < 9; ++i)
    {
        MAPointAnnotation *a = [[MAPointAnnotation alloc] init];
        a.coordinate = coordinates[i];
        a.title      = [NSString stringWithFormat:@"anno:%d", i];
        [arr addObject:a];
    }

    [self.mapView addAnnotations:arr];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if(!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            [annotationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)]];
        }
        
        annotationView.image = [UIImage imageNamed:@"userPosition"];
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    
    return nil;
}

@end
