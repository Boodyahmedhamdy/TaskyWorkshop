//
//  AddTaskViewController.m
//  TaskyWorkshop
//
//  Created by JETSMobileLabMini10 on 23/04/2025.
//

#import "AddTaskViewController.h"
#import "../datalayer/Task.h"
#import "../datalayer/TasksHelper.h"
#import "../SyncDataDelegate.h"

@interface AddTaskViewController ()

@property TasksHelper* helper;
@property (weak, nonatomic) IBOutlet UITextField *tfTitle;
@property (weak, nonatomic) IBOutlet UITextView *tvDesc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *scPriority;
@property (weak, nonatomic) IBOutlet UIDatePicker *dbDate;


@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.helper = [[TasksHelper alloc] init];
    // Do any additional setup after loading the view.
    [self.dbDate setMinimumDate:[NSDate date]];
}

- (IBAction)createBtnClicked:(UIBarButtonItem *)sender {
    
    NSLog(@"clicked on create");
    Task* newTask = [[Task alloc] init];
    newTask.taskTitle = self.tfTitle.text;
    
    if(self.tfTitle.text.length == 0) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Task Title can't be empty" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    newTask.taskDesc = self.tvDesc.text;
    
    if(self.tvDesc.text.length == 0) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Task Description can't be empty" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    newTask.taskPriority = self.scPriority.selectedSegmentIndex;
    newTask.taskState = TaskStateTodo;
    newTask.taskDate = self.dbDate.date;
    
    [self.helper addTask:newTask];
    
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
