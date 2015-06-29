//
//  ViewController.h
//  AutocompleteTextField
//
//  Created by Kakashi on 06/26/2015.
//  Copyright (c) 2015 Kent Winder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AutocompleteTextField.h"

@interface ViewController : UIViewController <UITextFieldDelegate, AutocompleteTextFieldDelegate>

@property (weak, nonatomic) IBOutlet AutocompleteTextField *stringAutoCompleteField;
@property (weak, nonatomic) IBOutlet AutocompleteTextField *customObjAutocompleteField;
@property (weak, nonatomic) IBOutlet AutocompleteTextField *suggestionsIsAboveField;

@end

