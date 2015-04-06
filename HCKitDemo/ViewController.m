//
//  ViewController.m
//  HCKitDemo
//
//  Created by 花晨 on 15/4/4.
//  Copyright (c) 2015年 花晨. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [imageview setImage:[UIImage imageNamed:@"UIBarButtonItem+Extend.bundle/back_black@2x.png"]];
//    [imageview setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:imageview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
