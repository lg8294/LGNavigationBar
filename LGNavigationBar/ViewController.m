//
//  ViewController.m
//  LGNavigationBar
//
//  Created by Arrcen-LG on 2018/11/28.
//  Copyright © 2018 Arrcen-LG. All rights reserved.
//

#import "ViewController.h"
#import "../LG_NavigationBar/LGNavigationBar.h"

@interface ViewController ()

@property (nonatomic) LGNavigationBar *navbar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:YES];
    
    LGNavigationBar *navBar = [[LGNavigationBar alloc] init];
    navBar.title = @"CustomNavBar";
    [navBar setBarTinColor:[UIColor greenColor]];
    
    [navBar.rightBtn setTitle:@"more" forState:UIControlStateNormal];
    [navBar.leftBtn setTitle:@"back" forState:UIControlStateNormal];
    [navBar.leftBtn setImage:[UIImage imageNamed:@"icon-backaroow"] forState:UIControlStateNormal];
    
    [self.view addSubview:navBar];
    self.navbar = navBar;
}

- (IBAction)handleAlphe:(UISlider *)sender {
    [self.navbar setBarAlpha:sender.value];
}
@end
