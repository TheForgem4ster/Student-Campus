class Campus {
  int numberOfRooms;
  int numberOfStaff;
  String universityName;
  int numberOfStudents;
  double accommodationFee;
  String address;
  bool cafeteria = false;

  // Конструктор класу
  Campus(this.numberOfRooms, this.numberOfStaff, this.universityName,
      this.numberOfStudents, this.accommodationFee, this.address);

  // Метод клонування
  Campus clone() {
    return Campus(numberOfRooms, numberOfStaff, universityName,
        numberOfStudents, accommodationFee, address);
  }

  // Метод для збільшення кількості кімнат
  void increaseNumberOfRooms(int roomsToAdd) {
    numberOfRooms += roomsToAdd;
  }

  // Метод для виселення студентів
  void evictStudents(int studentsToEvict) {
    if (numberOfStudents == 0) return;
    numberOfStudents -= studentsToEvict;
  }

  // Метод для заселення студентів
  void accommodateStudents(int studentsToAccommodate) {
    numberOfStudents += studentsToAccommodate;
  }

  // Метод для визначення прибутку за певний період
  double calculateIncome() {
    return numberOfStudents * accommodationFee * 12;
  }

  // Реалізація розширюючого методу для додавання їдальні до кампусу
  void addCafeteria() {
    cafeteria = true;
    accommodationFee *= 1.2; //Збільшення оплати за проживання на 20%
    numberOfStaff += 5; // Додавання 5 осіб персоналу
  }

  void removeCafeteria() {
    cafeteria = false;
    accommodationFee /= 1.2; //Збільшення оплати за проживання на 20%
    numberOfStaff -= 5; // Додавання 5 осіб персоналу
  }

  // Метод ToString для отримання рядкового представлення об'єкту
  @override
  String toString() {
    return 'Number of rooms: $numberOfRooms\n'
        'Number of staff: $numberOfStaff\n'
        'Name of the university: $universityName\n'
        'Amount of students: $numberOfStudents\n'
        'Payment for accommodation: $accommodationFee\n'
        'Address: $address\n';
  }
}
