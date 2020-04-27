//
//  MediaPlayerController.swift
//  PatternsPrac
//
//  Created by Student Loaner 3 on 4/8/20.
//  Copyright © 2020 Maximo Hinojosa. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
import AVFoundation

protocol MediaCommand {
    func execute()
}

//MARK: - Commands

// Play Command
class PlayCommand: MediaCommand {
    public let musicPlayerControl: MusicPlayerControlTower
    
    public init(_ musicPlayerControl: MusicPlayerControlTower) {
        self.musicPlayerControl = musicPlayerControl
    }
    
    public func execute() {
        musicPlayerControl.play()
    }
}


//Pause Command
class PauseCommand: MediaCommand {
    public let musicPlayerControl: MusicPlayerControlTower
    
    public init(_ musicPlayerControl: MusicPlayerControlTower) {
        self.musicPlayerControl = musicPlayerControl
    }
    
    public func execute() {
        musicPlayerControl.pause()
    }
}

//Restart Command
class RestartCommand: MediaCommand {
    public let musicPlayerControl: MusicPlayerControlTower
    
    public init(_ musicPlayerControl: MusicPlayerControlTower) {
        self.musicPlayerControl = musicPlayerControl
    }
    
    public func execute() {
        
    }
}

//MARK: - Receiver

// Receiver
class MusicPlayerControlTower {
    let songList: [String] = ["Chance", "Megan", "Afro b"]
    var currentSongsIndex: Int = 0
    var audioPlayer: AVAudioPlayer!
    
    func play() {
        let sound = URL(fileURLWithPath: Bundle.main.path(forResource: songList[currentSongsIndex], ofType: "mp3")!)
        do {
            print("something is playing")
            audioPlayer = try AVAudioPlayer(contentsOf: sound)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func pause() {
        audioPlayer.pause()
        print("something has been paused")
    }
    
    func restart() {
        
    }
    
    func nextSong() {
        
    }
}

//MARK: - Invoker

// Invoker
class MediaControl {
    public let musicPlayerControl: MusicPlayerControlTower
    
    init(_ musicPlayerControl: MusicPlayerControlTower) {
        self.musicPlayerControl = musicPlayerControl
    }
    
    func execute(_ command: MediaCommand) {
        command.execute()
    }
}


//MARK: - Media Player Controller

class MediaPlayerController: UIViewController {
    let towerControlSong = MusicPlayerControlTower()
    var musicPlayerControl: MediaControl!
    var timeAtPause: Double = 0.0
    lazy var artistImageView: UIImageView = self.createImageView()
    lazy var songLabel: UILabel = self.createSongLabel()
    lazy var soundView: UIImageView = self.createSoundView()
    lazy var playButton: ActionButton = self.createPlayButton()
    lazy var restartButton: ActionButton = self.createRestartButton()
    lazy var forwardButton: ActionButton = self.createForwardButton()
    lazy var mediaPlayerStackView: UIStackView = self.createMediaPlayerStackView()
    let songList: [String] = ["Chance", "Megan", "Afro b"]
    var currentSongsIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1411764706, blue: 0.2352941176, alpha: 1)
        title = "Songs"
        musicPlayerControl = MediaControl(towerControlSong)
        //setSong()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
    /*func setSong() {
        let sound = URL(fileURLWithPath: Bundle.main.path(forResource: songList[currentSongsIndex], ofType: "mp3")!)
        do {
            musicPlayerControl = try AVAudioPlayer(contentsOf: sound)
            musicPlayerControl.prepareToPlay()
        } catch {
            print(error.localizedDescription)
        }
    }*/
    
    // Play Action
    func playPauseAction() {
        let playCommand = PlayCommand(towerControlSong)
        let pauseCommand = PauseCommand(towerControlSong)
        if (playButton.currentType == .play) {
            playButton.type = .pause //pause UI
            musicPlayerControl.execute(playCommand)
        } else {
            playButton.type = .play //play UI
            musicPlayerControl.execute(pauseCommand)
            
        }
    }
    
    //Restart Action
    func restartAction() {
        guard musicPlayerControl == nil else { return }
        
        /*if musicPlayerControl.isPlaying == true {
            musicPlayerControl.currentTime = 0
            musicPlayerControl.play()
        }*/
    }
    
    //Next Action
    func nextAction() {
        playNextSong()
    }
    
    func playNextSong() {
       /* currentSongsIndex = (currentSongsIndex + 1) % songList.count
        artistImageView.image = UIImage(named: songList[currentSongsIndex])
        let sound = URL(fileURLWithPath: Bundle.main.path(forResource: songList[currentSongsIndex], ofType: "mp3")!)
        do {
            musicPlayerControl = try AVAudioPlayer(contentsOf: sound)
            DispatchQueue.main.async {
                self.playButton.type = .pause
            }
            musicPlayerControl.prepareToPlay()
            musicPlayerControl.play()
            
        } catch {
            print(error.localizedDescription)
        }*/
    }

    
    @objc func toolBarAction() {
        self.view.endEditing(true)
    }
}


private extension MediaPlayerController {
    func createImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "Chance"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func createSongLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "something"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 19)
        return label
    }
    
    func createSoundView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "sound"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    func createPlayButton() -> ActionButton {
        let button = ActionButton(type: .play)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.selectBlock = {[weak self] in
            self?.playPauseAction()
        }
        return button
    }
    
    func createRestartButton() -> ActionButton {
        let button = ActionButton(type: .backwardArrow)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.selectBlock = {[weak self] in
            self?.restartAction()
        }
        return button
    }
    
    func createForwardButton() -> ActionButton {
        let button = ActionButton(type: .forwardArrow)
        button.selectBlock = {[weak self] in
            self?.nextAction()
        }
        return button
    }
    
    func createMediaPlayerStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [restartButton, playButton, forwardButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        return stackView
    }
}


private extension MediaPlayerController {
    func layout() {
        view.addSubview(artistImageView)
        view.addSubview(songLabel)
        view.bringSubviewToFront(songLabel)
        view.addSubview(mediaPlayerStackView)
        view.addSubview(soundView)
        view.bringSubviewToFront(restartButton)
        
        
        NSLayoutConstraint.activate([
            restartButton.heightAnchor.constraint(equalToConstant: 25),
            playButton.heightAnchor.constraint(equalToConstant: 25),
            forwardButton.heightAnchor.constraint(equalToConstant: 25),
            
            artistImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            artistImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            artistImageView.heightAnchor.constraint(equalToConstant: 150),

            songLabel.topAnchor.constraint(equalTo: artistImageView.bottomAnchor, constant: 50),
            songLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            songLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            songLabel.heightAnchor.constraint(equalToConstant: 35),
            
            
            soundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            soundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            soundView.bottomAnchor.constraint(equalTo: mediaPlayerStackView.topAnchor, constant: -50),
            soundView.heightAnchor.constraint(equalToConstant: 30),
            
            mediaPlayerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            mediaPlayerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            mediaPlayerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mediaPlayerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            mediaPlayerStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

