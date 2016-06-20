#import "SFListController.h"
#import "SFSwitchTableCell.h"

@implementation SFListController

- (id)specifiers {
  if(_specifiers == nil) {
    _specifiers = [[self loadSpecifiersFromPlistName:@"SwipyFoldersPrefs" target:self] retain];

    Class DisplayController = %c(PSUIDisplayController); // Appears to be iOS 9+.
    if (!DisplayController) { // iOS 8.
      DisplayController = %c(DisplayController);
    }
  }
  return _specifiers;
}

- (id)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

  // Oh god the hacks. Remove the separator between the slider cell and the cell before it.
  // This hack is from http://stackoverflow.com/a/32818943.
  if ([cell isKindOfClass:%c(PSTableCell)]) {
    PSSpecifier *specifier = ((PSTableCell *) cell).specifier;
    NSString *identifier = specifier.identifier;

    if ([identifier isEqualToString:@"shortHoldTimeoutText"] || [identifier isEqualToString:@"doubleTapTimeoutText"] ) {
      CGFloat inset = cell.bounds.size.width * 10;
      cell.separatorInset = UIEdgeInsetsMake(0, inset, 0, 0);
      cell.indentationWidth = -inset;
      cell.indentationLevel = 1;
    }

  }
  return cell;
}

@end