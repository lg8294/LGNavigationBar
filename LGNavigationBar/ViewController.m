//
//  ViewController.m
//  LGNavigationBar
//
//  Created by Arrcen-LG on 2018/11/28.
//  Copyright © 2018 Arrcen-LG. All rights reserved.
//

#import "ViewController.h"
#import "LG_NavigationBar/LGNavigationBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:YES];
    
    LGNavigationBar *navBar = [[LGNavigationBar alloc] init];
    navBar.title = @"CustomNavBar";
    [navBar setBarTinColor:[UIColor greenColor]];
    [self.view addSubview:navBar];
}

@end
