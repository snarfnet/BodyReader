import Foundation
import Combine

class DictionaryViewModel: ObservableObject {
    @Published var categories: [BodySignalCategory] = []
    @Published var searchText: String = ""
    @Published var selectedCategory: BodySignalCategory?

    init() {
        loadData()
    }

    private func loadData() {
        guard let url = Bundle.main.url(forResource: "body_signals", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        let decoded = try? JSONDecoder().decode([BodySignalCategory].self, from: data)
        categories = decoded ?? []
    }

    var filteredCategories: [BodySignalCategory] {
        if searchText.isEmpty { return categories }
        return categories.map { category in
            let filtered = category.signals.filter {
                $0.nameJP.localizedCaseInsensitiveContains(searchText) ||
                $0.nameEN.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
            return BodySignalCategory(id: category.id, name: category.name, icon: category.icon, signals: filtered)
        }.filter { !$0.signals.isEmpty }
    }

    var allSignals: [BodySignal] {
        categories.flatMap { $0.signals }
    }
}
