//
//  TaskDetailsViewController.m
//  TaskyWorkshop
//
//  Created by JETSMobileLabMini10 on 23/04/2025.
//

#import "TaskDetailsViewController.h"
#import "../datalayer/Task.h"
#import "../datalayer/TasksHelper.h"


@interface TaskDetailsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfTitle;
@property (weak, nonatomic) IBOutlet UITextView *tvDesc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *scPriority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *scStates;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property TasksHelper* helper;

@end

@implementation TaskDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.helper = [[TasksHelper alloc] init];
    
    self.tfTitle.text = self.currentTask.taskTitle;
    self.tvDesc.text = self.currentTask.taskDesc;
    self.scPriority.selectedSegmentIndex = self.currentTask.taskPriority;
    self.scStates.selectedSegmentIndex = self.currentTask.taskState;
    self.datePicker.date = self.currentTask.taskDate;
    
    self.datePicker.minimumDate = [NSDate date];
    
}

- (IBAction)saveBtnClicked:(UIBarButtonItem *)sender {
    
    if(self.tfTitle.text.length == 0) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Task Title can't be empty" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if(self.tvDesc.text.length == 0) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Task Description can't be empty" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
        return;
    }
        
    self.currentTask.taskTitle = self.tfTitle.text;
    self.currentTask.taskDesc = self.tvDesc.text;
    self.currentTask.taskPriority = self.scPriority.selectedSegmentIndex;
    self.currentTask.taskState = self.scStates.selectedSegmentIndex;
    self.currentTask.taskDate = self.datePicker.date;
    
    [self.helper updateTask:self.currentTask];
    [self.syncDataDelegate syncData];
    [self.navigationController popViewControllerAnimated:YES];
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
