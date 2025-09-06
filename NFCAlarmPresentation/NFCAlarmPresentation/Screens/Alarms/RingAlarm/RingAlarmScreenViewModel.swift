import Foundation
import CoreNFC

@MainActor
class RingAlarmScreenViewModel: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate {
    
    private var session: NFCNDEFReaderSession?
    
    func startNFC() {
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.begin()
    }
    
    nonisolated func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: any Swift.Error) {
        print(error)
    }
        
    nonisolated func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print(messages)
//        DispatchQueue.main.async {
//            self.stopAlarm()
//        }
    }
}
