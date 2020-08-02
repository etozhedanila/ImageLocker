//
//  EnterPincodeViewController.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 29.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit
import LocalAuthentication

protocol EnterPincodeViewInput: class {
    var viewController: UIViewController { get }
    var presenter: EnterPincodeViewOutput? { get set }
    func reset()
}

class EnterPincodeViewController: UIViewController, EnterPincodeViewInput {
    var viewController: UIViewController { return self }
    var presenter: EnterPincodeViewOutput?

    private enum LocalizedString {
        static let title = "Введите пин-код"
    }

    private lazy var pincodeView: PincodeView = {
        let pincodeView = PincodeView()
        pincodeView.delegate = self.presenter as? PincodeViewDelegate
        pincodeView.backgroundColor = UIColor(red: 0.1, green: 0.7, blue: 0.9, alpha: 1.0)
        return pincodeView
    }()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .cyan
        view.addSubview(pincodeView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizedString.title
        makeConstraints()
        presenter?.viewDidLoad(self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pincodeView.becomeFirstResponder()
        activateBiometricAuthentication()
    }

    func reset() {
        pincodeView.resetView()
    }

    private func activateBiometricAuthentication() {
        let context = LAContext()
        let localizedReason = "Hi!"
        var authError: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: localizedReason) { [weak self] (isSuccess, error) in
                guard let self = self else { return }
                if isSuccess {
                    DispatchQueue.main.async {
                        self.presenter?.viewDidPassAuth(self)
                    }
                } else {
                    print(String(describing: error))
                }
            }
        } else {
            print("can't EvaluatePolicy")
        }
    }

    private func makeConstraints() {
        pincodeView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
    }
}
