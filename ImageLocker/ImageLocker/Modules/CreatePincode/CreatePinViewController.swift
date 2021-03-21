//
//  CreatePinViewController.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 28.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit
import SnapKit

protocol CreatePinViewInput: class {
    
    var presenter: CreatePinViewOutput? { get set }
    var viewController: UIViewController { get }

    func setupAsConfirm()
}

class CreatePinViewController: UIViewController, CreatePinViewInput {
    
    var presenter: CreatePinViewOutput?
    var viewController: UIViewController { return self }

    private enum LocalizedString {
        static let createTitle = "Придумайте пин-код"
        static let confirmTitle = "Подтвердите пин-код"
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizedString.createTitle
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    private lazy var pincodeView: PincodeView = {
        let pincodeView = PincodeView()
        pincodeView.delegate = self.presenter as? PincodeViewDelegate
        pincodeView.backgroundColor = UIColor(red: 0.1, green: 0.7, blue: 0.9, alpha: 1.0)
        return pincodeView
    }()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .cyan
        view.addSubview(titleLabel)
        view.addSubview(pincodeView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        makeConstraints()
        presenter?.viewDidLoad(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pincodeView.resetView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pincodeView.becomeFirstResponder()
    }

    func setupAsConfirm() {
        titleLabel.text = LocalizedString.confirmTitle
    }

    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        pincodeView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
    }
}
