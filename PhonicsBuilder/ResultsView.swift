import SwiftUI

struct ResultsView: View {
    @EnvironmentObject private var resultsManager: ResultsManager
    @ViewBuilder var gradeView: some View {
        switch resultsManager.results.totalScore {
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
