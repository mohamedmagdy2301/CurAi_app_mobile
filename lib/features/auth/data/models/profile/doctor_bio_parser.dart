/// A utility class to parse and format doctor biographies
class DoctorBioParser {
  /// Parses a complete bio text into its components
  static Map<String, String?> parseBio(String bioText) {
    // Default result with null values
    final result = {
      'experience': '',
      'degree': '',
      'university': '',
      'hospital': '',
    };

    // Parse experience (look for patterns like "X years of experience" or "X+ years")
    final experienceRegex = RegExp(
      r'(\d+)(?:\+)?\s+(?:years|سنوات|عام|سنة)\s+(?:of\s+)?(?:experience|خبرة)',
    );
    final experienceMatch = experienceRegex.firstMatch(bioText);
    if (experienceMatch != null) {
      result['experience'] = experienceMatch.group(1) ?? '';
    }

    // Get all possible degrees (English and Arabic)
    final degreePatterns = [
      ...DegreeConstants.getEnglishDegrees(),
      ...DegreeConstants.getArabicDegrees(),
    ];

    // Try to find degree
    for (final degree in degreePatterns) {
      if (bioText.contains(degree)) {
        result['degree'] = degree;
        break;
      }
    }

    // Look for university pattern (after "from", "graduated from", etc.)
    final universityRegex = RegExp(
      r'(?:from|graduated from|متخرج من|من جامعة)\s+([A-Za-zأ-ي\s]+)(?:University|جامعة)?',
      caseSensitive: false,
    );
    final universityMatch = universityRegex.firstMatch(bioText);
    if (universityMatch != null) {
      result['university'] = universityMatch.group(1)?.trim() ?? '';
    }

    // Look for hospital pattern (common mentions of hospitals)
    final hospitalRegex = RegExp(
      r'(?:at|in|في)\s+([A-Za-zأ-ي\s]+)(?:Hospital|مستشفى|مركز|Center)',
      caseSensitive: false,
    );
    final hospitalMatch = hospitalRegex.firstMatch(bioText);
    if (hospitalMatch != null) {
      result['hospital'] = hospitalMatch.group(1)?.trim() ?? '';
    }

    return result;
  }

  /// Combines bio components into a formatted bio string
  static String generateBio({
    String? experience,
    String? degree,
    String? university,
    String? hospital,
    bool isArabic = false,
  }) {
    if (isArabic) {
      return _generateArabicBio(
        experience: experience,
        degree: degree,
        university: university,
        hospital: hospital,
      );
    } else {
      return _generateEnglishBio(
        experience: experience,
        degree: degree,
        university: university,
        hospital: hospital,
      );
    }
  }

  /// Generate English bio from components
  static String _generateEnglishBio({
    String? experience,
    String? degree,
    String? university,
    String? hospital,
  }) {
    final parts = <String>[];

    // Add degree if available
    if (degree != null && degree.isNotEmpty) {
      parts.add(degree);
    }

    // Add experience if available
    if (experience != null && experience.isNotEmpty) {
      parts.add('with $experience+ years of experience');
    }

    // Add hospital if available
    if (hospital != null && hospital.isNotEmpty) {
      parts.add('at $hospital Hospital');
    }

    // Add university if available
    if (university != null && university.isNotEmpty) {
      parts.add('graduated from $university University');
    }

    // If no parts were added, return empty string
    if (parts.isEmpty) {
      return '';
    }

    // Join parts with commas
    return parts.join(', ');
  }

  /// Generate Arabic bio from components
  static String _generateArabicBio({
    String? experience,
    String? degree,
    String? university,
    String? hospital,
  }) {
    final parts = <String>[];

    // Add degree if available
    if (degree != null && degree.isNotEmpty) {
      parts.add(degree);
    }

    // Add experience if available
    if (experience != null && experience.isNotEmpty) {
      parts.add('مع $experience سنوات من الخبرة');
    }

    // Add hospital if available
    if (hospital != null && hospital.isNotEmpty) {
      parts.add('في مستشفى $hospital');
    }

    // Add university if available
    if (university != null && university.isNotEmpty) {
      parts.add('متخرج من جامعة $university');
    }

    // If no parts were added, return empty string
    if (parts.isEmpty) {
      return '';
    }

    // Join parts with commas
    return parts.join('، ');
  }
}

// A utility class to hold degree constants and related helper functions
class DegreeConstants {
  // List of medical degrees in English
  static List<String> getEnglishDegrees() {
    return [
      'Doctor',
      'Specialist',
      'Consultant',
      'Professor',
      'MD',
      'PhD',
      'MBBS',
      'FRCS',
      'MRCP',
    ];
  }

  // List of medical degrees in Arabic
  static List<String> getArabicDegrees() {
    return [
      'طبيب',
      'أخصائي',
      'استشاري',
      'بروفيسور',
      'أستاذ',
      'دكتور',
    ];
  }

  // Get a suitable list of degrees based on the current language
  static List<String> getDegreesByLanguage(bool isArabic) {
    return isArabic ? getArabicDegrees() : getEnglishDegrees();
  }

  // Map an English degree to its Arabic equivalent if possible
  static String? getArabicEquivalent(String englishDegree) {
    final mapping = {
      'Doctor': 'طبيب',
      'Specialist': 'أخصائي',
      'Consultant': 'استشاري',
      'Professor': 'بروفيسور',
    };

    return mapping[englishDegree];
  }

  // Map an Arabic degree to its English equivalent if possible
  static String? getEnglishEquivalent(String arabicDegree) {
    final mapping = {
      'طبيب': 'Doctor',
      'أخصائي': 'Specialist',
      'استشاري': 'Consultant',
      'بروفيسور': 'Professor',
      'أستاذ': 'Professor',
      'دكتور': 'Doctor',
    };

    return mapping[arabicDegree];
  }
}
