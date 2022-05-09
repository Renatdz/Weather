import SnapKit
import UIKit

final class ErrorView: UIView {
    // MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Size.base3
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTouchActionButton), for: .touchUpInside)
        return button
    }()

    // MARK: - Properties

    var onActionButtonTouched: (() -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViewLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    func setup(with viewModel: ErrorViewModeling) {
        titleLabel.text = viewModel.title
        messageLabel.text = viewModel.message
        actionButton.setTitle(viewModel.actionTitle, for: .normal)
    }
    
    // MARK: - Handlers
    
    @objc
    private func didTouchActionButton() {
        onActionButtonTouched?()
    }
}

// MARK: - ViewCodable

extension ErrorView: ViewLayoutable {
    public func buildViewHierarchy() {
        addSubview(stackView)
        addSubview(actionButton)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)
    }

    public func buildViewConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Size.base2)
            $0.leading.trailing.equalToSuperview().inset(Size.base2)
        }

        actionButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(stackView.snp.bottom).offset(Size.base2)
            $0.leading.trailing.equalToSuperview().inset(Size.base2)
            $0.bottom.equalToSuperview().inset(Size.base3)
            $0.height.equalTo(Size.base4)
        }
    }

    public func additionalConfig() {
        backgroundColor = .systemBackground
    }
}
