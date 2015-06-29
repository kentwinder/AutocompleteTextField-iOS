//
//  AutocompleteTextField.m
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

#import "AutocompleteTextField.h"

#define CELL_IDENTIFIER @"autocompleteCell"

@implementation AutocompleteTextField

@dynamic delegate;

UITableView *dataTableView;
NSArray *filteredData;
BOOL shouldDisplayBelowTextField = YES;
BOOL isInsideTableView = NO;

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.text.length > [self minLenth] && self.isFirstResponder) {
        [self filterData];
        if ([[self delegate] respondsToSelector:@selector(suggestionsIsDisplayedBelowTextField:)]) {
            shouldDisplayBelowTextField = [[self delegate] suggestionsIsDisplayedBelowTextField:self];
        }
        [self showData];
    } else {
        if ([dataTableView superview] != nil) {
            [dataTableView removeFromSuperview];
        }
        
        if ([[self delegate] respondsToSelector:@selector(tableViewForTextField:)]) {
            [[self delegate] tableViewForTextField:self].scrollEnabled = YES;
        }
    }
}

#pragma mark - Handle autocompletion
- (void)filterData {
    if ([[self delegate] respondsToSelector:@selector(dataForTextField:)]
        && [[self delegate] respondsToSelector:@selector(predicateForDataFilter:)]) {
        filteredData = [[[self delegate] dataForTextField:self] filteredArrayUsingPredicate:[[self delegate] predicateForDataFilter:self]];
    } else {
        filteredData = nil;
    }
    if ([[self delegate] respondsToSelector:@selector(tableViewForTextField:)]
        && [[self delegate] tableViewForTextField:self] != nil) {
        isInsideTableView = YES;
        if ([filteredData count] > 0) {
            [[self delegate] tableViewForTextField:self].scrollEnabled = NO;
        } else {
            [[self delegate] tableViewForTextField:self].scrollEnabled = YES;
        }
    }
}

- (void)showData {
    if (dataTableView.superview == nil && [filteredData count] > 0) {
        dataTableView = [[UITableView alloc] init];
        dataTableView.delegate = self;
        dataTableView.dataSource = self;
        dataTableView.backgroundColor = [UIColor clearColor];
        if  (isInsideTableView) {
            UIWindow* mainWindow = [[UIApplication sharedApplication] keyWindow];
            [mainWindow addSubview:dataTableView];
        } else {
            [[self superview] addSubview:dataTableView];
            
        }
        
        dataTableView.alpha = 0.0;
        [UIView animateWithDuration:0.3
                         animations:^{
                             [dataTableView setAlpha:1.0];
                         }
                         completion:nil];
    } else {
        [dataTableView reloadData];
    }
    
    NSInteger tableHeight = 176; // show 4 cells by default (44 * 4)
    if ([filteredData count] < 4) {
        tableHeight = 44 * [filteredData count];
    }
    CGRect frameForPresentation = [self convertRect:self.bounds toView:nil];
    if (shouldDisplayBelowTextField) {
        frameForPresentation.origin.y += self.frame.size.height;
    } else {
        frameForPresentation.origin.y -= tableHeight;
    }
    frameForPresentation.size.height = tableHeight;
    [dataTableView setFrame:frameForPresentation];
    
    if (!shouldDisplayBelowTextField) {
        CGPoint offset = CGPointMake(0, dataTableView.contentSize.height - dataTableView.frame.size.height);
        [dataTableView setContentOffset:offset animated:YES];
    }
}

#pragma mark - Optional data
- (int)minLenth {
    int min = 0;
    if ([[self delegate] respondsToSelector:@selector(minCharToStartFilter:)]) {
        min = [[self delegate] minCharToStartFilter:self] - 1;
        if (min < 0) min = 0;
    }
    return min;
}

#pragma mark - TableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [filteredData count];
    if (count == 0) {
        [UIView animateWithDuration:0.3
                         animations:^{
                             [dataTableView setAlpha:0.0];
                         }
                         completion:^(BOOL finished){
                             [dataTableView removeFromSuperview];
                             dataTableView = nil;
                         }];
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item;
    if (shouldDisplayBelowTextField) {
        item = [filteredData objectAtIndex:indexPath.row];
    } else {
        // if result is displayed above text field, the list should be reversed
        item = [filteredData objectAtIndex:([filteredData count] - indexPath.row - 1)];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CELL_IDENTIFIER];
    }
    [[cell textLabel] setText:[[self delegate] titleForSuggestion:self
                                                              obj:item]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id item;
    if (shouldDisplayBelowTextField) {
        item = [filteredData objectAtIndex:indexPath.row];
    } else {
        item = [filteredData objectAtIndex:([filteredData count] - indexPath.row - 1)];
    }
    self.text = [[self delegate] titleForSuggestion:self
                                                obj:item];
    if ([[self delegate] respondsToSelector:@selector(didSelectSuggestion:obj:)]) {
        [[self delegate] didSelectSuggestion:self
                                         obj:item];
    }
    [self resignFirstResponder];
}

@end
