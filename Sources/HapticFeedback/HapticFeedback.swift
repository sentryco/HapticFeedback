import Foundation
#if os(iOS)
import UIKit
/**
 * Provides a more convenient name for the HapticFeedback class.
 * - Description: This typealias simplifies the usage of 
 *                UIImpactFeedbackGenerator by providing a more 
 *                descriptive and context-specific name, enhancing 
 *                code readability and maintainability.
 * - Important: ⚠️️ All calls to this must be fenced for iOS
 * - Fixme: ⚠️️⚠️️ Maybe unfence this class and just do nothing if macOS etc 👈 maybe 👉 make another class that does that on top of this? 👈
 * Example usage:
 * ```swift
 * // Create an instance of the HapticFeedback class
 * let feedback = HapticFeedback()
 * 
 * // Trigger a haptic feedback vibration
 * feedback.vibrate()
 * ```
 */
public typealias HapticFeedback = UIImpactFeedbackGenerator
public typealias Haptic = HapticFeedback // Convenient

extension HapticFeedback {
   /**
    * Triggers a haptic feedback vibration.
    * - Description: Initiates a haptic feedback response using the default intensity.
    * - Note: Intensity support is not yet implemented.
    * - Example: To trigger a medium intensity haptic feedback, use:
    *   ```swift
    *   let feedback = HapticFeedback(style: .medium)
    *   feedback.vibrate()
    *   ```
    */
   public func vibrate(/*style: UIImpactFeedbackGenerator.FeedbackStyle = .medium*/) {
      /*HapticFeedback(style: style).*/impactOccurred()
   }
}
/**
 * Play
 */
extension HapticFeedback {
   /**
    * Trigger (convenient)
    */
   public static func trigger(_ kind: Kind) {
      play(kind)
   }
   /**
    * An enumeration of haptic feedback types.
    * - Description: Executes the appropriate haptic feedback corresponding
    *                to the specific user interaction context.
    * - Example: 
    * ```swift
    * HapticFeedback.play(.appUnlocked)
    * ```
    * - Returns: An instance of the HapticFeedback.Kind enumeration, representing the type of haptic feedback.
    * - Parameters: 
    *   - kind: The type of haptic feedback to play.
    *   - style: only relevant for HapticFeedback
    */
   public static func play(_ kind: Kind) {
      // Switch on the type of haptic feedback
      switch kind {
         // Generate impact feedback for app unlock, context menu open, or password generation
      case .entry: // .appUnlocked, .contextMenuOpened, .passwordGenerated:
         HapticFeedback().impactOccurred()
         // Generate selection feedback for clipboard copy
      case .extract: //.copiedToClipboard:
         UISelectionFeedbackGenerator().selectionChanged()
         // Generate success notification feedback for credentials pasted
      case .success: // .credentialsPasted:
         UINotificationFeedbackGenerator().notificationOccurred(.success)
         // Generate warning notification feedback for wrong password
      case .deny: // .wrongPassword:
         UINotificationFeedbackGenerator().notificationOccurred(.warning)
         // Generate warning notification feedback for error
      case .failure: // .error:
         UINotificationFeedbackGenerator().notificationOccurred(.error)
         // Generate success notification feedback for QR code scanned
      case .exit: // .qrCodeScanned:
         UINotificationFeedbackGenerator().notificationOccurred(.warning)
      }
   }
}
#else
public typealias HapticFeedback = NSObject
/**
 * This avoids having operating system fencing in the app code etc
 */
extension HapticFeedback {
   /**
    * Plays a haptic feedback effect on macOS (Currently not supported)
    * - Description: This method is a stub implementation for macOS compatibility.
    *                While haptic feedback is not supported on macOS, this method
    *                exists to maintain API consistency across platforms.
    * - Parameter kind: The type of haptic feedback that would be played on iOS.
    *                   On macOS this parameter has no effect.
    */
   public static func play(_ kind: Kind) {
      // not supported by macOS
   }
   /**
    * Triggers a vibration feedback effect on macOS (Currently not supported)
    * - Description: This method is a stub implementation for macOS compatibility.
    *                While vibration feedback is not supported on macOS, this method
    *                exists to maintain API consistency across platforms.
    * - Note: This is a no-op method on macOS since haptic/vibration feedback
    *         is not available on macOS devices
    */
   public func vibrate() {
      // not supported by macOS
   }
}
#endif
/**
 * An enumeration of haptic feedback types.
 * - Description: Enumerates the different types of haptic feedback that
 *                can be triggered in response to various user actions
 *                within the app.
 */
extension HapticFeedback {
   public enum Kind {
      // Triggered when accessing secure or main features (menu is opened, appUnlocked)
      case entry
      // Triggered when leaving a secure or main feature (exit modal or menu)
      case exit
      // Triggered by successful completion of an action (a password is generated, When QR is found)
      case success
      // Triggered by authentication failures or mismatches (Wrote wrong password in auth, or password)
      case deny
      // Triggered by operational failures (When error occurs)
      case failure
      // Triggered by data extraction actions (On clipboard copy)
      case extract
   }
}
// Deprecated ⚠️️
extension HapticFeedback {
   public var appUnlocked: Kind {
      .entry
   }
   public var contextMenuOpened: Kind {
      .entry
   }
   public var copiedToClipboard: Kind {
      .extract
   }
   public var sucessfulAction: Kind {
      .success
   }
   public var wrong: Kind {
      .deny
   }
   public var wrongPassword: Kind {
      .deny
   }
   public var error: Kind {
      .failure
   }
   public var qrCodeScanned: Kind {
      .extract
   }
   public var passwordGenerated: Kind {
      .success
   }
}
