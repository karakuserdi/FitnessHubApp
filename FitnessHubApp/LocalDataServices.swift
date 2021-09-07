//
//  File.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 25.08.2021.
//

import UIKit

struct LocalDataServices {
    static var shared = LocalDataServices()
    
    var randomCentences = [RandomCentences]()
    
    var datas: [Exercises]?
    var absData: [Exercise]?
    var backData: [Exercise]?
    var bicepsData: [Exercise]?
    var calfData: [Exercise]?
    var chestData: [Exercise]?
    var forearmsData: [Exercise]?
    var legsData: [Exercise]?
    var shouldersData: [Exercise]?
    var tricepsData: [Exercise]?
    var allData: [Exercise]?
    
    mutating func loadTableViewDatas() -> [Exercises]{
        let abs = Exercise(title: "Incline Bench Sit-Ups", isSelected: false, exerciseImage: UIImage(named: "absImage"), exerciseInfo: ExerciseInfo(info: ["Muscle: Rectus Abdomins", "Step 1: Lie back on the decline bench. Position hands overhead. Knees are bent.","Step 2: Raise your upper body upward while keeping your lower back on the banch. Hold for one second. Return to starting position"], exerciseImages: [UIImage(named: "incBench")!,UIImage(named: "incBench2")!,UIImage(named: "incBench3")!,UIImage(named: "incBench4")!]))
    
    let abs2 = Exercise(title: "Haning Leg Raises", isSelected: false, exerciseImage: UIImage(named: "absImage2"), exerciseInfo: ExerciseInfo(info: ["Muscle: Rectus Abdomins", "Step 1: While holding onto a chin-up bar raising an overhand frip, hang with your knees bent slightly.","Step 2: Pull your hips up as you curl inward toward your chest using the muscles of your lower abs. Life your knees as close to your chest as possible, rounding your lower back at the top. Then, pause, feel the contraction in your lower-abdominal muscles, and return to the position you began with"], exerciseImages: nil))
    
    let abs3 = Exercise(title: "Dumbbell Side Bends", isSelected: false, exerciseImage: UIImage(named: "absImage3"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let abs4 = Exercise(title: "Crunches", isSelected: false,exerciseImage: UIImage(named: "absImage4"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let abs5 = Exercise(title: "Sit-Ups", isSelected: false,exerciseImage: UIImage(named: "absImage5"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    
    
    absData = [abs,abs2,abs3,abs4,abs5]
    
    let back = Exercise(title: "Chin-Ups", isSelected: false,exerciseImage: UIImage(named: "backImage"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let back2 = Exercise(title: "Deadlifts", isSelected: false,exerciseImage: UIImage(named: "backImage2"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let back3 = Exercise(title: "Lat Pull-Downs", isSelected: false,exerciseImage: UIImage(named: "backImage3"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let back4 = Exercise(title: "Seated Rows", isSelected: false,exerciseImage: UIImage(named: "backImage4"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let back5 = Exercise(title: "One-Arm Dumbell Rows", isSelected: false,exerciseImage: UIImage(named: "backImage5"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    
    backData = [back,back2,back3,back4,back5]
    
    let biceps = Exercise(title: "Curls", isSelected: false,exerciseImage: UIImage(named: "bicepsImage"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let biceps2 = Exercise(title: "Barbell Curls", isSelected: false,exerciseImage: UIImage(named: "bicepsImage2"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let biceps3 = Exercise(title: "Preacher Curls", isSelected: false,exerciseImage: UIImage(named: "bicepsImage3"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let biceps4 = Exercise(title: "Hammer Curls", isSelected: false,exerciseImage: UIImage(named: "bicepsImage4"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let biceps5 = Exercise(title: "Concentration Curls", isSelected: false,exerciseImage: UIImage(named: "bicepsImage5"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    
    bicepsData = [biceps,biceps2,biceps3,biceps4,biceps5]
    
    let calf = Exercise(title: "Toe Raises", isSelected: false,exerciseImage: UIImage(named: "calfImages"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let calf2 = Exercise(title: "One-Leg Toe Raises", isSelected: false,exerciseImage: UIImage(named: "calfImages2"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let calf3 = Exercise(title: "Seated Calf Raises", isSelected: false,exerciseImage: UIImage(named: "calfImages3"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let calf4 = Exercise(title: "Barbell Cald Raises(Seated)", isSelected: false,exerciseImage: UIImage(named: "calfImages4"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let calf5 = Exercise(title: "Barberll Calf Raise With Single Leg (Seated)", isSelected: false,exerciseImage: UIImage(named: "calfImages5"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    
    calfData = [calf, calf2, calf3, calf4, calf5]
    
    let chest = Exercise(title: "Bench Press", isSelected: false,exerciseImage: UIImage(named: "chestImage"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let chest2 = Exercise(title: "Incline Presses", isSelected: false,exerciseImage: UIImage(named: "chestImage2"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let chest3 = Exercise(title: "Dumbbell Presses", isSelected: false,exerciseImage: UIImage(named: "chestImage3"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let chest4 = Exercise(title: "Parallel Bar Dips", isSelected: false,exerciseImage: UIImage(named: "chestImage4"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let chest5 = Exercise(title: "Cable Crossover Flys", isSelected: false,exerciseImage: UIImage(named: "chestImage5"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    
    chestData = [chest , chest2, chest3, chest4, chest5]
    
    let forearms = Exercise(title: "Wrist Curls", isSelected: false,exerciseImage: UIImage(named: "forearmsImage"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let forearms2 = Exercise(title: "Wrist Bar Curls", isSelected: false,exerciseImage: UIImage(named: "forearmsImage2"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let forearms3 = Exercise(title: "Dumbbell Wrist Twist", isSelected: false,exerciseImage: UIImage(named: "forearmsImage3"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let forearms4 = Exercise(title: "Standing Wrist Curl", isSelected: false,exerciseImage: UIImage(named: "forearmsImage4"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    
    forearmsData = [forearms, forearms2, forearms3, forearms4]
    
    let legs = Exercise(title: "Squats", isSelected: false,exerciseImage: UIImage(named: "legsImage"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let legs2 = Exercise(title: "Angled Leg Presses", isSelected: false,exerciseImage: UIImage(named: "legsImage2"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let legs3 = Exercise(title: "Leg Extensions", isSelected: false,exerciseImage: UIImage(named: "legsImage3"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let legs4 = Exercise(title: "Dumbbell Lunges", isSelected: false,exerciseImage: UIImage(named: "legsImage4"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let legs5 = Exercise(title: "Cable Back Kicks", isSelected: false,exerciseImage: UIImage(named: "legsImage5"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    
    legsData = [legs, legs2, legs3, legs4, legs5]
    
    let shoulders = Exercise(title: "Back Presses", isSelected: false,exerciseImage: UIImage(named: "shoulderImage"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let shoulders2 = Exercise(title: "Seated Font Presses", isSelected: false,exerciseImage: UIImage(named: "shoulderImage2"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let shoulders3 = Exercise(title: "Seated Dumbbell Presses", isSelected: false,exerciseImage: UIImage(named: "shoulderImage3"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let shoulders4 = Exercise(title: "Low-Pulley Lateral Raises", isSelected: false,exerciseImage: UIImage(named: "shoulderImage4"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let shoulders5 = Exercise(title: "Upright Rows", isSelected: false,exerciseImage: UIImage(named: "shoulderImage5"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    
    shouldersData = [shoulders, shoulders2, shoulders3, shoulders4, shoulders5]
    
    let triceps = Exercise(title: "Close-Grip Bench Presses", isSelected: false,exerciseImage: UIImage(named: "tricepsImage"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let triceps2 = Exercise(title: "Push-Downs", isSelected: false,exerciseImage: UIImage(named: "tricepsImage2"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let triceps3 = Exercise(title: "Triceps Extensions", isSelected: false,exerciseImage: UIImage(named: "tricepsImage3"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let triceps4 = Exercise(title: "Triceps KickBacks", isSelected: false,exerciseImage: UIImage(named: "tricepsImage4"), exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    let triceps5 = Exercise(title: "One-Arm Dumbbell Triceps Extensions", isSelected: false,exerciseImage: UIImage(named: "tricepsImage5"),  exerciseInfo: ExerciseInfo(info: ["Bur nas saıjsaj saıjpsa", "asıhahıos sahıoahıo"], exerciseImages: nil))
    
    tricepsData = [triceps, triceps2, triceps3, triceps4, triceps5]
    
    allData = [abs,abs2,abs3,abs4,abs5,back,back2,back3,back4,back5,biceps,biceps2,biceps3,biceps4,biceps5,calf, calf2, calf3, calf4, calf5,chest , chest2, chest3, chest4, chest5,forearms, forearms2, forearms3, forearms4,legs, legs2, legs3, legs4, legs5,shoulders, shoulders2, shoulders3, shoulders4, shoulders5,triceps, triceps2, triceps3, triceps4, triceps5]

    
    let exercises = Exercises(title: "ABS", logo: UIImage(named: "abs")!, exercise: absData!)
    let exercises2 = Exercises(title: "BACK", logo: UIImage(named: "back")!, exercise: backData!)
    let exercises3 = Exercises(title: "BICEPS", logo: UIImage(named: "biceps")!, exercise: bicepsData!)
    let exercises4 = Exercises(title: "CALF", logo: UIImage(named: "calf")!, exercise: calfData!)
    let exercises5 = Exercises(title: "CHEST", logo: UIImage(named: "chest")!, exercise: chestData!)
    let exercises6 = Exercises(title: "FOREARMS", logo: UIImage(named: "forearms")!, exercise: forearmsData!)
    let exercises7 = Exercises(title: "LEGS", logo: UIImage(named: "legs")!, exercise: legsData!)
    let exercises8 = Exercises(title: "SHOULDERS", logo: UIImage(named: "shoulders")!, exercise: shouldersData!)
    let exercises9 = Exercises(title: "TRICEPS", logo: UIImage(named: "triceps")!, exercise: tricepsData!)
    let exercises10 = Exercises(title: "ALL", logo: UIImage(named: "all")!, exercise: allData!)

    datas = [exercises,exercises2,exercises3,exercises4,exercises5,exercises6,exercises7,exercises8,exercises9,exercises10]
        
    return datas!
  }
    
    
    public mutating func localDatas() -> (title: String, author: String) {
        randomCentences.append(
            RandomCentences(title: "The last three or four reps is what makes the muscle grow. This area of pain divides the champion from someone else who is not a champion.", author: "-Arnold Schwarzenegger, seven-time Mr. Olympia"))
        randomCentences.append(RandomCentences(title: "There is no magic pill", author: "-Arnold Schwarzenegger, seven-time Mr. Olympia"))
        
        randomCentences.append(RandomCentences(title: "I have nothing in common with lazy people who blame others for their lack of success. Great things come from hard work and perseverance. No excuses.", author: "-Kobe Bryant, 5-time NBA Championship winner"))
        randomCentences.append(RandomCentences(title: "In training, you listen to your body. In competition, you tell your body to shut up.", author: "- Rich Froning Jr., CrossFit Games champion"))
        randomCentences.append(RandomCentences(title: "You shall gain, but you shall pay with sweat, blood, and vomit.", author: "- Pavel Tsatsouline, chairman of StrongFirst and father of the modern kettlebell movement"))
        randomCentences.append(RandomCentences(title: "There’s no secret formula. I lift heavy, work hard, and aim to be the best.", author: "- Ronnie Coleman, eight-time Mr. Olympia"))
        randomCentences.append(RandomCentences(title: "If something stands between you and your success, move it. Never be denied.", author: "- Dwayne “The Rock” Johnson, actor and pro wrestler"))
        randomCentences.append(RandomCentences(title: "There comes a certain point in life when you have to stop blaming other people for how you feel or the misfortunes in your life. You can’t go through life obsessing about what might have been.", author: "- Hugh Jackman, actor and member of the 1000-pound lift club"))
        randomCentences.append(RandomCentences(title: "Success is usually the culmination of controlling failure.", author: "- Sylvester Stallone, actor"))
        randomCentences.append(RandomCentences(title: "Don’t be afraid of failure. This is the way to succeed.", author: "- LeBron James, three-time NBA Championship winner"))
        randomCentences.append(RandomCentences(title: "I will sacrifice whatever is necessary to be the best.", author: "- J.J. Watt, defensive end for the Houston Texans"))
        randomCentences.append(RandomCentences(title: "Most people give up right before the big break comes — don’t let that person be you.", author: "- Michael Boyle"))
        randomCentences.append(RandomCentences(title: "I feel an endless need to learn, to improve, to evolve — not only to please the coach and the fans — but also to feel satisfied with myself.", author: "- Cristiano Ronaldo"))
        randomCentences.append(RandomCentences(title: "You’re going to have to let it hurt. Let it suck. The harder you work, the better you will look. Your appearance isn’t parallel to how heavy you lift, it’s parallel to how hard you work", author: "- Joe Manganiello, actor and one of the 100 Fittest Men of All Time"))
        randomCentences.append(RandomCentences(title: "You have to push past your perceived limits, push past that point you thought was as far as you can go.", author: "- Drew Brees, quarterback for the New Orleans Saints"))
        randomCentences.append(RandomCentences(title: "If you ain’t pissed off for greatness, that just means you’re okay with being mediocre.", author: "- Ray Lewis, two-time Super Bowl Champion and NFL Hall of Famer"))
        randomCentences.append(RandomCentences(title: "You dream. You plan. You reach. There will be obstacles. There will be doubters. There will be mistakes. But with hard work, with belief, with confidence and trust in yourself and those around you, there are no limits.", author: "- Michael Phelps, swimmer and 18-time Olympic gold medalist"))
        randomCentences.append(RandomCentences(title: "When you have a clear vision of your goal, it’s easier to take the first step toward it.", author: "- L.L. Cool J., rapper and actor"))
        randomCentences.append(RandomCentences(title: "We run for the people who think they cant.", author: "- Dick Hoyt, retired Lt."))
        randomCentences.append(RandomCentences(title: "I was never a natural athlete, but I paid my dues in sweat and concentration, and took the time necessary to learn karate and became a world champion.", author: "- Chuck Norris, martial artist and actor"))
        randomCentences.append(RandomCentences(title: "Your health account, your bank account, they’re the same thing. The more you put in, the more you can take out. Exercise is king and nutrition is queen. Together you have a kingdom.", author: "- Jack LaLanne, bodybuilder known as the “Godfather of Fitness“"))
        randomCentences.append(RandomCentences(title: "To keep winning, I have to keep improving.", author: "- Craig Alexander, Ironman World Champion"))
        
        randomCentences.append(RandomCentences(title: "Some people want it to happen, some wish it would happen, others make it happen.", author: "- Michael Jordan, 6-time NBA Championship winner"))
        randomCentences.append(RandomCentences(title: "I know that if I set my mind to something, even if people are saying I can’t do it, I will achieve it.", author: "- David Beckham, internationally renowned former soccer player"))
        randomCentences.append(RandomCentences(title: "“We must appreciate and never underestimate our own inner power.”", author: "- Noah Galloway, former Army Ranger and 2014 Ultimate Men’s Health Guy"))
        randomCentences.append(RandomCentences(title: "I am the greatest, I said that even before I knew I was.", author: "Muhammad Ali, champion boxer"))
        randomCentences.append(RandomCentences(title: "“You miss one hundred percent of the shots you don't take.”", author: "Wayne Gretzky, 4-time Stanley Cup winner"))
        randomCentences.append(RandomCentences(title: "If you take time to realize what your dream is and what you really want in life — no matter what it is, whether it’s sports or in other fields — you have to realize that there is always work to do, and you want to be the hardest working person in whatever you do, and you put yourself in a position to be successful. And you have to have a passion about what you do.", author: "-Stephen Curry, 3-time NBA Championship winner"))
        randomCentences.append(RandomCentences(title: "Enduring means accepting. Accepting things as they are and not as you would wish them to be, and then looking ahead, not behind.", author: "-Rafael Nadal, 19-time Grand Slam winner"))
        randomCentences.append(RandomCentences(title: "It's hard to beat a person who never gives up.", author: "Babe Ruth, Hall of Fame MLB player"))

        let randomInt = Int.random(in: 1..<randomCentences.count)
        return (randomCentences[randomInt].title, randomCentences[randomInt].author)
    }
}
