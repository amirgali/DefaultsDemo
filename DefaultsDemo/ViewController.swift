//
//  ViewController.swift
//  DefaultsDemo
//
//  Created by Амиргали Туралинов on 30.11.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var saveButton: UIButton!
    @IBOutlet private var segmentControl: UISegmentedControl!
    @IBOutlet private var deleteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        segmentControl.addTarget(self, action: #selector(didTapSegmentControl), for: .valueChanged)
        
        saveCurrentLaunch()
        statusLabel.text = "Запусков приложения: \(UserDefaults.standard.integer(forKey: numberOfLaunchesKey))"
        textField.text = UserDefaults.standard.string(forKey: inputTextKey)
        segmentControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: segmentIndex)
    }
    
    @objc func didTapSaveButton() {
        guard let text = textField.text else { return }
        UserDefaults.standard.set(text, forKey: inputTextKey)
    }
    
    @objc func didTapDeleteButton() {
        let keys = [numberOfLaunchesKey, inputTextKey, segmentIndex]
        keys.forEach {
            UserDefaults.standard.set(nil, forKey: $0)
        }
    }
    
    @objc func didTapSegmentControl(sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: segmentIndex)
    }
    
    func saveCurrentLaunch() {
        let index = UserDefaults.standard.integer(forKey: numberOfLaunchesKey)
        UserDefaults.standard.set(index + 1, forKey: numberOfLaunchesKey)
    }
    
    // MARK: - Privat constants
    private let numberOfLaunchesKey = "NumberOfLaunches"
    private let inputTextKey = "InputText"
    private let segmentIndex = "SegmentControlIndex"
}

