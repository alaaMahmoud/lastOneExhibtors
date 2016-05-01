//
//  LoginController.m
//  MDW
//
//  Created by Mahmoud Amin on 4/27/16.
//  Copyright (c) 2016 Mahmoud Amin. All rights reserved.
//

#import "LoginController.h"
#import "SWRevealViewController.h"
@interface LoginController ()

@end

@implementation LoginController
- (IBAction)onLoginClick:(UIButton *)sender {
}
- (IBAction)onGoClick:(id)sender {
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"] animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
