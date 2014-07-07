//
//  AddTaskViewController.h
//  NCMBTodo
//
//  Created by Atsushi Nakatsugawa on 2014/07/01.
//  Copyright (c) 2014年 Atsushi Nakatsugawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddTaskViewControllerDelegate;

@interface AddTaskViewController : UITableViewController

@property (weak, nonatomic) id<AddTaskViewControllerDelegate> delegate;

@end

@protocol AddTaskViewControllerDelegate <NSObject>

- (void)addTaskViewControllerDidCancel:(AddTaskViewController *)controller;

- (void)addTaskViewControllerDidFinish:(AddTaskViewController *)controller item:(NSString *)item;

@end
