//
//  AudioPlayerManager.swift
//  Ahitat
//
//  Created by Daniel Szasz on 12/22/25.
//  Copyright © 2025 Daniel Szasz. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

class AudioPlayerManager {
    
    static let shared = AudioPlayerManager()
    
    private var player: AVPlayer?
    private var timeObserverToken: Any?
    
    var isPlaying: Bool {
        return player?.rate != 0
    }
    
    var onPlaybackFinished: (() -> Void)?
    
    private init() {
        setupAudioSession()
        setupRemoteTransportControls()
    }
    
    // MARK: - Audio Session Setup
    
    private func setupAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .spokenAudio, options: [])
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    // MARK: - Audio Playback
    
    func play(from urlString: String, title: String, artist: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        // If player already exists and is paused, just resume
        if let player = player, player.currentItem?.asset is AVURLAsset {
            let asset = player.currentItem?.asset as? AVURLAsset
            if asset?.url == url {
                player.play()
                updateNowPlayingInfo(title: title, artist: artist, isPlaying: true)
                return
            }
        }
        
        // Stop current playback
        stop()
        
        // Create new player
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        // Add observer for when audio finishes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: playerItem
        )
        
        // Add periodic time observer for updating now playing info
        let interval = CMTime(seconds: 1.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.updateNowPlayingInfo(title: title, artist: artist, isPlaying: true)
        }
        
        player?.play()
        setupNowPlayingInfo(title: title, artist: artist)
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
            timeObserverToken = nil
        }
        
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
        player?.pause()
        player = nil
    }
    
    func togglePlayPause(urlString: String, title: String, artist: String) -> Bool {
        if isPlaying {
            pause()
            updateNowPlayingInfo(title: title, artist: artist, isPlaying: false)
            return false
        } else {
            if player == nil {
                play(from: urlString, title: title, artist: artist)
            } else {
                player?.play()
                updateNowPlayingInfo(title: title, artist: artist, isPlaying: true)
            }
            return true
        }
    }
    
    @objc private func playerDidFinishPlaying() {
        player?.seek(to: .zero)
        onPlaybackFinished?()
    }
    
    // MARK: - Now Playing Info
    
    private func setupNowPlayingInfo(title: String, artist: String) {
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = title
        nowPlayingInfo[MPMediaItemPropertyArtist] = artist
        
        if let player = player,
           let duration = player.currentItem?.asset.duration.seconds,
           duration.isFinite {
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = duration
        }
        
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1.0
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime().seconds ?? 0
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    private func updateNowPlayingInfo(title: String, artist: String, isPlaying: Bool) {
        var nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo ?? [String: Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = title
        nowPlayingInfo[MPMediaItemPropertyArtist] = artist
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = isPlaying ? 1.0 : 0.0
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime().seconds ?? 0
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    // MARK: - Remote Control
    
    private func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }
            self.player?.play()
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }
            self.pause()
            return .success
        }
        
        commandCenter.togglePlayPauseCommand.addTarget { [weak self] event in
            guard let self = self else { return .commandFailed }
            if self.isPlaying {
                self.pause()
            } else {
                self.player?.play()
            }
            return .success
        }
    }
    
    deinit {
        stop()
    }
}
