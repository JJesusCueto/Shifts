//
//  SHShiftTableViewCell.swift
//  Shifts
//
//  Created by Jesus Cueto on 3/14/22.
//

import UIKit

class SHShiftTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let viewWidthConstant: CGFloat = 4.0
    private let paddingConstant: CGFloat = 8.0
    // MARK: - UIViews
    private lazy var frameColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var shiftInfoLabel: UILabel = {
        let label = UILabel()
        label.text = SHKeys.MessageKeys.emptyText
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var shiftScheduleLabel: UILabel = {
        let label = UILabel()
        label.text = SHKeys.MessageKeys.emptyText
        label.textAlignment = .right
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    override func prepareForReuse() {
        super.prepareForReuse()
        self.frameColorView.backgroundColor = .clear
        self.shiftInfoLabel.text = SHKeys.MessageKeys.emptyText
        self.shiftScheduleLabel.text = SHKeys.MessageKeys.emptyText
    }
    
    private func initViews() {
        self.backgroundColor = .clear
        // Add Views
        self.addSubview(self.frameColorView)
        self.addSubview(self.separatorView)
        self.addSubview(self.shiftInfoLabel)
        self.addSubview(self.shiftScheduleLabel)
        // Color view
        NSLayoutConstraint.activate([self.frameColorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     self.frameColorView.topAnchor.constraint(equalTo: self.topAnchor),
                                     self.frameColorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                     self.frameColorView.widthAnchor.constraint(equalToConstant: self.viewWidthConstant)])
        // Separator view
        NSLayoutConstraint.activate([self.separatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.frame.width * 0.3),
                                     self.separatorView.topAnchor.constraint(equalTo: self.topAnchor),
                                     self.separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                     self.separatorView.widthAnchor.constraint(equalToConstant: self.viewWidthConstant)])
        // Info label
        NSLayoutConstraint.activate([self.shiftInfoLabel.leadingAnchor.constraint(equalTo: self.frameColorView.trailingAnchor, constant: self.paddingConstant),
                                     self.shiftInfoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: self.paddingConstant),
                                     self.shiftInfoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.paddingConstant),
                                     self.shiftInfoLabel.trailingAnchor.constraint(equalTo: self.separatorView.leadingAnchor, constant: .zero)])
        // Schedule label
        NSLayoutConstraint.activate([self.shiftScheduleLabel.leadingAnchor.constraint(equalTo: self.separatorView.trailingAnchor, constant: .zero),
                                     self.shiftScheduleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                     self.shiftScheduleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.paddingConstant)])
    }
    
    func setupViews(from shift: SHShiftData) {
        self.frameColorView.backgroundColor = SHKeys.Colors.color(fromName: shift.color)
        self.shiftScheduleLabel.text = shift.schedule
        self.shiftInfoLabel.text = shift.information
        self.shiftInfoLabel.sizeToFit()
    }
}
