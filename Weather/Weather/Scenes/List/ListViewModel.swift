protocol ListViewModeling {
    var title: String { get }
}

struct ListViewModel: ListViewModeling {
    let title: String
}
