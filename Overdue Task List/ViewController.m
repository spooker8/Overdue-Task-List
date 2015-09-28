//
//  ViewController.m
//  Overdue Task List
//
//  Created by Anand Kumar on 16/09/2015.
//  Copyright (c) 2015 anand. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController 


-(NSMutableArray *)taskObjects
{
    
    if (!_taskObjects)
    {
        
        _taskObjects = [[NSMutableArray alloc] init];
        
        
    }
    return _taskObjects;
}



- (void)viewDidLoad {
    [super viewDidLoad];
  
  //  self.tableView.dataSource = self;
    
    
    
    NSArray *taskAsPropertyList = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY];
    
    for (NSDictionary *dictionary in taskAsPropertyList)
    {
        
        Task *taskObject = [self taskObjectForDictionary:dictionary];
        
        [self.taskObjects addObject:taskObject];
        
        
        
    }
    
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]])
        
    {
        
        AddTaskViewController *addTaskViewController = segue.destinationViewController;
        
        addTaskViewController.delegate = self;
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderBarButtonItempressed:(id)sender {
}


- (IBAction)addTaskBarButtonItemPressed:(id)sender {
    
    
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:nil];
    
}


#pragma mark UITABLEVIEW DATASOURCE

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.taskObjects count];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //Configure the cell
    
    Task *task = self.taskObjects[indexPath.row];
    cell.textLabel.text = task.title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *stringFromDate = [formatter stringFromDate:task.date];
    cell.detailTextLabel.text = stringFromDate;
    
    
    BOOL isOverdue = [self isDateGreaterThanDate: [NSDate date] and:task.date];
    
    if (isOverdue == YES) cell.backgroundColor = [UIColor redColor];
    else cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
    
}


#pragma mark -AddTaskViewControllerDelegate

-(void)didAddTask:(Task *)task
{
    
    [self.taskObjects addObject:task];
    
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY] mutableCopy];

    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];


    [taskObjectsAsPropertyLists addObject:[self taskObjectAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECT_KEY];
    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
    
    
}


-(void)didCancel
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Helper Methods

-(NSDictionary *)taskObjectAsPropertyList:(Task *)taskObject
{
    
    NSDictionary *dictionary = @{TASK_TITLE : taskObject.title, TASK_DESCRIPTION: taskObject.description, TASK_DATE : taskObject.date, TASK_COMPLETION : @(taskObject.isCompleted) };
    
    return dictionary;
    
}


-(Task *)taskObjectForDictionary: (NSDictionary *)dictionary
{
    
    Task *taskObject = [[Task alloc] initWithData:dictionary];
    return  taskObject;
    
    
}

-(BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    
    if (dateInterval > toDateInterval)
    {
        return YES;
    }
    else {
        return NO;
    }
    
}


@end
