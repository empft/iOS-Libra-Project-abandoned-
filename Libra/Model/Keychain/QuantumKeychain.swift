//
//  Keychain.swift
//  Libra
//
//  Created by Catalina on 16/8/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import Security

protocol QuantumKey {
    associatedtype keyType
    var keychain: QuantumKeychain { get }
    
    func set(key: keyType)
    func get() -> keyType?
    func delete()
}

// Add quantum to anything to make it sounds cooler
// Despite having "Quantum" in its name, this class does not utilize any quantum computing algorithm
class QuantumKeychain {
    /// Construct a query or attributes dictionary 
    class Builder {
        private var query = [String:Any]()
        /// Add a custom label
        func setLabel(_ label: String) -> Builder {
            query[kSecAttrLabel as String] = label
            return self
        }
        /// Set type of item stored
        func setType(_ type: ClassType) -> Builder {
            query[kSecClass as String] = type.value
            return self
        }
        /// Set a tag chosen from a list
        func setTag(_ tag: Tag) -> Builder {
            query[kSecAttrApplicationTag as String] = tag.value
            return self
        }
        /// Set the accessibility level
        func accessibility(of level: Accessiblity) -> Builder {
            query[kSecAttrAccessible as String] = level.value
            return self
        }
        /// Store key in Secure Enclave
        func withExternalStore(_ store: ExternalStore) -> Builder {
            query[kSecAttrTokenID as String] = store.value
            return self
        }
        /// Synchronize key with iCloud
        func useiCloudSync() -> Builder {
            query[kSecAttrSynchronizable as String] = kCFBooleanTrue
            return self
        }
        /// Set type of cryptographic key stored
        func setKeyAlgorithm(_ algo: KeyAlgorithm) -> Builder {
            query[kSecAttrKeyType as String] = algo.value
            return self
        }
        
        func with(account: String) -> Builder {
            query[kSecAttrAccount as String] = account
            return self
        }
        
        func with(server: String) -> Builder {
            query[kSecAttrServer as String] = server
            return self
        }
        
        func setKeyType(_ type: KeyType) -> Builder {
            query[kSecAttrKeyType as String] = type.value
            return self
        }
        
        func setAuthType(_ type: AuthType) -> Builder {
            query[kSecAttrAuthenticationType as String] = type.value
            return self
        }
        
        func setProtocol(_ prot: ProtocolType) -> Builder {
            query[kSecAttrProtocol as String] = prot.value
            return self
        }
        
        func isPermanent(_ state: Bool) -> Builder {
            query[kSecAttrIsPermanent as String] = state ? kCFBooleanTrue : kCFBooleanFalse
            return self
        }
        
        func useEncryptedExport(_ state: Bool) -> Builder {
            query[kSecAttrIsSensitive as String] = state ? kCFBooleanTrue : kCFBooleanFalse
            return self
        }
        
        func isExportable(_ state: Bool) -> Builder {
            query[kSecAttrIsExtractable as String] = state ? kCFBooleanTrue : kCFBooleanFalse
            return self
        }
        
        func canEncrypt(_ state: Bool) -> Builder {
            query[kSecAttrCanEncrypt as String] = state ? kCFBooleanTrue : kCFBooleanFalse
            return self
        }
        
        func canDecrypt(_ state: Bool) -> Builder {
            query[kSecAttrCanDecrypt as String] = state ? kCFBooleanTrue : kCFBooleanFalse
            return self
        }
        
        func isDerivable(_ state: Bool) -> Builder {
            query[kSecAttrCanDerive as String] = state ? kCFBooleanTrue : kCFBooleanFalse
            return self
        }
        
        func canSign(_ state: Bool) -> Builder {
            query[kSecAttrCanSign as String] = state ? kCFBooleanTrue : kCFBooleanFalse
            return self
        }
        
        func canVerifySignature(_ state: Bool) -> Builder {
            query[kSecAttrCanVerify as String] = state ? kCFBooleanTrue : kCFBooleanFalse
            return self
        }
        
        func canWrap(_ state: Bool) -> Builder {
            query[kSecAttrCanWrap as String] = state ? kCFBooleanTrue : kCFBooleanFalse
            return self
        }
        
