//
//  CreateFolderAlert.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 03.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

class CreateFolderAlert: UIViewController {
    
    var alertTitle = ""
    var alertMessage = ""
    var resultHandler: ((String) -> Void)?

    private enum LocalizedString {
        static let placeholder = "Введите название папки"
        static let create = "Создать"
        static let cancel = "Отмена"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAlert()
    }

    private func showAlert() {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = LocalizedString.placeholder
        }
        let create = UIAlertAction(title: LocalizedString.create, style: .default) { [weak self] _ in
            let text = alert.textFields?.first?.text ?? ""
            self?.dismiss(animated: false) { [weak self] in
                self?.resultHandler?(text)
            }
        }
        let cancel = UIAlertAction(title: LocalizedString.cancel, style: .cancel) { [weak self] _ in
            self?.dismiss(animated: false)
        }
        alert.addAction(create)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
