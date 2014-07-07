//
//  MasterViewController.m
//  NCMBTodo
//
//  Created by 中津川 篤司 on 2014/06/27.
//  Copyright (c) 2014年 Atsushi Nakatsugawa. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "AddTaskViewController.h"
#import <NCMB/NCMB.h>

@interface MasterViewController () <AddTaskViewControllerDelegate> {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
	    self.clearsSelectionOnViewWillAppear = NO;
	    self.preferredContentSize = CGSizeMake(320.0, 600.0);
	}
    [super awakeFromNib];
}

-(void) loadTable
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	if (!_objects) {
		_objects = [[NSMutableArray alloc] init];
	}
	NCMBQuery *query = [NCMBQuery queryWithClassName:@"TODO"];
	[query findObjectsInBackgroundWithBlock:^(NSArray *todos, NSError *error) {
		for (NCMBObject *todo in todos) {
			NSLog(@"%@", [todo objectForKey:@"todo"]);
			[_objects insertObject:[todo objectForKey:@"todo"] atIndex:0];
			// TableViewに行を挿入する
			NSIndexPath *indexPath = [NSIndexPath indexPathForRow: 0 inSection:0];
			[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
		}
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addTaskViewControllerDidCancel:(AddTaskViewController *)controller
{
    NSLog(@"addTaskViewControllerDidCancel");
    
    // 画面を閉じるメソッドを呼ぶ
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)addTaskViewControllerDidFinish:(AddTaskViewController *)controller item:(NSString *)item
{
    NSLog(@"addTaskViewControllerDidFinish item:%@",item);
    
    // 保存するための配列の準備ができていない場合は、配列を生成し、初期化する
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }

	NCMBObject *obj = [NCMBObject objectWithClassName:@"TODO"];
    [obj setObject:item forKey:@"todo"];
	NSError *saveError = nil;
    [obj save:&saveError];
	if (saveError == nil) {
		// 受け取ったitemを配列に格納する
		[_objects insertObject:item atIndex:0];
		// TableViewに行を挿入する
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
		[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
		// 画面を閉じるメソッドを呼ぶ
		[self dismissViewControllerAnimated:YES completion:NULL];
	}else{
		
	}
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

	NSDate *object = _objects[indexPath.row];
	cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowAddTaskView"]) {
        AddTaskViewController *addTaskViewController = (AddTaskViewController *)[[[segue destinationViewController]viewControllers]objectAtIndex:0];
        addTaskViewController.delegate = self;
    }
}

@end
