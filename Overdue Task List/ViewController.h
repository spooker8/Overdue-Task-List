//
//  ViewController.h
//  Overdue Task List
//
//  Created by Anand Kumar on 16/09/2015.
//  Copyright (c) 2015 anand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)reorderBarButtonItempressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addTaskBarItemPressed;



@end

