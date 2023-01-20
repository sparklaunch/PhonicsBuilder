import SwiftUI

struct ResultsView: View {
    @ViewBuilder var gradeView: some View {
        switch Int(ResultsManager.shared.results.totalScore) {
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
