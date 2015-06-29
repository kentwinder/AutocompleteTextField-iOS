//
//  AutocompleteTextField.h
//  AutocompleteTextField
//
//  Created by Kakashi on 06/26/2015.
//  Copyright (c) 2015 Kent Winder. All rights reserved.
//
// https://github.com/kentwinder/AutocompleteTextField-iOS
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

@protocol AutocompleteTextFieldDelegate;

@interface AutocompleteTextField : UITextField <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <UITextFieldDelegate, AutocompleteTextFieldDelegate> delegate;

@end

@protocol AutocompleteTextFieldDelegate <NSObject>

@required
- (NSArray *)dataForTextField:(AutocompleteTextField *)textField;
- (NSString *)titleForSuggestion:(AutocompleteTextField *)textField obj:(id)obj;
- (NSPredicate *)predicateForDataFilter:(AutocompleteTextField *)textField;

@optional
- (int)minCharToStartFilter:(AutocompleteTextField *)textField;
- (BOOL)suggestionsIsDisplayedBelowTextField:(AutocompleteTextField *)textField;
- (void)didSelectSuggestion:(AutocompleteTextField *)textField obj:(id)obj;
- (UITableView *)tableViewForTextField:(AutocompleteTextField *)textField;

@end