//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ---
//:
//: ## Distortion
//: ### This thing is a beast.
//:
import XCPlayground
import AudioKit

let file = try AKAudioFile(readFileName: AKPlaygroundView.defaultSourceAudio,
                           baseDir: .Resources)

let player = try AKAudioPlayer(file: file)
player.looping = true

var distortion = AKDistortion(player)

//: Set the parameters here
distortion.delay  = 0.1
distortion.decay  = 1.0
distortion.delayMix  = 0.5
distortion.linearTerm  = 0.5
distortion.squaredTerm  = 0.5
distortion.cubicTerm  = 50
distortion.polynomialMix  = 0.5
distortion.softClipGain  = -6
distortion.finalMix  = 0.5

AudioKit.output = distortion
AudioKit.start()

//: User Interface Set up

class PlaygroundView: AKPlaygroundView {

    var delaySlider: AKPropertySlider?
    var decaySlider: AKPropertySlider?
    var delayMixSlider: AKPropertySlider?
    var linearTermSlider: AKPropertySlider?
    var squaredTermSlider: AKPropertySlider?
    var cubicTermSlider: AKPropertySlider?
    var polynomialMixSlider: AKPropertySlider?
    var softClipGainSlider: AKPropertySlider?
    var finalMixSlider: AKPropertySlider?

    override func setup() {
        addTitle("Distortion")

        addButtons()

        addButton("Process", action: #selector(process))
        addButton("Bypass", action: #selector(bypass))
        
        addLineBreak()
        
        addButton("Infinite Distortion Wall", action: #selector(presetInfiniteDistortionWall))
        
        delaySlider = AKPropertySlider(
            property: "Delay",
            format: "%0.3f ms",
            value: distortion.delay, minimum: 0.1, maximum: 500,
            color: AKColor.greenColor()
        ) { sliderValue in
            distortion.delay = sliderValue
        }
        addSubview(delaySlider!)
        
        decaySlider = AKPropertySlider(
            property: "Decay Rate",
            value: distortion.decay, minimum: 0.1, maximum: 50,
            color: AKColor.greenColor()
        ) { sliderValue in
            distortion.decay = sliderValue
        }
        addSubview(decaySlider!)
        
        delayMixSlider = AKPropertySlider(
            property: "Delay Mix",
            value: distortion.delayMix,
            color: AKColor.greenColor()
        ) { sliderValue in
            distortion.delayMix = sliderValue
        }
        addSubview(delayMixSlider!)
        
        linearTermSlider = AKPropertySlider(
            property: "Linear Term",
            value: distortion.linearTerm,
            color: AKColor.greenColor()
        ) { sliderValue in
            distortion.linearTerm = sliderValue
        }
        addSubview(linearTermSlider!)

        squaredTermSlider = AKPropertySlider(
            property: "Squared Term",
            value: distortion.squaredTerm,
            color: AKColor.greenColor()
        ) { sliderValue in
            distortion.squaredTerm = sliderValue
        }
        addSubview(squaredTermSlider!)
        
        cubicTermSlider = AKPropertySlider(
            property: "Cubic Term",
            value: distortion.cubicTerm,
            color: AKColor.greenColor()
        ) { sliderValue in
            distortion.cubicTerm = sliderValue
        }
        addSubview(cubicTermSlider!)
        
        polynomialMixSlider = AKPropertySlider(
            property: "Polynomial Mix",
            value: distortion.polynomialMix,
            color: AKColor.greenColor()
        ) { sliderValue in
            distortion.polynomialMix = sliderValue
        }
        addSubview(polynomialMixSlider!)
        
        softClipGainSlider = AKPropertySlider(
            property: "Soft Clip Gain",
            format: "%0.3f dB",
            value: distortion.softClipGain, minimum: -80, maximum: 20,
            color: AKColor.greenColor()
        ) { sliderValue in
            distortion.softClipGain = sliderValue
        }
        addSubview(softClipGainSlider!)
        
        finalMixSlider = AKPropertySlider(
            property: "Final Mix",
            value: distortion.finalMix,
            color: AKColor.greenColor()
        ) { sliderValue in
            distortion.finalMix = sliderValue
        }
        addSubview(finalMixSlider!)

    }
    override func startLoop(name: String) {
        player.stop()
        let file = try? AKAudioFile(readFileName: "\(name)", baseDir: .Resources)
        try? player.replaceFile(file!)
        player.play()
    }
    override func stop() {
        player.stop()
    }

    func process() {
        distortion.start()
    }

    func bypass() {
        distortion.bypass()
    }

    func presetInfiniteDistortionWall() {
        distortion.presetInfiniteDistortionWall()
        updateUI()
    }

    func updateUI() {
        delaySlider?.value = distortion.delay
        decaySlider?.value = distortion.decay
        delayMixSlider?.value = distortion.delayMix
        linearTermSlider?.value = distortion.linearTerm
        squaredTermSlider?.value = distortion.squaredTerm
        cubicTermSlider?.value = distortion.cubicTerm
        polynomialMixSlider?.value = distortion.polynomialMix
        softClipGainSlider?.value = distortion.softClipGain
        finalMixSlider?.value = distortion.finalMix
    }

    func printCode() {

        Swift.print("public func presetXXXXXX() {")
        Swift.print("    delay = \(String(format: "%0.3f", distortion.delay))")
        Swift.print("    decay = \(String(format: "%0.3f", distortion.decay))")
        Swift.print("    delayMix = \(String(format: "%0.3f", distortion.delayMix))")
        Swift.print("    linearTerm = \(String(format: "%0.3f", distortion.linearTerm))")
        Swift.print("    squaredTerm = \(String(format: "%0.3f", distortion.squaredTerm))")
        Swift.print("    cubicTerm = \(String(format: "%0.3f", distortion.cubicTerm))")
        Swift.print("    polynomialMix = \(String(format: "%0.3f", distortion.polynomialMix))")
        Swift.print("    softClipGain = \(String(format: "%0.3f", distortion.softClipGain))")
        Swift.print("    finalMix = \(String(format: "%0.3f", distortion.finalMix))")
        Swift.print("}\n")
    }
}

let view = PlaygroundView(frame: CGRect(x: 0, y: 0, width: 500, height: 1000))
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
XCPlaygroundPage.currentPage.liveView = view

//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)