//
//  InfoController.m
//  MDW
//
//  Created by Mahmoud Amin on 4/30/16.
//  Copyright (c) 2016 Mahmoud Amin. All rights reserved.
//

#import "InfoController.h"

@interface InfoController ()

@end

@implementation InfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    UIBarButtonItem *mBtn=[[UIBarButtonItem alloc] init];
    mBtn.target = self.revealViewController;
    mBtn.action = @selector(revealToggle:);
    mBtn.image=[UIImage imageNamed:@"menuBar.png"];
    mBtn.tintColor=[UIColor orangeColor];
    self.tabBarController.navigationItem.leftBarButtonItem=mBtn;

    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];


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
