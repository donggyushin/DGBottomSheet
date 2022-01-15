import Foundation
import UIKit

public class DGBottomSheet: UIViewController {
    
    private var contentsViewHeight: CGFloat = 300
    
    private lazy var dimmedView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = .black
        view.alpha = 0
        view.addGestureRecognizer(dimmedViewTap)
        return view
    }()
    
    private lazy var dimmedViewTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped))
    
    private let contentsView: UIView
    
    public init(view contentsView: UIView) {
        self.contentsView = contentsView
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        configureUI()
    }
    
    private func configureUI() {
        if let contentsViewHeight = contentsView.constraints.filter({ $0.firstAttribute == .height }).compactMap({ $0.constant }).first {
            self.contentsViewHeight = contentsViewHeight
        }
        
        contentsView.layer.cornerRadius = 20
        contentsView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubview(dimmedView)
        view.addSubview(contentsView)
        contentsView.translatesAutoresizingMaskIntoConstraints = false
        contentsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentsView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentsView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        show(contentsViewHeight: contentsViewHeight)
        
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        contentsView.addGestureRecognizer(viewPan)
    }
    
    @objc private func dimmedViewTapped() {
        self.hide()
    }
    
    @objc private func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: self.view)
        let velocity = panGestureRecognizer.velocity(in: self.view)
        
        switch panGestureRecognizer.state {
        case .changed:
            if translation.y > 0 {
                contentsView.transform = .init(translationX: 0, y: translation.y)
            }
        case .ended:
            if translation.y > 200 || velocity.y > 1500 {
                self.hide()
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.contentsView.transform = .init(translationX: 0, y: 0)
                }
                
            }
        default: break
        }
    }
    
    private func show(contentsViewHeight: CGFloat) {
        self.contentsView.transform = .init(translationX: 0, y: contentsViewHeight)
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                self.dimmedView.alpha = 0.4
                self.contentsView.transform = .init(translationX: 0, y: 0)
            }
        }
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.3) {
            self.dimmedView.alpha = 0
            self.contentsView.transform = .init(translationX: 0, y: self.contentsViewHeight)
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}
