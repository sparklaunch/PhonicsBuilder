import SwiftUI

struct ResultsView: View {
    @ViewBuilder var gradeView: some View {
        switch ResultsManager.shared.results.totalScore {
            case 70...:
                ExcellentView()
            case 30...:
                GoodView()
            default:
                NiceTryView()
        }
    }
    var body: some View {
        gradeView
    }
}
