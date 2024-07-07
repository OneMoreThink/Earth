//
//  FileManager.swift
//  Earth
//
//  Created by 이종선 on 4/12/24.
//

import Foundation

class MediaFileManager {
    
    static let shared = MediaFileManager()
    private init(){}
    
    private var documentDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func moveFile(from srcURL: URL, to destFileName: String) -> String? {
        let destURL = documentDirectory.appendingPathComponent(destFileName)
        
        // 디렉토리 존재 여부 확인 및 생성
        ensureDirectoryExsits(at: documentDirectory)
        
        // 소스 파일 존재 여부 확인
        if !FileManager.default.fileExists(atPath: srcURL.path){
            print("이동할 파일이 존재하지 않습니다. \(srcURL.path)")
            return nil
        }
        
        // 목적지 파일이 이미 존재시 삭제 처리
        if FileManager.default.fileExists(atPath:destURL.path){
            do {
                try FileManager.default.removeItem(at: destURL)
            } catch {
                print("기존 파일 삭제 실패: \(destURL.path)")
                return nil
            }
        }
        
        // 파일 이동 시도
        do {
            try FileManager.default.moveItem(at: srcURL, to: destURL)
            print("파일 이동 성공: \(srcURL.path)")
            return destURL.path
        } catch {
            print("파일 이동 오류: \(error)")
            return nil
        }
    }
    
    func deleteFile(fileName: String){

        let fileURL = URL(fileURLWithPath: fileName)
        
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            print("삭제하려는 파일이 존재하지 않습니다: \(fileURL.path)")
            return
        }
        
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("파일 삭제 성공")
        } catch {
            print("파일 삭제 오류 : \(error)")
        }
    }
    
    
    private func ensureDirectoryExsits(at url: URL){
        let path = url.path
        if !FileManager.default.fileExists(atPath: path){
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                print("디렉토리 생성 성공: \(path)")
            } catch {
                print("디렉토리 생성 오류: \(error)")
            }
        }
    }
}
