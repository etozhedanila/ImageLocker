//
//  FolderCell.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 25.07.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

struct FolderModel {
    var name: String
}

class FolderCellConfigurator: TableCellConfigurator<FolderCell, FolderModel> {
    init(model: FolderModel) {
        super.init(model: model, height: 100)
    }
}

class FolderCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private let folderImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "folder_icon")
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(folderImage)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeConstraints() {
        folderImage.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(20)
            make.height.width.equalTo(60)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(folderImage.snp.trailing).offset(10)
            make.centerY.equalTo(folderImage)
            make.trailing.equalToSuperview().inset(20)
        }
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)

    }
}

extension FolderCell: ConfigurableCell {
    func configure(model: FolderModel) {
        nameLabel.text = model.name
    }
}
