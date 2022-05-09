import SnapKit
import UIKit

final class ListView: UIView {
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        return tableView
    }()
    
    // MARK: - Properties
    
    private var viewModels: [ListViewModeling] = []
    
    var onSelectRowTouched: ((Int) -> Void)?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        buildViewLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModels: [ListViewModeling]) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
    
    private func didTouchSelectRow(at index: Int) {
        onSelectRowTouched?(index)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension ListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        NSLocalizedString("list.header", comment: "")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let viewModel = viewModels[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.title
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTouchSelectRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: - ViewLayoutable

extension ListView: ViewLayoutable {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func buildViewConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func additionalConfig() {
        backgroundColor = .systemBackground
    }
}
