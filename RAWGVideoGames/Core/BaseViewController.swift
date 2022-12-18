//
//  BaseViewController.swift
//  RAWGVideoGames
//
//  Created by Yeliz Akkaya on 18.12.2022.
//

import UIKit
import MaterialActivityIndicator
import SwiftAlertView

class BaseViewController: UIViewController {

    let indicator = MaterialActivityIndicatorView()
    private var notificationManager: NotificationProtocol = LocalNotificationManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicatorView()
        localNotification()
    }
    
    private func setupActivityIndicatorView() {
        view.addSubview(indicator)
        setupActivityIndicatorViewConstraints()
    }
    
    private func setupActivityIndicatorViewConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func showErrorAlert(message: String) {
        SwiftAlertView.show(title: "Error".localized(),
                            message: message,
                            buttonTitles: ["OK".localized()])
    }
    
    func localNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    @objc func appMovedToBackground() {
        notificationManager.sendNotification(title: "Come Back".localized(), message: "If you like the application, do not forget to give a high rating🐣".localized())
    }
}

