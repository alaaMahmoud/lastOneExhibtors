//
//  ExhibitorsController.h
//  MDW
//
//  Created by Mahmoud Amin on 4/27/16.
//  Copyright (c) 2016 Mahmoud Amin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+htmlViewer.h"
#import "NetWorkDelegate.h"

@interface ExhibitorsController : UITableViewController<NetWorkDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtn;
@property NSMutableArray *exhibitors;


@end
