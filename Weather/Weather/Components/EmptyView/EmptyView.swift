import SnapKit
import UIKit

final class EmptyView: UIView {
    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
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

    func setup(with viewModel: EmptyViewModeling = EmptyViewModel.default) {
        titleLabel.text = viewModel.title
        messageLabel.text = viewModel.message
    }
}

// MARK: - ViewCodable

extension EmptyView: ViewLayoutable {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(messageLabel)
    }

    func buildViewConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Size.base5)
            $0.leading.trailing.equalToSuperview().inset(Size.base3)
        }

        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Size.base2)
            $0.leading.trailing.bottom.equalToSuperview().inset(Size.base3)
        }
    }

    func additionalConfig() {
        backgroundColor = .systemBackground
    }
}
