import SnapKit
import UIKit

final class DetailView: UIView {
    
    // MARK: - Views
    
    private lazy var loadingView = LoadingView()
    
    private lazy var errorView = ErrorView()
    
    private lazy var emptyView = EmptyView()
    
    private lazy var contentView = UIView()
    private lazy var weatherView = UIView()
    
    private lazy var currentWeatherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 44)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var temperatureView = UIView()
    
    private lazy var minTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var maxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViewLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Accessors

extension DetailView {
    func revealLoadingState() {
        bringSubviewToFront(loadingView)
    }
    
    func revealSuccessState(with viewModel: DetailViewModeling) {
        currentWeatherLabel.text = viewModel.weather
        stateLabel.text = viewModel.state
        minTemperatureLabel.text = viewModel.minTemperature
        maxTemperatureLabel.text = viewModel.maxTemperature
        
        bringSubviewToFront(contentView)
    }
    
    func revealErrorState(with viewModel: ErrorViewModeling) {
        errorView.setup(with: viewModel)
        bringSubviewToFront(errorView)
    }
    
    func revealEmptyState() {
        emptyView.setup()
        bringSubviewToFront(emptyView)
    }
}

// MARK: - ViewLayoutable

extension DetailView: ViewLayoutable {
    func buildViewHierarchy() {
        addSubview(loadingView)
        addSubview(errorView)
        addSubview(emptyView)
        addSubview(contentView)
        contentView.addSubview(weatherView)
        weatherView.addSubview(currentWeatherLabel)
        weatherView.addSubview(stateLabel)
        weatherView.addSubview(temperatureView)
        temperatureView.addSubview(minTemperatureLabel)
        temperatureView.addSubview(maxTemperatureLabel)
    }
    
    func buildViewConstraints() {
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        errorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        weatherView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        currentWeatherLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        stateLabel.snp.makeConstraints {
            $0.top.equalTo(currentWeatherLabel.snp.bottom).offset(Size.base2)
            $0.leading.trailing.equalToSuperview()
        }
        
        temperatureView.snp.makeConstraints {
            $0.top.equalTo(stateLabel.snp.bottom).offset(Size.base2)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Size.base2)
        }
        
        minTemperatureLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        maxTemperatureLabel.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalTo(minTemperatureLabel.snp.trailing).offset(Size.base1)
        }
    }
    
    func additionalConfig() {
        backgroundColor = .systemBackground
        contentView.backgroundColor = .systemBackground
    }
}
