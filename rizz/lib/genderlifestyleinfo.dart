/// Handles information about the
/// gender and lifestyle. This information is
/// used in [gender] and [lifestyle]
library genderlifestyleinfo.dart;

import 'package:flutter/material.dart';

// used for returning a list of gender checkboxes
class Gender {
  // a list of all of the gender checkboxes
  static final List<GenderCheckbox> checkboxList = [
    GenderCheckbox(gender: "Man"),
    GenderCheckbox(gender: "Woman"),
    GenderCheckbox(gender: "Nonbinary"),
  ];

  static List<GenderCheckbox> getGenders() {
    for (int i = 0; i < checkboxList.length; i++){
      checkboxList[i].value = false;
    }
    return checkboxList;
  }
}

/// Contains the data structure for a gender checkbox.
/// Used in [GenderPageState].
class GenderCheckbox {
  final String gender;
  bool value;

  GenderCheckbox({required this.gender, this.value = false});
}

/// Contains a list of Lifestyle Infos
/// Used in [lifestyle].
/// If you want to add more lifestyles,
/// do it here.
class Lifestyles {
  static final List<LifestyleInfo> lifestyleList = [
    LifestyleInfo(lifestyle: "Animation"),
    LifestyleInfo(lifestyle: "Creative activities"),
    LifestyleInfo(lifestyle: "Creative writing"),
    LifestyleInfo(lifestyle: "Drawing"),
    LifestyleInfo(lifestyle: "Filmmaking"),
    LifestyleInfo(lifestyle: "Flower arranging"),
    LifestyleInfo(lifestyle: "Furniture building"),
    LifestyleInfo(lifestyle: "Furniture restoration"),
    LifestyleInfo(lifestyle: "Illustration"),
    LifestyleInfo(lifestyle: "Knitting"),
    LifestyleInfo(lifestyle: "Painting"),
    LifestyleInfo(lifestyle: "Photography"),
    LifestyleInfo(lifestyle: "Pottery"),
    LifestyleInfo(lifestyle: "Quilting"),
    LifestyleInfo(lifestyle: "Restoring Furniture"),
    LifestyleInfo(lifestyle: "Woodworking"),
    LifestyleInfo(lifestyle: "Blogging"),
    LifestyleInfo(lifestyle: "Copywriting"),
    LifestyleInfo(lifestyle: "Essay writing"),
    LifestyleInfo(lifestyle: "Fanfiction"),
    LifestyleInfo(lifestyle: "Fiction writing"),
    LifestyleInfo(lifestyle: "Journaling"),
    LifestyleInfo(lifestyle: "Memoir writing"),
    LifestyleInfo(lifestyle: "Poetry writing"),
    LifestyleInfo(lifestyle: "Screenwriting"),
    LifestyleInfo(lifestyle: "Travel writing"),
    LifestyleInfo(lifestyle: "Bullet journaling"),
    LifestyleInfo(lifestyle: "Budgeting"),
    LifestyleInfo(lifestyle: "Calendar syncing"),
    LifestyleInfo(lifestyle: "Digital organizing"),
    LifestyleInfo(lifestyle: "DIY projects"),
    LifestyleInfo(lifestyle: "Event planning"),
    LifestyleInfo(lifestyle: "Feng Shui"),
    LifestyleInfo(lifestyle: "Gardening"),
    LifestyleInfo(lifestyle: "Home organizing"),
    LifestyleInfo(lifestyle: "KonMari method"),
    LifestyleInfo(lifestyle: "Meal planning"),
    LifestyleInfo(lifestyle: "Organizing local meetups"),
    LifestyleInfo(lifestyle: "Personal inventory"),
    LifestyleInfo(lifestyle: "Attending literary events"),
    LifestyleInfo(lifestyle: "Book clubs"),
    LifestyleInfo(lifestyle: "Book collecting"),
    LifestyleInfo(lifestyle: "Book reviewing"),
    LifestyleInfo(lifestyle: "Book swaps"),
    LifestyleInfo(lifestyle: "Literary analysis"),
    LifestyleInfo(lifestyle: "Reading challenges"),
    LifestyleInfo(lifestyle: "Reading different genres"),
    LifestyleInfo(lifestyle: "Reading for education"),
    LifestyleInfo(lifestyle: "Translating books"),
    LifestyleInfo(lifestyle: "Action figures"),
    LifestyleInfo(lifestyle: "Comic books"),
    LifestyleInfo(lifestyle: "LEGO sets"),
    LifestyleInfo(lifestyle: "Record albums"),
    LifestyleInfo(lifestyle: "Sports memorabilia"),
    LifestyleInfo(lifestyle: "Stamps"),
    LifestyleInfo(lifestyle: "Stickers"),
    LifestyleInfo(lifestyle: "Vintage collectibles"),
    LifestyleInfo(lifestyle: "Animal rescue"),
    LifestyleInfo(lifestyle: "Community gardening"),
    LifestyleInfo(lifestyle: "Conservation"),
    LifestyleInfo(lifestyle: "Disaster relief"),
    LifestyleInfo(lifestyle: "Elderly support"),
    LifestyleInfo(lifestyle: "Fundraising events"),
    LifestyleInfo(lifestyle: "Habitat for Humanity"),
    LifestyleInfo(lifestyle: "Homelessness support"),
    LifestyleInfo(lifestyle: "International service"),
    LifestyleInfo(lifestyle: "Literacy support"),
    LifestyleInfo(lifestyle: "Mentoring"),
    LifestyleInfo(lifestyle: "Teaching assistant"),
    LifestyleInfo(lifestyle: "Youth sports coaching"),
    LifestyleInfo(lifestyle: "Content creation"),
    LifestyleInfo(lifestyle: "Data analysis"),
    LifestyleInfo(lifestyle: "Exercise"),
    LifestyleInfo(lifestyle: "Photography"),
    LifestyleInfo(lifestyle: "Podcasting"),
    LifestyleInfo(lifestyle: "Reading marketing books"),
    LifestyleInfo(lifestyle: "SEO"),
    LifestyleInfo(lifestyle: "Social media"),
    LifestyleInfo(lifestyle: "Videography"),
    LifestyleInfo(lifestyle: "Acting"),
    LifestyleInfo(lifestyle: "Composing music"),
    LifestyleInfo(lifestyle: "Dancing"),
    LifestyleInfo(lifestyle: "DJing"),
    LifestyleInfo(lifestyle: "Juggling"),
    LifestyleInfo(lifestyle: "Poetry"),
    LifestyleInfo(lifestyle: "Playing a musical instrument"),
    LifestyleInfo(lifestyle: "Magic tricks"),
    LifestyleInfo(lifestyle: "Singing"),
    LifestyleInfo(lifestyle: "Songwriting"),
    LifestyleInfo(lifestyle: "Standup Comedy"),
    LifestyleInfo(lifestyle: "Bargain shopping"),
    LifestyleInfo(lifestyle: "Budgeting"),
    LifestyleInfo(lifestyle: "Computer programs"),
    LifestyleInfo(lifestyle: "Investing"),
    LifestyleInfo(lifestyle: "Learning languages"),
    LifestyleInfo(lifestyle: "Participation in investment clubs"),
    LifestyleInfo(lifestyle: "Reading financial news and market reports"),
    LifestyleInfo(lifestyle: "Trading"),
    LifestyleInfo(lifestyle: "Volunteer work"),
    LifestyleInfo(lifestyle: "Building relationships"),
    LifestyleInfo(lifestyle: "Cold calling"),
    LifestyleInfo(lifestyle: "Networking events"),
    LifestyleInfo(lifestyle: "Persuasion and influencing skills"),
    LifestyleInfo(lifestyle: "Practicing negotiation"),
    LifestyleInfo(lifestyle: "Role-playing games"),
    LifestyleInfo(lifestyle: "Team sports"),
    LifestyleInfo(lifestyle: "Traveling"),
    LifestyleInfo(lifestyle: "Window shopping"),
    LifestyleInfo(lifestyle: "Backpacking"),
    LifestyleInfo(lifestyle: "Baseball"),
    LifestyleInfo(lifestyle: "Basketball"),
    LifestyleInfo(lifestyle: "Bodybuilding"),
    LifestyleInfo(lifestyle: "Canoeing"),
    LifestyleInfo(lifestyle: "Car racing"),
    LifestyleInfo(lifestyle: "Coaching"),
    LifestyleInfo(lifestyle: "Boating"),
    LifestyleInfo(lifestyle: "Bowling"),
    LifestyleInfo(lifestyle: "Football"),
    LifestyleInfo(lifestyle: "Fantasy football"),
    LifestyleInfo(lifestyle: "Fantasy baseball"),
    LifestyleInfo(lifestyle: "Golf"),
    LifestyleInfo(lifestyle: "Hiking"),
    LifestyleInfo(lifestyle: "Individual sports"),
    LifestyleInfo(lifestyle: "Kayaking"),
    LifestyleInfo(lifestyle: "Martial arts"),
    LifestyleInfo(lifestyle: "Mountain biking"),
    LifestyleInfo(lifestyle: "Mountain climbing"),
    LifestyleInfo(lifestyle: "Paintball"),
    LifestyleInfo(lifestyle: "Pickleball"),
    LifestyleInfo(lifestyle: "Pilates"),
    LifestyleInfo(lifestyle: "Rock climbing"),
    LifestyleInfo(lifestyle: "Running"),
    LifestyleInfo(lifestyle: "Sailing"),
    LifestyleInfo(lifestyle: "Scuba diving"),
    LifestyleInfo(lifestyle: "Skydiving"),
    LifestyleInfo(lifestyle: "Snowboarding"),
    LifestyleInfo(lifestyle: "Skiing"),
    LifestyleInfo(lifestyle: "Tennis"),
    LifestyleInfo(lifestyle: "Whitewater Rafting"),
    LifestyleInfo(lifestyle: "Yoga"),
    LifestyleInfo(lifestyle: "3-D Printing"),
    LifestyleInfo(lifestyle: "App Building"),
    LifestyleInfo(lifestyle: "Artificial Intelligence"),
    LifestyleInfo(lifestyle: "Computer Programming"),
    LifestyleInfo(lifestyle: "Podcasting"),
    LifestyleInfo(lifestyle: "Robotics"),
    LifestyleInfo(lifestyle: "Social media"),
    LifestyleInfo(lifestyle: "Virtual Reality"),
    LifestyleInfo(lifestyle: "Web Design"),
    LifestyleInfo(lifestyle: "Web Development"),
    LifestyleInfo(lifestyle: "Astronomy"),
    LifestyleInfo(lifestyle: "Astrology"),
    LifestyleInfo(lifestyle: "Building models"),
    LifestyleInfo(lifestyle: "Car restoration"),
    LifestyleInfo(lifestyle: "Community activities"),
    LifestyleInfo(lifestyle: "Cooking classes"),
    LifestyleInfo(lifestyle: "Genealogy"),
    LifestyleInfo(lifestyle: "Historic preservation"),
    LifestyleInfo(lifestyle: "Learning languages"),
    LifestyleInfo(lifestyle: "Networking groups"),
    LifestyleInfo(lifestyle: "Personal development"),
    LifestyleInfo(lifestyle: "RV traveling"),
    LifestyleInfo(lifestyle: "Sign language"),
    LifestyleInfo(lifestyle: "Stamp collecting"),
    LifestyleInfo(lifestyle: "Traveling"),
    LifestyleInfo(lifestyle: "Vintage shopping"),
    LifestyleInfo(lifestyle: "Dogs"),
    LifestyleInfo(lifestyle: "Cats"),
    LifestyleInfo(lifestyle: "Hamsters"),
    LifestyleInfo(lifestyle: "Birds"),
    LifestyleInfo(lifestyle: "Guinea Pigs"),
    LifestyleInfo(lifestyle: "Fish"),
    LifestyleInfo(lifestyle: "Turtle"),
    LifestyleInfo(lifestyle: "Iguanas"),
    LifestyleInfo(lifestyle: "Snakes"),
    LifestyleInfo(lifestyle: "Spiders"),
    LifestyleInfo(lifestyle: "Lizards"),
    LifestyleInfo(lifestyle: "Ferrets"),
    LifestyleInfo(lifestyle: "Rabbits"),
    LifestyleInfo(lifestyle: "Xbox"),
    LifestyleInfo(lifestyle: "Shooters"),
    LifestyleInfo(lifestyle: "Simulators"),
    LifestyleInfo(lifestyle: "Racing games"),
    LifestyleInfo(lifestyle: "Sport video games"),
    LifestyleInfo(lifestyle: "Mario kart"),
    LifestyleInfo(lifestyle: "Smash bros"),
    LifestyleInfo(lifestyle: "Valorant"),
    LifestyleInfo(lifestyle: "Playstation"),
    LifestyleInfo(lifestyle: "Nintendo Switch"),
    LifestyleInfo(lifestyle: "PC"),
    LifestyleInfo(lifestyle: "Wii"),
    LifestyleInfo(lifestyle: "Wii U"),
    LifestyleInfo(lifestyle: "Rocket League"),
    LifestyleInfo(lifestyle: "League of Legends"),
    LifestyleInfo(lifestyle: "Teamfight Tactics"),
    LifestyleInfo(lifestyle: "Chess"),
    LifestyleInfo(lifestyle: "Checkers"),
    LifestyleInfo(lifestyle: "RPG"),
    LifestyleInfo(lifestyle: "Clash of Clans"),
    LifestyleInfo(lifestyle: "Clash Royale"),
    LifestyleInfo(lifestyle: "Zelda"),
    LifestyleInfo(lifestyle: "Pokemon"),
    LifestyleInfo(lifestyle: "Minecraft"),
    LifestyleInfo(lifestyle: "Open World games"),
    LifestyleInfo(lifestyle: "Grand Theft Auto"),
    LifestyleInfo(lifestyle: "Tetris"),
    LifestyleInfo(lifestyle: "Wii Sports"),
    LifestyleInfo(lifestyle: "PUBG: Battlegrounds"),
    LifestyleInfo(lifestyle: "Super Mario Bros"),
    LifestyleInfo(lifestyle: "Overwatch"),
    LifestyleInfo(lifestyle: "Terraria"),
    LifestyleInfo(lifestyle: "Animal Crossing"),
    LifestyleInfo(lifestyle: "Call of Duty"),
    LifestyleInfo(lifestyle: "Fifa"),
    LifestyleInfo(lifestyle: "NBA"),
    LifestyleInfo(lifestyle: "Madden"),
    LifestyleInfo(lifestyle: "MLB the Show"),
    LifestyleInfo(lifestyle: "God of War"),
    LifestyleInfo(lifestyle: "Diablo"),
    LifestyleInfo(lifestyle: "Warcraft"),
    LifestyleInfo(lifestyle: "Hearthstone"),
    LifestyleInfo(lifestyle: "Brawlhalla"),
    LifestyleInfo(lifestyle: "Dark Souls")
  ];

