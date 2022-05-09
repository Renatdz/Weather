import SnapKit
import UIKit

final class LoadingView: UIView {
    // MARK: - Views

    private lazy var indicatorView: UIActivityIndicatorView = {
        let view: UIActivityIndicatorView
        
        if #available(iOS 13.0, *) {
            view = UIActivityIndicatorView(style: .large)
        } else {
            view = UIActivityIndicatorView(style: .gray)
        }
        
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCodable

extension LoadingView: ViewLayoutable {
    func buildViewHierarchy() {
        addSubview(indicatorView)
    }

    func buildViewConstraints() {
        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func additionalConfig() {
        backgroundColor = .systemBackground
    }
}
