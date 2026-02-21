import SwiftUI

final class ProgressManager: ObservableObject {
    
    @AppStorage("totalSessions") var totalSessions: Int = 0
    @AppStorage("currentStreak") var currentStreak: Int = 0
    @AppStorage("lastPracticeDate") var lastPracticeDateString: String = ""
    
    var lastPracticeDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: lastPracticeDateString)
    }
    
    func recordSession() {
        totalSessions += 1
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayStr = formatter.string(from: Date())
        
        if todayStr == lastPracticeDateString {
            return
        }
        
        if let lastDate = lastPracticeDate {
            let calendar = Calendar.current
            let daysBetween = calendar.dateComponents([.day], from: lastDate, to: Date()).day ?? 0
            
            if daysBetween == 1 {
                currentStreak += 1
            } else if daysBetween > 1 {
                currentStreak = 1
            }
        } else {
            currentStreak = 1
        }
        
        lastPracticeDateString = todayStr
        objectWillChange.send()
    }
    
    var levelTitle: String {
        switch currentStreak {
        case 0: return "Beginner"
        case 1...3: return "Learner"
        case 4...7: return "Aware"
        case 8...14: return "Confident"
        default: return "Champion"
        }
    }
    
    var levelIcon: String {
        switch currentStreak {
        case 0: return "leaf"
        case 1...3: return "flame"
        case 4...7: return "bolt.fill"
        case 8...14: return "star.fill"
        default: return "crown.fill"
        }
    }
    
    var motivationalMessage: String {
        switch totalSessions {
        case 0: return "Start your first practice session!"
        case 1...3: return "Great start! Keep building awareness."
        case 4...10: return "You're getting stronger every day."
        case 11...25: return "Impressive dedication to safety!"
        default: return "You're a safety awareness champion!"
        }
    }
}