        func canUnwrap(_ state: Bool) -> Builder {
            query[kSecAttrCanUnwrap as String] = state ? kCFBooleanTrue : kCFBooleanFalse
            return self
        }
        
        func setValue(_ value: Data) -> Builder {
            query[kSecValueData as String] = value
            return self
        }
        
        func build() -> [String:Any] {
            return query
        }
        
    }
    
    /// Add an item to keychain
    func storeItem(item: Data, query: [String:Any]) throws {
        var query = query
        query[kSecValueData as String] = item
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.unknownError(status: status)
        }
    }
    
    func getItem(item: inout AnyObject?, query: [String:Any]) throws {
        var query = query
        query[kSecReturnRef as String] = true
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        guard status == errSecSuccess else {
            throw KeychainError.unknownError(status: status)
        }
    }
    
    func quickGet<T>(query: [String:Any]) -> T? {
        var item: AnyObject? = nil
        
        do {
            try self.getItem(item: &item, query: query)
        } catch KeychainError.itemNotFound {
            print("Item does not exist")
        } catch (let error) {
            print(error)
        }
        return item as? T
    }
    
    func getAttributes(item: inout AnyObject?, query: [String:Any]) throws {
        var query = query
        query[kSecReturnRef as String] = true
        query[kSecReturnAttributes as String] = true
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        guard status == errSecSuccess else {
            throw KeychainError.unknownError(status: status)
        }
    }
    
    func updateItem(query: [String:Any], attributes: [String:Any]) throws {
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else {
            throw KeychainError.itemNotFound
        }
        guard status == errSecSuccess else {
            throw KeychainError.unknownError(status: status)
        }
    }
    
    func deleteItem(query: [String:Any]) throws {
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unknownError(status: status)
        }
    }
    
    /// Store as group of items
    enum Tag {
        /// will be removed upon logout
        case user
        case wallet
        /// Store Key that links user and wallet
        case linkage
        case undefined
        
        var value: Data {
            switch self {
                
            case .user:
                return "user".data(using: .utf8)!
            case .wallet:
                return "wallet".data(using: .utf8)!
            case .linkage:
                return "linkage".data(using: .utf8)!
            case .undefined:
                return "undefined".data(using: .utf8)!
            }
        }
    }
    
    enum ClassType {
        case genericPassword
        case internetPassword
        case certificate
        case key
        case identity
        
        var value: CFString {
            switch self {
            case .genericPassword: return kSecClassGenericPassword
            case .internetPassword: return kSecClassInternetPassword
            case .certificate: return kSecClassCertificate
            case .key: return kSecClassKey
            case .identity: return kSecClassIdentity
            }
        }
    }
    
    enum Accessiblity {
        case whenPasscodeSetThisDeviceOnly
        case whenUnlockedThisDeviceOnly
        case whenUnlocked
        case afterFirstUnlockThisDeviceOnly
        case afterFirstUnlock
        
        var value: CFString {
            switch self {
            case .whenPasscodeSetThisDeviceOnly:
                return kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
            case .whenUnlockedThisDeviceOnly:
                return kSecAttrAccessibleWhenUnlockedThisDeviceOnly
            case .whenUnlocked:
                return kSecAttrAccessibleWhenUnlocked
            case .afterFirstUnlockThisDeviceOnly:
                return kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
            case .afterFirstUnlock:
                return kSecAttrAccessibleAfterFirstUnlock
            }
        }
    }
    
    enum ExternalStore {
        case secureEnclave
        
        var value: CFString {
            switch self {
            case .secureEnclave: return kSecAttrTokenIDSecureEnclave
            }
        }
    }
        
    enum KeyAlgorithm {
        case RSA
        case EllipticCurve
        
        var value: CFString {
            switch self {
            case .RSA:
                return kSecAttrKeyTypeRSA
            case .EllipticCurve:
                return kSecAttrKeyTypeECSECPrimeRandom
            }
        }
    }
    
    enum KeyType {
        case asymmetricPublic
        case asymmetricPrivate
        case symmetric
        
        var value: CFString {
            switch self {
            case .asymmetricPublic:
                return kSecAttrKeyClassPublic
            case .asymmetricPrivate:
                return kSecAttrKeyClassPrivate
            case .symmetric:
                return kSecAttrKeyClassSymmetric
            }
        }
    }
    
    enum AuthType {
        ///Windows NT LAN Manager authentication
        case NTLM
        ///Microsoft Network default authentication
        case MSN
        ///Distributed Password authentication
        case DPA
        ///Remote Password authentication
        case RPA
        ///HTTP Basic authentication
        case HTTPBasic
        ///HTTP Digest Access authentication
        case HTTPDigest
        ///HTML form based authentication
        case HTMLForm
        ///The default authentication type
        case Default
        
        var value: CFString {
            switch self {
            case .NTLM:
                return kSecAttrAuthenticationTypeNTLM
            case .MSN:
                return kSecAttrAuthenticationTypeMSN
            case .DPA:
                return kSecAttrAuthenticationTypeDPA
            case .RPA:
                return kSecAttrAuthenticationTypeRPA
            case .HTTPBasic:
                return kSecAttrAuthenticationTypeHTTPBasic
            case .HTTPDigest:
                return kSecAttrAuthenticationTypeHTTPDigest
            case .HTMLForm:
                return kSecAttrAuthenticationTypeHTMLForm
            case .Default:
                return kSecAttrAuthenticationTypeDefault
            }
        }
    }
    
    enum ProtocolType {
        case FTP
        case FTPAccount
        case HTTP
        case IRC
        case NNTP
        case POP3
        case SMTP
        case SOCKS
        case IMAP
        case LDAP
        case AppleTalk
        case AFP
        case Telnet
        case SSH
        case FTPS
        case HTTPS
        case HTTPProxy
        case HTTPSProxy
        case FTPProxy
        case SMB
        case RTSP
        case RTSPProxy
        case DAAP
        case EPPC
        case IPP
        case NNTPS
        case LDAPS
        case TelnetS
        case IMAPS
        case IRCS
        case POP3S
        
        var value: CFString {
            switch self {
            case .FTP:
                return kSecAttrProtocolFTP
            case .FTPAccount:
                return kSecAttrProtocolFTPAccount
            case .HTTP:
                return kSecAttrProtocolHTTP
            case .IRC:
                return kSecAttrProtocolIRC
            case .NNTP:
                return kSecAttrProtocolNNTP
            case .POP3:
                return kSecAttrProtocolPOP3
            case .SMTP:
                return kSecAttrProtocolSMTP
            case .SOCKS:
                return kSecAttrProtocolSOCKS
            case .IMAP:
                return kSecAttrProtocolIMAP
            case .LDAP:
                return kSecAttrProtocolLDAP
            case .AppleTalk:
                return kSecAttrProtocolAppleTalk
            case .AFP:
                return kSecAttrProtocolAFP
            case .Telnet:
                return kSecAttrProtocolTelnet
            case .SSH:
                return kSecAttrProtocolSSH
            case .FTPS:
                return kSecAttrProtocolFTPS
            case .HTTPS:
                return kSecAttrProtocolHTTPS
            case .HTTPProxy:
                return kSecAttrProtocolHTTPProxy
            case .HTTPSProxy:
                return kSecAttrProtocolHTTPSProxy
            case .FTPProxy:
                return kSecAttrProtocolFTPProxy
            case .SMB:
                return kSecAttrProtocolSMB
            case .RTSP:
                return kSecAttrProtocolRTSP
            case .RTSPProxy:
                return kSecAttrProtocolRTSPProxy
            case .DAAP:
                return kSecAttrProtocolDAAP
            case .EPPC:
                return kSecAttrProtocolEPPC
            case .IPP:
                return kSecAttrProtocolIPP
            case .NNTPS:
                return kSecAttrProtocolNNTPS
            case .LDAPS:
                return kSecAttrProtocolLDAPS
            case .TelnetS:
                return kSecAttrProtocolTelnetS
            case .IMAPS:
                return kSecAttrProtocolIMAPS
            case .IRCS:
                return kSecAttrProtocolIRCS
            case .POP3S:
                return kSecAttrProtocolPOP3S
            }
        }
    }
}

enum KeychainError: Error {
    case itemNotFound
    case unknownError(status: OSStatus)
}
