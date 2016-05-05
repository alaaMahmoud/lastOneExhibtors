//  AgendaController.m
//  MDW
//
//  Created by Mahmoud Amin on 4/27/16.
//  Copyright (c) 2016 Mahmoud Amin. All rights reserved.
//

#import "AgendaController.h"
#import "SWRevealViewController.h"
#import "JETSSession.h"
#import "NetWorkManager.h"
#import "NetWorkHandler.h"
#import "NetWorkDelegate.h"

@interface AgendaController ()
{
    NSArray *responseData;
    UIActivityIndicatorView *activity;
}
@end

@implementation AgendaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *mBtn=[[UIBarButtonItem alloc] init];
    mBtn.target = self.revealViewController;
    mBtn.action = @selector(revealToggle:);
    mBtn.image=[UIImage imageNamed:@"menuBar.png"];
    mBtn.tintColor=[UIColor orangeColor];
    self.tabBarController.navigationItem.leftBarButtonItem=mBtn;
    
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
}
-(void) handleSuccess:(id) data{
    responseData =data;
    NSLog(@"%@",data);
    [self.tableView reloadData];
    [activity stopAnimating];
    
}
-(void) handleFaild{
    [activity stopAnimating];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"please check your connection" delegate:nil cancelButtonTitle:@"" otherButtonTitles:@"Ok", nil];
    
    [alert show];
}

-(void)viewWillAppear:(BOOL)animated
{
    NetWorkManager *netMang=[NetWorkManager new];
    NetWorkHandler *netcal=[netMang connect ];
    [netcal getSessionsWithEmail:@"asmaabadreldin@hotmail.com" WithDelgate:self];
}



-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


 /*
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 return [responseData count];
 }
 -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 return 1;
 }
  */

//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    [responseData appendData:data];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Agenda" forIndexPath:indexPath];
    
    [cell.textLabel setText:[[responseData objectAtIndex:indexPath.row]speakers]];
    cell.backgroundColor=[UIColor clearColor];
    
    
       return cell;
    
    // Configure the cell...
    
    //return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end