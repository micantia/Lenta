//
//  RootTabBarViewItem.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 20.04.22.
//

import Foundation
import UIKit

final class RootTabBarViewItem<BarItem: RootBarItemProtocol>: UIView {
    
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontFamily.Gilroy.medium.font(size: 12)
        label.textColor = Asset.Colors.Text.subtitle.color
        label.setContentHuggingPriority(.required, for: .vertical)
        label.textAlignment = .center
        return label
    }()
    
    let barItem: BarItem
    private let tapHandler: (() -> Void)?
    
    init(barItem: BarItem, tapHandler: (() -> Void)?) {
        self.barItem = barItem
        self.tapHandler = tapHandler
        super.init(frame: .zero)
        setupView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelected(_ selected: Bool) {
        iconView.image = selected ? barItem.activeIcon : barItem.inActiveIcon
        titleLabel.textColor = selected ? Asset.Colors.Text.title.color : Asset.Colors.Text.subtitle.color
    }
    
    private func setupView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        [iconView, titleLabel].forEach { stackView.addArrangedSubview($0) }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(itemTapped))
        addGestureRecognizer(tap)
    }
    
    private func configure() {
        iconView.image = barItem.inActiveIcon
        titleLabel.text = barItem.title
    }
    
    @objc private func itemTapped() {
        tapHandler?()
    }
}
