//
//  AddTaskViewController.h
//  
//
//  Created by Anand Kumar on 16/09/2015.
//
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol AddTaskViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didAddTask:(Task *)task;


@end




@interface AddTaskViewController : UIViewController

@property(weak, nonatomic) id <AddTaskViewControllerDelegate> delegate;


@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;



- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
