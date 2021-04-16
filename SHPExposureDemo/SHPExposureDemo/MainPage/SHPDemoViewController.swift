//
//  SHPDemoViewController.swift
//  SHPExposureDemo
//
//  Created by Yanni Wang on 14/4/20.
//  Copyright © 2020 Shopee. All rights reserved.
//

import Foundation
import Eureka

class SHPDemoViewController: FormViewController {
    
    private static let minDurationInWindowKey = "minDurationInWindowKey"
    private static let minAreaRatioInWindowKey = "minAreaRatioInWindowKey"
    private static let retriggerWhenLeftScreenKey = "retriggerWhenLeftScreenKey"
    private static let retriggerWhenRemovedFromWindowKey = "retriggerWhenRemovedFromWindowKey"
    
    @objc static var minDurationInWindow: CGFloat {
        get {
            if UserDefaults.standard.object(forKey: minDurationInWindowKey) == nil {
                self.minDurationInWindow = 2
            }
            return CGFloat(UserDefaults.standard.float(forKey: minDurationInWindowKey))
        }
        set {
            UserDefaults.standard.set(newValue, forKey: minDurationInWindowKey)
        }
    }
    @objc static var minAreaRatioInWindow: CGFloat {
        get {
            if UserDefaults.standard.object(forKey: minAreaRatioInWindowKey) == nil {
                self.minAreaRatioInWindow = 0.5
            }
            return CGFloat(UserDefaults.standard.float(forKey: minAreaRatioInWindowKey))
        }
        set {
            UserDefaults.standard.set(newValue, forKey: minAreaRatioInWindowKey)
        }
    }
    @objc static var retriggerWhenLeftScreen: Bool {
        get {
            if UserDefaults.standard.object(forKey: retriggerWhenLeftScreenKey) == nil {
                self.retriggerWhenLeftScreen = false
            }
            return UserDefaults.standard.bool(forKey: retriggerWhenLeftScreenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: retriggerWhenLeftScreenKey)
        }
    }
    @objc static var retriggerWhenRemovedFromWindow: Bool {
        get {
            if UserDefaults.standard.object(forKey: retriggerWhenRemovedFromWindowKey) == nil {
                self.retriggerWhenRemovedFromWindow = false
            }
            return UserDefaults.standard.bool(forKey: retriggerWhenRemovedFromWindowKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: retriggerWhenRemovedFromWindowKey)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Exposure Demo";
        self.setUpForm()
    }
    
    func setUpForm() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        form.removeAll()
        form +++ Section("TEST CASES")
            <<< ButtonRow("Non-reused views") { row in
                row.title = row.tag
                row.presentationMode = .show(controllerProvider: ControllerProvider<UIViewController>.callback(builder: { () -> UIViewController in
                    return SHPDemoNonReusedViewController()
                }), onDismiss: nil)
            }
            <<< ButtonRow("Reused views") { row in
                row.title = row.tag
                row.presentationMode = .show(controllerProvider: ControllerProvider<UIViewController>.callback(builder: { () -> UIViewController in
                    return SHPDemoReusedViewController()
                }), onDismiss: nil)
            }
            <<< ButtonRow("View controller disappear") { row in
                row.title = row.tag
                row.presentationMode = .show(controllerProvider: ControllerProvider<UIViewController>.callback(builder: { () -> UIViewController in
                    return SHPDemoDisappearViewController()
                }), onDismiss: nil)
            }
            <<< ButtonRow("Covered view") { row in
                row.title = row.tag
                row.presentationMode = .show(controllerProvider: ControllerProvider<UIViewController>.callback(builder: { () -> UIViewController in
                    return SHPDemoCoverViewController()
                }), onDismiss: nil)
            }
            +++ Section("SETTINGS")
            <<< DecimalRow() {
                $0.title = "minDurationInWindow"
                $0.value = Double(SHPDemoViewController.minDurationInWindow)
                $0.formatter = DecimalFormatter()
                $0.useFormatterDuringInput = true
                //$0.useFormatterOnDidBeginEditing = true
            }.cellSetup { cell, _  in
                cell.textField.keyboardType = .numberPad
            }.onChange({ (row) in
                SHPDemoViewController.minDurationInWindow = CGFloat(row.value ?? 0)
            })
            <<< SliderRow() {
                $0.title = "minAreaRatioInWindow"
                $0.value = Float(Int(SHPDemoViewController.minAreaRatioInWindow * 100))
                $0.cell.slider.minimumValue = 1
                $0.cell.slider.maximumValue = 100
                $0.displayValueFor = {
                    return "\(Int($0 ?? 0))%"
                }
            }.onChange({ (row) in
                SHPDemoViewController.minAreaRatioInWindow = CGFloat((row.value ?? 0) / 100)
            })
            <<< SwitchRow() {
                $0.title = "retriggerWhenLeftScreen"
                $0.value = SHPDemoViewController.retriggerWhenLeftScreen
            }.onChange({ (row) in
                SHPDemoViewController.retriggerWhenLeftScreen = row.value ?? false
            })
            <<< SwitchRow() {
                $0.title = "retriggerWhenRemovedFromWindow"
                $0.value = SHPDemoViewController.retriggerWhenRemovedFromWindow
            }.onChange({ (row) in
                SHPDemoViewController.retriggerWhenRemovedFromWindow = row.value ?? false
            })
            <<< ButtonRow(){
                $0.title = "Reset"
                $0.cell.tintColor = .red
            }.onCellSelection { [weak self] _,_ in
                UserDefaults.standard.removeObject(forKey: SHPDemoViewController.minDurationInWindowKey)
                UserDefaults.standard.removeObject(forKey: SHPDemoViewController.minAreaRatioInWindowKey)
                UserDefaults.standard.removeObject(forKey: SHPDemoViewController.retriggerWhenLeftScreenKey)
                UserDefaults.standard.removeObject(forKey: SHPDemoViewController.retriggerWhenRemovedFromWindowKey)
                self?.setUpForm()
        }
        CATransaction.commit()
    }
}