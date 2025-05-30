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
      'specialization': '',
      'certifications': '',
      'associations': '',
      'conferences': '',
      'skills': '',
      'training': '',
      'volunteer': '',
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

    // Specialization
    final specializationRegex = RegExp(
      r'(?:specialized in|تخصص في)\s+([A-Za-zأ-ي\s]+)',
      caseSensitive: false,
    );
    final specializationMatch = specializationRegex.firstMatch(bioText);
    if (specializationMatch != null) {
      result['specialization'] = specializationMatch.group(1)?.trim() ?? '';
    }

    // Certifications
    final certificationsRegex = RegExp(
      r'(?:certified|شهادة|حاصل على)\s+([A-Za-zأ-ي\s]+)',
      caseSensitive: false,
    );
    final certificationsMatch = certificationsRegex.firstMatch(bioText);
    if (certificationsMatch != null) {
      result['certifications'] = certificationsMatch.group(1)?.trim() ?? '';
    }

    // Associations
    final associationsRegex = RegExp(
      r'(?:member of|عضو في)\s+([A-Za-zأ-ي\s]+)',
      caseSensitive: false,
    );
    final associationsMatch = associationsRegex.firstMatch(bioText);
    if (associationsMatch != null) {
      result['associations'] = associationsMatch.group(1)?.trim() ?? '';
    }

    // Conferences
    final conferencesRegex = RegExp(
      r'(?:attended|حضر)\s+([A-Za-zأ-ي\s]+)(?:conference|ندوة)',
      caseSensitive: false,
    );
    final conferencesMatch = conferencesRegex.firstMatch(bioText);
    if (conferencesMatch != null) {
      result['conferences'] = conferencesMatch.group(1)?.trim() ?? '';
    }

    // Skills
    final skillsRegex = RegExp(
      r'(?:skilled in|مهارات في)\s+([A-Za-zأ-ي\s]+)',
      caseSensitive: false,
    );
    final skillsMatch = skillsRegex.firstMatch(bioText);
    if (skillsMatch != null) {
      result['skills'] = skillsMatch.group(1)?.trim() ?? '';
    }

    // Training
    final trainingRegex = RegExp(
      r'(?:trained at|تدريب في)\s+([A-Za-zأ-ي\s]+)',
      caseSensitive: false,
    );
    final trainingMatch = trainingRegex.firstMatch(bioText);
    if (trainingMatch != null) {
      result['training'] = trainingMatch.group(1)?.trim() ?? '';
    }

    // Volunteer work
    final volunteerRegex = RegExp(
      r'(?:volunteer|عمل تطوعي)\s+([A-Za-zأ-ي\s]+)',
      caseSensitive: false,
    );
    final volunteerMatch = volunteerRegex.firstMatch(bioText);
    if (volunteerMatch != null) {
      result['volunteer'] = volunteerMatch.group(1)?.trim() ?? '';
    }

    return result;
  }

  /// Combines bio components into a formatted bio string
  static String generateBio({
    String? experience,
    String? degree,
    String? university,
    String? hospital,
    String? specialization,
    String? certifications,
    String? associations,
    String? conferences,
    String? skills,
    String? training,
    String? volunteer,
    bool isArabic = false,
  }) {
    if (isArabic) {
      return _generateArabicBio(
        experience: experience,
        degree: degree,
        university: university,
        hospital: hospital,
        specialization: specialization,
        certifications: certifications,
        associations: associations,
        conferences: conferences,
        skills: skills,
        training: training,
        volunteer: volunteer,
      );
    } else {
      return _generateEnglishBio(
        experience: experience,
        degree: degree,
        university: university,
        hospital: hospital,
        specialization: specialization,
        certifications: certifications,
        associations: associations,
        conferences: conferences,
        skills: skills,
        training: training,
        volunteer: volunteer,
      );
    }
  }

  static String _generateEnglishBio({
    String? experience,
    String? degree,
    String? university,
    String? hospital,
    String? specialization,
    String? certifications,
    String? associations,
    String? conferences,
    String? skills,
    String? training,
    String? volunteer,
  }) {
    final parts = <String>[];

    if (degree != null && degree.isNotEmpty) {
      parts.add(degree);
    }
    if (experience != null && experience.isNotEmpty) {
      parts.add('with $experience+ years of experience');
    }
    if (specialization != null && specialization.isNotEmpty) {
      parts.add('specialized in $specialization');
    }
    if (certifications != null && certifications.isNotEmpty) {
      parts.add('certified in $certifications');
    }
    if (associations != null && associations.isNotEmpty) {
      parts.add('member of $associations');
    }
    if (conferences != null && conferences.isNotEmpty) {
      parts.add('attended $conferences conference');
    }
    if (skills != null && skills.isNotEmpty) {
      parts.add('skilled in $skills');
    }
    if (training != null && training.isNotEmpty) {
      parts.add('trained at $training');
    }
    if (volunteer != null && volunteer.isNotEmpty) {
      parts.add('volunteer work: $volunteer');
    }
    if (hospital != null && hospital.isNotEmpty) {
      parts.add('at $hospital Hospital');
    }
    if (university != null && university.isNotEmpty) {
      parts.add('graduated from $university University');
    }

    return parts.join(', ');
  }

  static String _generateArabicBio({
    String? experience,
    String? degree,
    String? university,
    String? hospital,
    String? specialization,
    String? certifications,
    String? associations,
    String? conferences,
    String? skills,
    String? training,
    String? volunteer,
  }) {
    final parts = <String>[];

    if (degree != null && degree.isNotEmpty) {
      parts.add(degree);
    }
    if (experience != null && experience.isNotEmpty) {
      parts.add('مع $experience سنوات من الخبرة');
    }
    if (specialization != null && specialization.isNotEmpty) {
      parts.add('متخصص في $specialization');
    }
    if (certifications != null && certifications.isNotEmpty) {
      parts.add('حاصل على شهادة في $certifications');
    }
    if (associations != null && associations.isNotEmpty) {
      parts.add('عضو في $associations');
    }
    if (conferences != null && conferences.isNotEmpty) {
      parts.add('حضر مؤتمر $conferences');
    }
    if (skills != null && skills.isNotEmpty) {
      parts.add('مهارات في $skills');
    }
    if (training != null && training.isNotEmpty) {
      parts.add('تدريب في $training');
    }
    if (volunteer != null && volunteer.isNotEmpty) {
      parts.add('عمل تطوعي في $volunteer');
    }
    if (hospital != null && hospital.isNotEmpty) {
      parts.add('في مستشفى $hospital');
    }
    if (university != null && university.isNotEmpty) {
      parts.add('متخرج من جامعة $university');
    }

    return parts.join(', ');
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
  static List<String> getDegreesByLanguage({required bool isArabic}) {
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
