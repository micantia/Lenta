//
//  RootTabBarView.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 20.04.22.
//

import Foundation
import UIKit

final class RootTabBarView<BarItem: RootBarItemProtocol>: UIView {
    
    private lazy var stackView = UIStackView()
    
    private var selectedBarItem: BarItem?
    private let barItems: [BarItem]
    private let selectionHandler: ((BarItem) -> Void)?
    
    init(barItems: [BarItem], selectionHandler: ((BarItem) -> Void)?) {
        self.barItems = barItems
        self.selectionHandler = selectionHandler
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelected(barItem: BarItem) {
        setSelectedBarItem(barItem)
    }
    
    private func setupView() {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = Asset.Colors.separatorColor.color
        
        addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.topAnchor.constraint(equalTo: topAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let barViewItems = mappedBarItems(barItems)
        barViewItems.forEach { stackView.addArrangedSubview($0) }
    }
    
    private func mappedBarItems(_ barItems: [BarItem]) -> [RootTabBarViewItem<BarItem>] {
        barItems.map { barItem in
            let view = RootTabBarViewItem(barItem: barItem, tapHandler: { [weak self] in
                self?.setSelectedBarItem(barItem)
            })
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
    }
    
    private func setSelectedBarItem(_ barItem: BarItem) {
        guard selectedBarItem != barItem else { return }
        selectedBarItem = barItem
        selectionHandler?(barItem)
        let barViewItems = stackView.arrangedSubviews.compactMap { $0 as? RootTabBarViewItem<BarItem> }
        barViewItems.forEach { barViewItem in
            barViewItem.setSelected(barItem == barViewItem.barItem)
        }
    }
    
}
