//
//  RootTabBarController.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 20.04.22.
//

import UIKit

class RootTabBarController<BarItem: RootBarItemProtocol>: UIViewController {

    private lazy var barView: RootTabBarView<BarItem> = {
        let bar = RootTabBarView(barItems: Array(barItems.keys), selectionHandler: { [weak self] barItem in
            self?.select(barItem: barItem)
        })
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private lazy var viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let barItems: [BarItem: UIViewController]
    
    init(barItems: [BarItem: UIViewController]) {
        self.barItems = barItems
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        if let firstBarItem = barItems.keys.first {
            barView.setSelected(barItem: firstBarItem)
        }
    }
    
    private func setupView() {
        view.backgroundColor = Asset.Colors.white.color
        
        view.addSubview(barView)
        NSLayoutConstraint.activate([
            barView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            barView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            barView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            barView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        view.addSubview(viewContainer)
        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: barView.topAnchor)
        ])
    }

    private func select(barItem: BarItem) {
        guard let vc = barItems[barItem] else { return }
        
        let navVc = UINavigationController(rootViewController: vc)
        present(navVc, in: viewContainer)
    }
    
}
