//
//  SVNFormFieldDataSource.swift
//  SVNFormViewController
//
//  Created by Aaron Dean Bikis on 4/20/17.
//  Copyright © 2017 7apps. All rights reserved.
//

import UIKit
import SVNTextValidator

public protocol SVNFormField: class, Validatable {
  var validationText: String { get }
  var type: SVNFormFieldType! { get set }
}

public typealias SVNFormViewControllerDataSource = [SVNFormFieldType]


public protocol SVNFormFieldType {
  var fieldData: SVNFormFieldDataSource { get }
}

/// The protocol of all SVNFormFields
/// Create instances that conform to this protocol to create the dataSource for SVNFormViewController's ViewModel
public protocol SVNFormFieldDataSource {
  
  /// The Placeholder's Text for the field
  var placeholder: String { get }
  
  /// The ValidationRule's of the field. Set to nil for optional fields
  /// List in order of importantance i.e. [RequiredRule(), EmailRule()]
  /// - Remark: default is *[RequiredRule()]*
  var validationRule: [Rule]? { get }
  
  /// The Keyboard type that should be presented when the field becomes first responder.
  /// - Remark: default is *.default*
  var keyboardType: UIKeyboardType { get }
  
  /// Any apiKeys that you'd like to be associated with the field to process once the field has been validated
  var apiKey: String { get }
  
  /// Set for autoCorrection
  /// - Remark: default is *.no*
  var hasAutoCorrection: UITextAutocorrectionType { get }
  
  /// Set for prefilled data
  /// Will fill if you set the swift flag -DDEBUG_SVNFORM
  var stockData: String { get }
  
  /// If the field should have secure entry
  /// - Remark: default is *false*
  var isSecureEntry: Bool { get }
  
  /// ### Review SVNFormPickerType for more information ###
  /// set to nil if the field does not have a picker inputView
  /// - Remark: default is *nil*
  var hasPickerView: SVNFormPickerType? { get }
  
  /// ### Review SVNToggleType for more information ###
  /// set to nil if the field is not a toggle
  /// - Remark: default is *nil*
  var hasToggle: SVNToggleType? { get }
  
  /// ### Review SVNFormTermsFieldType for more information ###
  /// set to nil if the field is not a checkMark
  /// - Remark: default is *nil*
  var isCheckMarkField: SVNFormCheckMarkViewModel? { get }
  
  /// ### Review SVNFormDatePickerType for more information ###
  /// set to nil if the field does not have a datePicker inputView
  /// - Remark: default is *nil*
  var hasDatePicker: SVNFormDatePickerType? { get }
  
  /// ### Review SVNFormTermsOverlayType for more information ###
  /// set to nil if the field does not have a tooltip
  /// - Remark: default is *nil*
  var hasToolTip: SVNFormTermsOverlayType? { get }
  
  /// will add '*' while typing in this field
  var hasProtectedInformation: Bool { get }
  
  /// The meta data for a toolbar that sits on top of the textField
  var toolbarData: SVNFormToolbarViewModel { get }
  
  /// The textField's text font
  var textFieldFont: UIFont { get }
  
  /// The color of the textfield's text
  var textColor: UIColor { get }
}


public extension SVNFormFieldDataSource {
  
  var keyboardType: UIKeyboardType { return .default }
  
  var validationRule: [Rule]? { return [RequiredRule()] }
  
  var hasAutoCorrection: UITextAutocorrectionType { return .no }
  
  var isSecureEntry: Bool { return false }
  
  var hasPickerView: SVNFormPickerType? { return nil }
  
  var hasToggle: SVNToggleType? { return nil }
  
  var stockData: String { return "" }
  
  var isCheckMarkField: SVNFormCheckMarkViewModel? { return nil }
  
  var hasDatePicker: SVNFormDatePickerType? { return nil }
  
  var hasToolTip: SVNFormTermsOverlayType? { return nil }
  
  var hasProtectedInformation: Bool { return false }
}