  static List<LifestyleInfo> getLifestyles() {
    return lifestyleList;
  }
}

/// Contains data for a single lifestyle.
/// Preference can be
/// 0 for neutral,
/// 1 for likes,
/// 2 for dislikes
class LifestyleInfo {
  final String lifestyle;
  int preference;

  LifestyleInfo({
    required this.lifestyle,
    this.preference = 0,
  });

  int getPreference() {
    return preference;
  }
}

/// Used for making a stateful lifestyle button.
/// Notably, has a LifestyleInfo object.
// ignore: must_be_immutable
class LifestyleButton extends StatefulWidget {
  LifestyleInfo lifeObj;

  LifestyleButton({Key? key, required this.lifeObj}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LifestyleButtonState();
}

class LifestyleButtonState extends State<LifestyleButton> {
  int getPreference() {
    return widget.lifeObj.getPreference();
  }

  Color getBorderColor() {
    if (widget.lifeObj.getPreference() == 0) {
      return Theme.of(context).colorScheme.onPrimaryContainer;
    }
    if (widget.lifeObj.getPreference() == 1) {
      return Theme.of(context).colorScheme.secondary;
    } else {
      return Theme.of(context).colorScheme.onPrimaryContainer;
    }
  }

  Color getBackgroundColor() {
    if (widget.lifeObj.getPreference() == 0) {
      return Theme.of(context).colorScheme.background;
    }
    if (widget.lifeObj.getPreference() == 1) {
      return Theme.of(context).colorScheme.onPrimary;
    } else {
      return Theme.of(context).colorScheme.onSurface;
    }
  }

  double getWidth() {
    if (widget.lifeObj.getPreference() == 1) {
      return 2;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: TextButton(
        onPressed: () {
          setState(() {
            widget.lifeObj.preference = (widget.lifeObj.preference + 1) % 3;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: getBackgroundColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(
              color: getBorderColor(),
              width: getWidth(),
            ),
          ),
          elevation: 4,
        ),
        child: Text(
          widget.lifeObj.lifestyle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
