//
//  SHShiftInfoView.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import UIKit

protocol SHShiftInfoViewDelegate: AnyObject {
    func textFieldDidBeginEditing(_ textField: UITextField)
}

class SHShiftInfoView: UIView {

    private weak var delegate: SHShiftInfoViewDelegate?
    // MARK: - View Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var descriptionTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    // MARK: - Init
    init(from title: String, delegate: SHShiftInfoViewDelegate?, tag: Int) {
        super.init(frame: .infinite)
        self.initView()
        self.titleLabel.text = title
        self.titleLabel.sizeToFit()
        self.delegate = delegate
        self.tag = tag
        self.descriptionTextField.tag = tag
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func initView() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionTextField)
        NSLayoutConstraint.activate([self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
                                     self.titleLabel.trailingAnchor.constraint(equalTo: self.descriptionTextField.leadingAnchor, constant: -12.0),
                                     self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0),
                                     self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0)])
        NSLayoutConstraint.activate([self.descriptionTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
                                     self.descriptionTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0),
                                     self.descriptionTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0)])
    }
    
    func setupViews(title: String) {
        self.titleLabel.text = title
        self.titleLabel.sizeToFit()
    }
}

extension SHShiftInfoView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegate?.textFieldDidBeginEditing(textField)
    }
}
