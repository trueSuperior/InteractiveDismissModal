//
//  ModalViewController.swift
//  InteractiveDismissModal
//
//  Created by 池田 優真 on 2019/03/18.
//  Copyright © 2019 UMA. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        guard let interactor = self.interactor else { return }
        // 遷移キャンセルのしきい値
        let percentThreshold: CGFloat = 0.3
        // ジェスチャー移動量
        let translation = sender.translation(in: view)
        // 画面全体サイズでみた縦方向の移動量割合
        let verticalMovement = translation.y / view.bounds.height
        // 下限を0.0に制限
        let downwardMovement = max(verticalMovement, 0.0)
        // 上限を1.0に制限
        let progress = min(downwardMovement, 1.0)
        
        // 下方スクロールでスクロール最上部の場合にとじる遷移を開始する
        let hasDown = downwardMovement > 0
        let isAtTop = scrollView.contentOffset.y <= -scrollView.contentInset.top
        if hasDown && isAtTop {
            if (!interactor.hasStarted) {
                interactor.hasStarted = true
                dismiss(animated: true, completion: nil)
                // ジェスチャー移動量を0からとする
                sender.setTranslation(.zero, in: view)
            }
        }
        
        switch sender.state {
        case .began:
            print("Begin!")
            break
        case .changed:
            interactor.update(progress)
        default:
            interactor.hasStarted = false
            if progress > percentThreshold  {
                interactor.finish()
            } else {
                interactor.cancel()
            }
        }
    }
    
    var interactor: Interactor?
    
    @IBAction func tapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ModalViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
