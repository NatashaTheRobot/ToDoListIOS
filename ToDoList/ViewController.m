//
//  ViewController.m
//  ToDoList
//
//  Created by Natasha Murashev on 5/8/13.
//  Copyright (c) 2013 Natasha Murashev. All rights reserved.
//

#import "ViewController.h"
#import "EditingViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addTodoItem:(id)sender;

@property (strong, nonatomic) NSMutableArray *todoLists;

- (void)moveItem:(NSString *)todoItem toList:(NSInteger)listIndex inSection:(NSInteger)section fromIndexPath:(NSIndexPath *)indexPath;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.todoLists = [[NSMutableArray alloc] initWithObjects:[NSMutableArray array], [NSMutableArray array], nil];
    
    self.textField.delegate = self;
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Action Methods

- (IBAction)addTodoItem:(id)sender
{
    if (![self.textField.text isEqualToString:@""]) {
        
        [self.todoLists[0] addObject:self.textField.text];
        
        self.textField.text = @"";
        [self.textField resignFirstResponder];
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:([self.todoLists[0] count] - 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Data Source Delegate Methods 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"todoItem";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.todoLists[indexPath.section][indexPath.row];
    cell.accessoryType = UIButtonTypeDetailDisclosure;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.todoLists count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.todoLists[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"To Do";
    } else {
        return @"Already Done";
    }
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *todoItem = self.todoLists[indexPath.section][indexPath.row];
    
    [self.tableView beginUpdates];
    
    [self.todoLists[indexPath.section] removeObjectAtIndex:indexPath.row];
    
    if (indexPath.section == 0) {
        [self moveItem:todoItem toList:1 inSection:1 fromIndexPath:indexPath];
    } else if (indexPath.section == 1){
        [self moveItem:todoItem toList:0 inSection:0 fromIndexPath:indexPath];
    }
    
    [self.tableView endUpdates];
    
}

- (void)moveItem:(NSString *)todoItem
         toList:(NSInteger)listIndex
      inSection:(NSInteger)section
    fromIndexPath:(NSIndexPath *)indexPath
{
    [self.todoLists[listIndex] addObject:todoItem];
    NSIndexPath *path = [NSIndexPath indexPathForRow:([self.todoLists[listIndex] count] - 1) inSection:section];
    [self.tableView moveRowAtIndexPath:indexPath toIndexPath:path];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    EditingViewController *editingViewController = [[EditingViewController alloc] initWithNibName:@"EditingViewController" bundle:nil];
    editingViewController.delegate = self;
    editingViewController.indexPath = indexPath;
    editingViewController.todoItemText = self.todoLists[indexPath.section][indexPath.row];
    
    [self.navigationController pushViewController:editingViewController animated:YES];
}

#pragma mark - Edit Delegate Methods

- (void)updateText:(NSString *)newText atIndexPath:(NSIndexPath *)indexPath
{
    self.todoLists[indexPath.section][indexPath.row] = newText;
    [self.tableView cellForRowAtIndexPath:indexPath].textLabel.text = newText;
    
    [self.navigationController popToViewController:self animated:YES];
}

#pragma mark - Text Field Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![self.textField.text isEqualToString:@""]) {
        
        [self.todoLists[0] addObject:self.textField.text];
        
        self.textField.text = @"";
        [self.textField resignFirstResponder];
        
        NSIndexPath *path = [NSIndexPath indexPathForRow:([self.todoLists[0] count] - 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    
    return YES;
}

@end
