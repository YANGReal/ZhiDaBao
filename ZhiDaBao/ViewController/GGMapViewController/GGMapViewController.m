//
//  GGMapViewController.m
//  GG
//
//  Created by YANGReal on 14-9-22.
//  Copyright (c) 2014年 GG. All rights reserved.
//

#import "GGMapViewController.h"

@interface GGMapViewController ()<MKMapViewDelegate>
@property  (weak , nonatomic) IBOutlet MKMapView *mapView;
@property (weak , nonatomic) IBOutlet UILabel *placeLabel;
@property (copy , nonatomic) NSString *place;
@property (assign , nonatomic) CLLocationCoordinate2D coordinated2D;
@end

@implementation GGMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"选择地点";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [self setupRightBarButtonItem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseLocation:)];
    [self.mapView addGestureRecognizer:tap];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupRightBarButtonItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = RECT(0, 0, 23, 23);
    [btn setBackgroundImage:[UIImage imageFromMainBundleFile:@"ok_icon.png"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(okButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)okButtonClicked
{
    DLog(@"123");
    
    if (self.place)
    {
        if ([self.delegate respondsToSelector:@selector(mapViewController:didChooseCoor:WithPlace:)])
        {
            [self.delegate mapViewController:self didChooseCoor:_coordinated2D WithPlace:_place];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self showMBWithMessage:@"请选择一个地址"];
    }
}

- (void)chooseLocation:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:_mapView];
   CLLocationCoordinate2D coordinate2D =  [_mapView convertPoint:point toCoordinateFromView:self.view];
    //DLog(@"lon = %f lat = %f",coordinate2D.longitude,coordinate2D.latitude);
    [self getPlaceByCLLocationCoordinate2D:coordinate2D];
}


#pragma mark - MKMapViewDelegate method

- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView
{
    
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateSpan span;
    span.latitudeDelta = 0.1;
    span.longitudeDelta = 0.1;
    MKCoordinateRegion region;
    region.center = userLocation.coordinate;
    region.span = span;
    //设置地图模式
    [mapView setRegion:region animated:TRUE];
}


- (void)getPlaceByCLLocationCoordinate2D:(CLLocationCoordinate2D)coor
{
    self.coordinated2D = coor;
    CLGeocoder *reverer = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coor.latitude longitude:coor.longitude];
    [reverer reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
      //  DLog(@"place = %@",placemarks);
        CLPlacemark *mark = placemarks.firstObject;
        if (mark)
        {
            self.place = mark.name;
            self.placeLabel.text = mark.name;
        }
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
