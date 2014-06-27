//
//  MasterViewController.h
//  NCMBTodo
//
//  Created by 中津川 篤司 on 2014/06/27.
//  Copyright (c) 2014年 Atsushi Nakatsugawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
