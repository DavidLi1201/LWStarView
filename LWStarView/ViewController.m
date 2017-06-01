//
//  ViewController.m
//  LWStarView
//
//  Created by 李伟 on 2017/6/1.
//  Copyright © 2017年 李伟. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.starView.upImage = [UIImage imageNamed:@"up"];
    self.starView.downImage = [UIImage imageNamed:@"down"];
    self.starView.markComplete = ^(CGFloat score){
        NSLog(@"%f",score);
    };
    
}



@end
