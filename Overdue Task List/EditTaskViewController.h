//
//  EditTaskViewController.h
//  
//
//  Created by Anand Kumar on 16/09/2015.
//
//

#import <UIKit/UIKit.h>
#import "Task.h"


@protocol EditTaskViewControllerDelegate <NSObject>

-(void)didUpdateTask;




@end

@interface EditTaskViewController : UIViewController


@property (strong, nonatomic) Task *task;
@property (weak, nonatomic) id <EditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveBarButtonItemPressed;


@end
