//
//  ViewController.swift
//  3-lab
//
//  Created by Temirbek Balabek on 3/2/20.
//  Copyright © 2020 kbtu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItem = addButton
    }
    @objc func addButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard
            let selectVC = storyboard.instantiateViewController(identifier: "SecondViewController") as? SecondViewController
        else { return }
        
        selectVC.onSave = { (x, y, w, h, c) in
            print(x,y,w,h)
            let nextView = UIView()
            nextView.backgroundColor = c
            nextView.frame = CGRect(x: x, y: y, width: w, height: h)
            self.view.addSubview(nextView)
//            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.figureDidTap))
//            nextView.addGestureRecognizer(tapGestureRecognizer)
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.viewDidPan(recognizer:)))
            nextView.addGestureRecognizer(panGestureRecognizer)
            
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.viewDidPinch))
            nextView.addGestureRecognizer(pinchGestureRecognizer)
            self.navigationController?.popViewController(animated: true)
        }
        self.navigationController?.pushViewController(selectVC, animated: true)
        
    }
//    @objc func figureDidTap(_ sender: UITapGestureRecognizer) {
//        if let nextView = sender.view {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(identifier: "SecondViewController") as CreateFigureViewController
//            vc.selectedFigure = figure
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
    var baseOrigin: CGPoint!
    @objc func viewDidPan(recognizer: UIPanGestureRecognizer) {
        if let nextView = recognizer.view {
            switch recognizer.state {
            case .began:
                baseOrigin = nextView.frame.origin
            case .changed:
                let d = recognizer.translation(in: nextView)
                nextView.frame.origin.x = baseOrigin.x + d.x
                nextView.frame.origin.y = baseOrigin.y + d.y
            default: break
            }
        }
    }
//    @IBAction func viewDidPinch(_ gestureRecognizer : UIPinchGestureRecognizer) {   guard gestureRecognizer.view != nil else { return }
//
//    if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
//       gestureRecognizer.view?.transform = (gestureRecognizer.view?.transform.
//                     scaledBy(x: gestureRecognizer.scale, y: gestureRecognizer.scale))!
//       gestureRecognizer.scale = 1.0
//    }}

    @objc func viewDidPinch(_ sender: UIPinchGestureRecognizer) {
        if let figure = sender.view {
            if sender.state == .began || sender.state == .changed {
                figure.transform = (figure.transform.scaledBy(x: sender.scale, y: sender.scale))
               sender.scale = 1.0
            }
        }
    }
}

