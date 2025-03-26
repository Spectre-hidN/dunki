import 'dart:math';

List<String> indianNames = [
  "Aarav Patel",
  "Aanya Sharma",
  "Advait Singh",
  "Ananya Gupta",
  "Arjun Kumar",
  "Aarohi Verma",
  "Aryan Choudhary",
  "Avni Desai",
  "Ayaan Mehta",
  "Bhavya Joshi",
  "Chaitanya Reddy",
  "Dia Mishra",
  "Dhruv Tiwari",
  "Esha Malhotra",
  "Faisal Khan",
  "Gauri Iyer",
  "Harsh Shah",
  "Ishaan Nair",
  "Ishika Rao",
  "Jai Agarwal",
  "Kavya Bhat",
  "Krishna Dubey",
  "Lavanya Srinivasan",
  "Mihir Trivedi",
  "Mira Chaturvedi",
  "Neha Kapoor",
  "Nikhil Menon",
  "Ojasvi Saxena",
  "Parth Varma",
  "Prisha Mukherjee"
];

List<String> addressNames = [
  "12 Gandhi Road, Mumbai",
  "45 Nehru Lane, Delhi",
  "78 Patel Street, Bangalore",
  "23 Tagore Nagar, Kolkata",
  "56 Rajpath, Pune",
  "34 MG Road, Hyderabad",
  "89 Shivaji Marg, Chennai",
  "67 Ashoka Lane, Ahmedabad",
  "43 Freedom Street, Jaipur",
  "98 Lake View, Surat",
  "21 Green Park, Lucknow",
  "76 Hill Road, Kanpur",
  "54 Ocean Drive, Nagpur",
  "32 Skyline Avenue, Indore",
  "87 Rose Garden, Thane",
  "65 Palm Street, Bhopal",
  "29 Sunrise Lane, Visakhapatnam",
  "48 Sunset Road, Patna",
  "93 River View, Vadodara",
  "71 Lotus Lane, Ghaziabad",
  "15 Tulip Street, Ludhiana",
  "84 Maple Road, Agra",
  "37 Cedar Lane, Nashik",
  "62 Pearl Street, Faridabad",
  "19 Diamond Road, Meerut",
  "88 Ruby Lane, Rajkot",
  "53 Emerald Street, Kalyan",
  "26 Sapphire Road, Varanasi",
  "74 Coral Lane, Srinagar",
  "41 Amber Street, Aurangabad"
];

extension RandomSelection<T> on List<T> {
  List<T> selectRandom(int count) {
    if (count > length) {
      throw ArgumentError("Count cannot be greater than the list length.");
    }

    // Create a copy of the list to avoid modifying the original
    List<T> copyList = List.from(this);

    // Shuffle the list randomly
    copyList.shuffle(Random());

    // Return the first `count` elements
    return copyList.take(count).toList();
  }
}

extension RandomGenerator on List {
  List<int> generateRandomIntegers(int min, int max, int count) {
    List<int> n = [];
    for (var i = 0; i < count; i++) {
      n.add(min + Random().nextInt(min + (max - min + 1)));
    }

    return n;
  }
}

String generateRandomTime() {
  Random random = Random();

  // Generate random hour (1 to 12)
  int hour = random.nextInt(12) + 1;

  // Generate random minute (0 to 59)
  int minute = random.nextInt(60);

  // Generate random AM/PM
  String period = random.nextBool() ? "AM" : "PM";

  // Format the time as "5:30 PM"
  return "$hour:${minute.toString().padLeft(2, '0')} $period";
}
