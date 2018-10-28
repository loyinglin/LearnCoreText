//
//  BookshelfViewController.m
//  LearnCoreText
//
//  Created by loyinglin on 2018/10/26.
//  Copyright © 2018 loyinglin. All rights reserved.
//

#import "BookshelfViewController.h"

@interface BookshelfViewController ()

@end

@implementation BookshelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
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
