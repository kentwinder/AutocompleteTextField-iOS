Autocomplete TextField iOS Version

Setup

Implement the following delegate methods of AutocompleteTextFieldDelegate.

@required - Data to filter, can be anything from string to custom object

	- (NSArray *)dataForTextField:(AutocompleteTextField *)textField;
	
@required - How to filter this array

	- (NSPredicate *)predicateForDataFilter:(AutocompleteTextField *)textField;
	
@required - How to display each object in result list

	- (NSString *)titleForSuggestion:(AutocompleteTextField *)textField obj:(id)obj;

@optional - Minimum character to trigger the autocompletion

	- (int)minCharToStartFilter:(AutocompleteTextField *)textField;
	
@optional - Result will be displayed above or below TextField

	- (BOOL)suggestionsIsDisplayedBelowTextField:(AutocompleteTextField *)textField;
	
@optional - After select from suggestion, do more handle with selected object
	
	- (void)didSelectSuggestion:(AutocompleteTextField *)textField obj:(id)obj;

There is one small example in the project