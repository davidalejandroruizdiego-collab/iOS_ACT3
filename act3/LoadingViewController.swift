//
//  LoadingViewController.swift
//  act3
//
//  Created by Alumno on 28/01/26.
//

import UIKit

class LoadingViewController: UIViewController {

    // Vista que girará (spinner)
    var spinnerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupSpinner()
        startSpinAnimation()
        goToGameAfterDelay()
    }

    // Crea el objeto que gira
    func setupSpinner() {
        spinnerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        spinnerView.center = view.center
        spinnerView.backgroundColor = .systemBlue
        spinnerView.layer.cornerRadius = 50
        view.addSubview(spinnerView)
    }

    // Animación de rotación infinita
    func startSpinAnimation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = CGFloat.pi * 2
        rotation.duration = 1
        rotation.repeatCount = .infinity

        spinnerView.layer.add(rotation, forKey: "spin")
    }

    // Cambia al juego después de 3 segundos
    func goToGameAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let gameVC = GameViewController()
            gameVC.modalPresentationStyle = .fullScreen
            self.present(gameVC, animated: true)
        }
    }
}
