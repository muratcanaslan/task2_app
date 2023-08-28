//
//  SoundManager.swift
//  task2_app
//
//  Created by Murat Can ASLAN on 28.08.2023.
//

import Foundation
import AVFoundation

final class SoundManager {
    
    static let shared = SoundManager()
    
    private var audioPlayer: AVAudioPlayer?
    private var volumeIncrement: Float = 0.1
    private var volumeTimer: Timer?
    private var elapsedTime: TimeInterval = 0
    private let maxVolume: Float = 1.0
    private let duration: TimeInterval = 30.0 // 30 seconds
    
    private init() { }
    
    func playAlarmSound() {
        let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
            startVolumeIncreaseTimer()
        } catch {
            print("Error playing sound: \(error)")
        }
    }
    
    func stopAlarmSound() {
        audioPlayer?.stop()
        volumeTimer?.invalidate() 
        audioPlayer = nil
        elapsedTime = 0
    }
    
    func startVolumeIncreaseTimer() {
        volumeTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                return
            }
            
            self.elapsedTime += 0.5
            let volumeProgress = Float(self.elapsedTime / self.duration)
            let targetVolume = volumeProgress * self.maxVolume
            
            if let player = self.audioPlayer {
                if player.volume < targetVolume {
                    player.volume += self.volumeIncrement
                } else {
                    self.volumeTimer?.invalidate()
                }
            }
        }
    }
}
