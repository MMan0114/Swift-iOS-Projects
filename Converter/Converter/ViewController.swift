//
//  ViewController.swift
//  Converter
//
//  Created by MMan on 9/14/16.
//  Copyright © 2016 MananKothari. All rights reserved.
//
import UIKit
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var picker: UIPickerView!
    @IBOutlet var field1: UITextField!
    @IBOutlet var field2: UITextField!

    static var pd: [String] = ["kg to mi", "mi to kg", "in to cm", "cm to in", "lit to gal", "gal to lit"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// MARK: UIPickerViewDelegate & UIPickerViewDataSource methods

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return ViewController.pd[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("didSelectRow: \(Int(row)), inComponent: \(Int(component))")
    }
// MARK: Rotation

    override func shouldAutorotate(to toInterfaceOrientation: UIInterfaceOrientation) -> Bool {
        print("Current row select value \(Int((picker?.selectedRow(inComponent: 0))!))")
        //Return yes for supported orientations
        return (toInterfaceOrientation != .portraitUpsideDown)
    }
}
