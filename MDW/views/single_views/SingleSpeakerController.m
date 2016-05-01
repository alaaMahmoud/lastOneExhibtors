//
//  SingleSpeakerController.m
//  MDW
//
//  Created by Mahmoud Amin on 4/30/16.
//  Copyright (c) 2016 Mahmoud Amin. All rights reserved.
//

#import "SingleSpeakerController.h"

@interface SingleSpeakerController ()

@end

@implementation SingleSpeakerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *mBtn=[[UIBarButtonItem alloc] init];
    mBtn.target = self;
    mBtn.action = @selector(dismissSelf);
    mBtn.image=[UIImage imageNamed:@"leftArrow.png"];
    mBtn.tintColor=[UIColor orangeColor];
    self.navigationItem.leftBarButtonItem=mBtn;
    
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}
-(void)dismissSelf{
    [self dismissViewControllerAnimated:YES completion:nil];
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
