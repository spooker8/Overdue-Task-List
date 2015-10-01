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
    
    else if ([segue.destinationViewController isKindOfClass:[DetailTaskViewController class]])
    {
        
        DetailTaskViewController *detailTaskViewController = segue.destinationViewController;
        NSIndexPath *path = sender;
        Task *taskObject = self.taskObjects[path.row];
        detailTaskViewController.task = taskObject;
        detailTaskViewController.delegate = self;
        
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IBAction buttons

- (IBAction)reorderBarButtonItempressed:(id)sender

{
    
    //code refactored..
    if (self.tableView.editing ==YES)[self.tableView setEditing:NO animated:YES];
    else [self.tableView setEditing:YES animated:YES];
    
    
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
    
    
    if (task.isCompleted ==YES) cell.backgroundColor = [UIColor greenColor];
    
    if (isOverdue == YES) cell.backgroundColor = [UIColor redColor];
    else cell.backgroundColor = [UIColor yellowColor];

    
    
    
    return cell;
    
}

#pragma mark tableview delegate

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
    
    
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(editingStyle ==UITableViewCellEditingStyleDelete)
    {
        
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        
        
        NSMutableArray *newTaskObjectsData = [[NSMutableArray alloc]init];
        
        for (Task *task in self.taskObjects)
        {
            
            [newTaskObjectsData addObject:[self taskObjectAsPropertyList:task]];
            
            
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectsData forKey:TASK_OBJECT_KEY];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Task *task = self.taskObjects[indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];
    
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"toDetailTaskViewController" sender:indexPath];
    
    
    
    
}


-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
    
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath

{
    
    Task *taskObject = self.taskObjects [sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.taskObjects insertObject:taskObject atIndex:destinationIndexPath.row];
    [self saveTasks];
    
    
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


#pragma mark - DetailViewController Delegate

-(void)updateTask
{
    
    [self saveTasks];
    [self.tableView reloadData];
    
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



-(void)updateCompletionOfTask:(Task *)task forIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY] mutableCopy];
    
    
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc]init];
    
    
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    
    if(task.isCompleted == YES) task.isCompleted =NO;
    else task.isCompleted = YES;
    
    [taskObjectsAsPropertyLists insertObject:[self taskObjectAsPropertyList:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECT_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
    
}


-(void)saveTasks
{
    
    NSMutableArray *taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    for (int x = 0; x < [self.taskObjects count]; x ++)
    {
        
        [taskObjectsAsPropertyLists addObject:[self taskObjectAsPropertyList:self.taskObjects[x]]];
        
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECT_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    
    
}



@end
