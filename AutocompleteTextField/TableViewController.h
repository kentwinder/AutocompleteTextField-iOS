//
//  TableViewController.h
//  AutocompleteTextField
//
//  Created by Kakashi on 06/29/2015.
//  Copyright (c) 2015 Kent Winder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutocompleteTextField.h"

@interface TableViewController : UITableViewController <UITextFieldDelegate, AutocompleteTextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *suggestionsIsBelowField;
@property (weak, nonatomic) IBOutlet UITextField *suggestionsIsAboveField;

@end
