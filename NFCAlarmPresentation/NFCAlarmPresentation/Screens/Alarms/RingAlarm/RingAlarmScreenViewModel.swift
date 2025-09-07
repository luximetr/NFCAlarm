import Foundation
import CoreNFC

@MainActor
class RingAlarmScreenViewModel: NSObject, ObservableObject, NFCNDEFReaderSessionDelegate, NFCTagReaderSessionDelegate {
    
    private var session: NFCTagReaderSession?
//    private var session: NFCNDEFReaderSession?
    
    func startNFC() {
        session = NFCTagReaderSession(pollingOption: [.iso14443, .iso15693, .iso18092, .pace], delegate: self)
//        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session?.begin()
    }
    
    nonisolated func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: any Swift.Error) {
        print(error)
    }
    
    
    nonisolated func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        
    }
    
    nonisolated func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: any Swift.Error) {
        print(error)
    }
    
    nonisolated func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        print("tagReaderSession didDetect tags")
        guard let tag = tags.first else { return }
        session.connect(to: tag) { error in
            if let error = error {
                print("Connect error: \(error.localizedDescription)")
                return
            }
            switch tag {
            case .miFare(let miFareTag):
                let uid = miFareTag.identifier.map { String(format: "%02x", $0) }.joined()
                print("MiFare tag")
            case .feliCa(let feliCaTag):
                print("FeliCa tag")
            case .iso15693(let iso15693Tag):
                print("ISO15693 tag")
            case .iso7816(let iso7816Tag):
                print("ISO7816 tag")
            default:
                print("Unknown tag")
            }
            session.invalidate()
        }
    }
        
    nonisolated func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        guard let message = messages.first else { return }
        guard let record = message.records.first else { return }
        let identifier = record.identifier
        let idString = identifier.map { String(format: "%02x", $0) }.joined()
        print("message id: \(idString)")
    }
}
