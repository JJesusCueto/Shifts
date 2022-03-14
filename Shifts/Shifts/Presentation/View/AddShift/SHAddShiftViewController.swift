//
//  SHAddShiftViewController.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import UIKit

protocol SHAddShiftViewDelegate: AnyObject {
    func didAdd(shift newShift: SHShiftData)
}

protocol SHAddShiftView: AnyObject {
    func didRetrieveData()
    func updateTextField(from tag: Int, info: String)
}

class SHAddShiftViewController: UIViewController {

    // MARK: - Properties
    weak var delegate: SHAddShiftViewDelegate?
    lazy var configurator: SHAddShiftConfigurator = { return SHAddShiftConfigurator(from: self) }()
    private lazy var presenter: SHAddShiftPresenterProtocol = { return self.configurator.configure() }()
    // MARK: - View Properties
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 20.0, right: 0.0)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var saveButton: UIBarButtonItem = {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveAction))
        doneButton.isEnabled = false
        return doneButton
    }()
    private lazy var inputToolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBar.tintColor = .systemBlue
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [spaceButton, doneButton]
        return toolBar
    }()
    private lazy var startDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Date()
        var dateComponent = DateComponents()
        dateComponent.hour = +12
        datePicker.maximumDate = Calendar(identifier: .gregorian).date(byAdding: dateComponent, to: Date())
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        return datePicker
    }()
    private lazy var infoPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    private lazy var vInfoStack: UIStackView = {
        let stackView = UIStackView(frame: .infinite)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 12.0
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        let navigationitem = UINavigationItem(title: NSLocalizedString(SHKeys.MessageKeys.addShiftControllerTitle, comment: SHKeys.MessageKeys.emptyText))
        navigationitem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction))
        navigationitem.rightBarButtonItem = saveButton
        navigationBar.setItems([navigationitem], animated: false)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        self.initView()
        self.presenter.loadData()
    }
    
    // MARK: - Selectors
    @objc private func dateChanged(_ sender: UIDatePicker) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        self.presenter.updateEntry(from: dateFormatterGet.string(from: sender.date))
    }
    
    @objc private func doneAction() {
        switch self.presenter.tag {
        case 0,1:
            self.dateChanged(self.startDatePicker)
        case 2,3,4:
            self.presenter.updateEntry(from: "\(self.infoPicker.selectedRow(inComponent: 0))")
        default: break
        }
        
        self.view.endEditing(true)
    }
    
    @objc private func cancelAction() {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func saveAction() {
        self.view.endEditing(true)
        self.presenter.addShift()
    }
    
    // MARK: - Setup
    private func initView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.navigationBar)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.vInfoStack)
        // Nav bar
        NSLayoutConstraint.activate([self.navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                                     self.navigationBar.heightAnchor.constraint(equalToConstant: 44.0),
                                     self.navigationBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.navigationBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)])
        // ScrollView
        NSLayoutConstraint.activate([self.scrollView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor),
                                     self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                                     self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)])
        //ContentView
        NSLayoutConstraint.activate([self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                                     self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
                                     self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                                     self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
                                     self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)])
        // UIStackView
        NSLayoutConstraint.activate([self.vInfoStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16.0),
                                     self.vInfoStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                                     self.vInfoStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
                                     self.vInfoStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16.0)])
        self.addShowInfo(title: "Start Date: ", isDate: true, tag: 0)
        self.addShowInfo(title: "End Date: ", isDate: true, tag: 1)
        self.addShowInfo(title: "Employee: ", isDate: false, tag: 2)
        self.addShowInfo(title: "Role: ", isDate: false, tag: 3)
        self.addShowInfo(title: "Color: ", isDate: false, tag: 4)
    }
    
    private func addShowInfo(title: String, isDate: Bool, tag: Int) {
        let detailView: SHShiftInfoView = SHShiftInfoView(from: title, delegate: self, tag: tag)
        detailView.descriptionTextField.inputView = isDate ? self.startDatePicker : self.infoPicker
        self.inputToolBar.sizeToFit()
        detailView.descriptionTextField.inputAccessoryView = self.inputToolBar
        self.vInfoStack.addArrangedSubview(detailView)
    }
}

extension SHAddShiftViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.presenter.numberOfItems
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.presenter.item(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.presenter.updateEntry(from: "\(row)")
    }
}

extension SHAddShiftViewController: SHAddShiftView {
    func didRetrieveData() {
        
    }
    
    func updateTextField(from tag: Int, info: String) {
        guard let infoView = self.vInfoStack.subviews.filter({ ($0.tag == tag) }).first as? SHShiftInfoView else { return }
        infoView.descriptionTextField.text = info
        self.saveButton.isEnabled = self.presenter.isReady
    }
}

extension SHAddShiftViewController: SHShiftInfoViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.presenter.tag = textField.tag
        self.infoPicker.reloadAllComponents()
    }
}
