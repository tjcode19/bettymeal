final food = _food
    .map((e) => Food(e['id'], e['name'], e['type'], e['picture']))
    .toList();

final List<Map<String, dynamic>> _food = [
  {
    "id": "1",
    "name": 'Amala with Ewedu',
    "type": [2, 3],
    "picture":
        "https://images.pexels.com/photos/357573/pexels-photo-357573.jpeg?auto=compress&cs=tinysrgb&w=120&h=70&dpr=2"
  },
  {
    "id": "2",
    "name": 'Rice and Stew/veg/fish/meat',
    "type": [1, 3],
    "picture":
        "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=100"
  },
  {
    "id": "3",
    "name": 'Beans and Plantain',
    "type": [2],
    "picture":
        "https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg?auto=compress&cs=tinysrgb&w=120"
  },
  {
    "id": "4",
    "name": 'Koko',
    "type": [1],
    "picture":
        "https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg?auto=compress&cs=tinysrgb&w=120"
  },
  {
    "id": "5",
    "name": 'Fried plantain',
    "type": [1],
    "picture":
        "https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg?auto=compress&cs=tinysrgb&w=120"
  },
  {
    "id": "6",
    "name": 'Boiled plantain',
    "type": [1, 2],
    "picture":
        "https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg?auto=compress&cs=tinysrgb&w=120"
  },
  {
    "id": "7",
    "name": 'Boiled yam',
    "type": [1, 2],
    "picture":
        "https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg?auto=compress&cs=tinysrgb&w=120"
  },
  {
    "id": "8",
    "name": 'Bread and Tea',
    "type": [1],
    "picture":
        "https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg?auto=compress&cs=tinysrgb&w=120"
  },
  {
    "id": "9",
    "name": 'Laagba',
    "type": [2, 3],
    "picture":
        "https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg?auto=compress&cs=tinysrgb&w=120"
  },
  {
    "id": "10",
    "name": 'Banku',
    "type": [2],
    "picture":
        "https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg?auto=compress&cs=tinysrgb&w=120"
  },
  {
    "id": "10",
    "name": 'Banku',
    "type": [6],
    "picture":
        "https://images.pexels.com/photos/1624487/pexels-photo-1624487.jpeg?auto=compress&cs=tinysrgb&w=120"
  },
];

List<String> days = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"];

class Food {
  const Food(this.id, this.name, this.type, this.picture);

  final String id;
  final String name;
  final List<int> type;
  final String picture;
}

class TimeTableMeal {
  const TimeTableMeal(
      {required this.day,
      required this.bFast,
      required this.lunch,
      required this.dinner});
  final String day;
  final Map<String, dynamic> bFast;
  final Map<String, dynamic> lunch;
  final Map<String, dynamic> dinner;
}
