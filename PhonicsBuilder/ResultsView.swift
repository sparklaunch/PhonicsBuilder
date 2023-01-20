import SwiftUI

struct ResultsView: View {
    @EnvironmentObject private var resultsManager: ResultsManager
    @ViewBuilder var gradeView: some View {
        switch Int(resultsManager.results.totalScore) {
            case Constants.excellentThreshold...:
                ExcellentView()
            case Constants.goodThreshold...:
                GoodView()
            default:
                NiceTryView()
        }
    }
    var body: some View {
        gradeView
    }
}
