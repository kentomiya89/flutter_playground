import EventKitUI
import Flutter
import UIKit

class CustomCalendarEventHandler: NSObject, CustomCalendarHostApi, EKEventEditViewDelegate {
  private var pendingCompletion: ((Result<Void, Error>) -> Void)?

  func createEvent(input: CalendarEventInput, completion: @escaping (Result<Void, Error>) -> Void) {
    guard
      let scene = UIApplication.shared.connectedScenes
        .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
      let vc = scene.keyWindow?.rootViewController
    else {
      completion(
        .failure(
          PigeonError(code: "NO_VC", message: "No active view controller found", details: nil)))
      return
    }

    let store = EKEventStore()
    let event = EKEvent(eventStore: store)
    event.title = input.title

    if let startMs = input.startDateMs {
      event.startDate = Date(timeIntervalSince1970: Double(startMs) / 1000)
    }
    if let endMs = input.endDateMs {
      event.endDate = Date(timeIntervalSince1970: Double(endMs) / 1000)
    }
    event.isAllDay = input.isAllDay ?? false
    event.notes = input.description
    event.location = input.location

    if let reminders = input.remindersSeconds {
      event.alarms = reminders.compactMap { seconds -> EKAlarm? in
        guard let s = seconds else { return nil }
        return EKAlarm(relativeOffset: -TimeInterval(s))
      }
    }

    let editVC = EKEventEditViewController()
    editVC.event = event
    editVC.eventStore = store
    editVC.editViewDelegate = self

    pendingCompletion = completion

    let topVC = topViewController(vc) ?? vc
    topVC.present(editVC, animated: true)
  }

  func eventEditViewController(
    _ controller: EKEventEditViewController,
    didCompleteWith action: EKEventEditViewAction
  ) {
    controller.dismiss(animated: true)
    switch action {
    case .canceled:
      pendingCompletion?(
        .failure(PigeonError(code: "CANCELED", message: "User canceled", details: nil)))
    case .saved, .deleted:
      pendingCompletion?(.success(()))
    @unknown default:
      pendingCompletion?(.success(()))
    }
    pendingCompletion = nil
  }

  private func topViewController(_ base: UIViewController) -> UIViewController? {
    if let nav = base as? UINavigationController {
      return topViewController(nav.visibleViewController ?? nav)
    }
    if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
      return topViewController(selected)
    }
    if let presented = base.presentedViewController {
      return topViewController(presented)
    }
    return base
  }
}
