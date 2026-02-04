//
//  GameViewController.swift
//  act3
//
//  Created by Alumno on 26/01/26.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - Elementos del juego
    var targetView: UIView!        // Objeto a tocar
    var scoreLabel: UILabel!       // Puntaje
    var timeLabel: UILabel!        // Tiempo
    var startButton: UIButton!    // Botón iniciar

    // MARK: - Variables del juego
    var score = 0
    var timeRemaining = 30
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    // Crear interfaz con UIKit
    func setupUI() {

        // Label de puntaje
        scoreLabel = UILabel(frame: CGRect(x: 20, y: 50, width: 200, height: 30))
        scoreLabel.text = "Puntos: 0"
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(scoreLabel)

        // Label de tiempo
        timeLabel = UILabel(frame: CGRect(x: view.frame.width - 150, y: 50, width: 130, height: 30))
        timeLabel.text = "Tiempo: 30"
        timeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(timeLabel)

        // Botón iniciar
        startButton = UIButton(type: .system)
        startButton.frame = CGRect(x: view.frame.midX - 75, y: view.frame.height - 100, width: 150, height: 44)
        startButton.setTitle("Iniciar Juego", for: .normal)
        startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        view.addSubview(startButton)

        // Objeto del juego (círculo)
        targetView = UIView(frame: CGRect(x: 100, y: 200, width: 80, height: 80))
        targetView.backgroundColor = .systemBlue
        targetView.layer.cornerRadius = 40
        targetView.isHidden = true
        view.addSubview(targetView)

        // Gesto de toque
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(targetTapped))
        targetView.addGestureRecognizer(tapGesture)
    }

    // Iniciar juego
    @objc func startGame() {
        score = 0
        timeRemaining = 30

        scoreLabel.text = "Puntos: 0"
        timeLabel.text = "Tiempo: 30"

        targetView.isHidden = false
        startButton.isEnabled = false
        moveTarget()

        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTime),
                                     userInfo: nil,
                                     repeats: true)
    }

    // Actualizar tiempo
    @objc func updateTime() {
        timeRemaining -= 1
        timeLabel.text = "Tiempo: \(timeRemaining)"

        if timeRemaining <= 0 {
            endGame()
        }
    }

    // Cuando tocan el círculo
    @objc func targetTapped() {
        score += 1
        scoreLabel.text = "Puntos: \(score)"
        moveTarget()
        animateTarget()
    }

    // Movimiento aleatorio
    func moveTarget() {
        let maxX = view.bounds.width - targetView.frame.width
        let maxY = view.bounds.height - targetView.frame.height

        let randomX = CGFloat.random(in: 0...maxX)
        let randomY = CGFloat.random(in: 120...maxY)

        targetView.frame.origin = CGPoint(x: randomX, y: randomY)
    }

    // Animación
    func animateTarget() {
        UIView.animate(withDuration: 0.2,
                       animations: {
                        self.targetView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                       }) { _ in
            self.targetView.transform = .identity
        }
    }

    // Final del juego
    func endGame() {
        timer?.invalidate()
        timer = nil

        targetView.isHidden = true
        startButton.isEnabled = true

        let alert = UIAlertController(
            title: "Juego terminado",
            message: "Puntaje final: \(score)",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
