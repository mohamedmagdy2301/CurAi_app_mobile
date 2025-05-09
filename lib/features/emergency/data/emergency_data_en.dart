List<Map<String, dynamic>> emergencyDataEnList = [
  {
    'id': 1,
    'condition': 'Heart Attack',
    'symptoms': [
      'Severe chest pain',
      'Shortness of breath',
      'Excessive sweating',
      'Dizziness or fainting',
    ],
    'emergency_steps': [
      'Call an ambulance immediately (dial 123).',
      'Keep the person seated in a comfortable position and stay with them.',
      'If not allergic, have them chew an aspirin (300 mg).',
      'Do not give food or drink.',
    ],
  },
  {
    'id': 2,
    'condition': 'Low Blood Sugar (Hypoglycemia)',
    'symptoms': [
      'Shaking or sweating',
      'Dizziness',
      'Behavioral or consciousness changes',
      'Fainting',
    ],
    'emergency_steps': [
      'Give the person a drink containing fast-absorbing sugar (juice, honey, soda).',
      'If not improved within 10 minutes, call an ambulance.',
      'If unconscious, do not give anything by mouth and call an ambulance immediately.',
    ],
  },
  {
    'id': 3,
    'condition': 'Severe Bleeding',
    'symptoms': [
      'Bleeding that doesn’t stop within 10 minutes',
      'Rapid blood flow',
      'Pale face and cold limbs',
    ],
    'emergency_steps': [
      'Apply direct pressure to the wound with a clean cloth.',
      'Raise the injured part if possible to reduce blood flow.',
      'Do not remove soaked bandages, add another layer over it.',
      'Call emergency services immediately.',
    ],
  },
  {
    'id': 4,
    'condition': 'Severe Burns',
    'symptoms': [
      'Severe redness or charred skin',
      'Swelling and blisters',
      'Severe pain or numbness',
    ],
    'emergency_steps': [
      'Place the burned area under cold running water for 10 minutes.',
      'Cover the burn with a sterile, non-stick dressing.',
      'Do not apply ice or ointments.',
      'Seek immediate medical help.',
    ],
  },
  {
    'id': 5,
    'condition': 'Choking',
    'symptoms': [
      'Inability to speak or cough',
      'Clutching the neck with hands',
      'Face turning blue',
    ],
    'emergency_steps': [
      'Encourage the person to cough forcefully if they can.',
      'If not, perform the Heimlich maneuver.',
      'Call an ambulance immediately if breathing doesn’t return.',
    ],
  },
  {
    'id': 6,
    'condition': 'Fainting',
    'symptoms': [
      'Sudden loss of consciousness',
      'Pale face',
      'Slow or irregular breathing',
    ],
    'emergency_steps': [
      'Lay the person on their back and elevate their legs slightly.',
      'Check for breathing and pulse.',
      'If unconscious for more than a minute, call emergency services.',
    ],
  },
  {
    'id': 7,
    'condition': 'Poisoning',
    'symptoms': [
      'Nausea and vomiting',
      'Dizziness',
      'Altered consciousness',
      'Stomach pain',
    ],
    'emergency_steps': [
      'Do not induce vomiting.',
      'Identify the substance if possible.',
      'Call the poison center or emergency services immediately.',
    ],
  },
  {
    'id': 8,
    'condition': 'Scorpion or Snake Bite',
    'symptoms': [
      'Severe pain at the bite site',
      'Swelling and redness',
      'Breathing difficulty or dizziness',
    ],
    'emergency_steps': [
      'Immobilize the affected area and limit movement.',
      'Do not attempt to suck out the venom.',
      'Transport the person to the nearest healthcare facility immediately.',
    ],
  },
  {
    'id': 9,
    'condition': 'Electric Shock',
    'symptoms': [
      'Burn marks at contact site',
      'Unconsciousness or stopped breathing',
      'Convulsions or irregular pulse',
    ],
    'emergency_steps': [
      'Immediately disconnect the power source.',
      'Do not touch the person if still connected to electricity.',
      'Call emergency services and begin CPR if necessary.',
    ],
  },
  {
    'id': 10,
    'condition': 'Fractures',
    'symptoms': [
      'Severe pain with movement',
      'Swelling and deformity in the affected limb',
      'Inability to move the injured part',
    ],
    'emergency_steps': [
      'Immobilize the limb with a temporary splint.',
      'Do not attempt to reposition the bone.',
      'Head to the hospital immediately.',
    ],
  },
  {
    'id': 11,
    'condition': 'Seizure (Epileptic Fit)',
    'symptoms': [
      'Involuntary shaking',
      'Temporary loss of consciousness',
      'Biting of tongue or frothing at the mouth',
    ],
    'emergency_steps': [
      'Move sharp or heavy objects away from the person.',
      'Do not restrain their movement or place anything in their mouth.',
      'After the seizure stops, turn them onto their side and wait for consciousness to return.',
      'Call emergency services if seizure lasts more than 5 minutes.',
    ],
  },
  {
    'id': 12,
    'condition': 'Heat Stroke',
    'symptoms': [
      'Very high body temperature',
      'Dry and red skin',
      'Dizziness or unconsciousness',
    ],
    'emergency_steps': [
      'Move the person to a shaded, cool place.',
      'Wet their body with cold water or apply cold compresses.',
      'Give water if conscious.',
      'Seek immediate medical care.',
    ],
  },
  {
    'id': 13,
    'condition': 'Carbon Monoxide Poisoning',
    'symptoms': [
      'Sudden headache',
      'Dizziness and nausea',
      'General fatigue and unconsciousness',
    ],
    'emergency_steps': [
      'Move the person immediately to a well-ventilated area.',
      'Call emergency services right away.',
      'Do not re-enter the contaminated area until fully ventilated.',
    ],
  },
  {
    'id': 14,
    'condition': 'Stroke',
    'symptoms': [
      'Difficulty speaking',
      'Sudden paralysis or weakness on one side of the body',
      'Sudden confusion or severe headache',
    ],
    'emergency_steps': [
      'Call emergency services immediately.',
      'Do not give food or drink.',
      'Note the time symptoms began — it’s crucial for treatment.',
    ],
  },
  {
    'id': 15,
    'condition': 'Severe Low Blood Pressure',
    'symptoms': [
      'Dizziness and fainting',
      'Pale, cold skin',
      'Rapid breathing and weak pulse',
    ],
    'emergency_steps': [
      'Lay the person down and elevate their legs.',
      'Loosen tight clothing.',
      'Go to the nearest emergency center.',
    ],
  },
  {
    'id': 16,
    'condition': 'Sudden High Blood Pressure',
    'symptoms': [
      'Severe headache',
      'Blurred vision',
      'Chest pain or difficulty breathing',
    ],
    'emergency_steps': [
      'Keep the person seated in a comfortable position.',
      'Monitor symptoms and avoid giving medication without prescription.',
      'Call emergency services immediately.',
    ],
  },
  {
    'id': 17,
    'condition': 'Choking in Children',
    'symptoms': [
      'Weak or ineffective cough',
      'Face turning blue',
      'Breathing difficulty or stoppage',
    ],
    'emergency_steps': [
      'Give five gentle back blows between the shoulder blades.',
      'If unsuccessful, perform five chest thrusts.',
      'Call emergency services immediately if no response.',
    ],
  },
  {
    'id': 18,
    'condition': 'Panic Attack / Nervous Breakdown',
    'symptoms': [
      'Sudden severe fear',
      'Palpitations',
      'Breathing difficulty and trembling',
    ],
    'emergency_steps': [
      'Reassure the person and ask them to breathe slowly and deeply.',
      'Take them to a calm, quiet place.',
      'If symptoms persist, seek medical help.',
    ],
  },
  {
    'id': 19,
    'condition': 'Swallowed Foreign Object',
    'symptoms': [
      'Difficulty swallowing',
      'Throat or chest pain',
      'Persistent coughing or choking',
    ],
    'emergency_steps': [
      'Do not attempt to remove the object with fingers.',
      'If the person has breathing difficulty, call an ambulance immediately.',
      'Monitor symptoms until arriving at the hospital.',
    ],
  },
  {
    'id': 20,
    'condition': 'Severe Dehydration',
    'symptoms': [
      'Severe thirst and dry mouth',
      'Dizziness and general weakness',
      'Reduced urination or dark urine',
    ],
    'emergency_steps': [
      'Give the person water or oral rehydration solution if conscious.',
      'Move them to a cool place.',
      'Consult a doctor immediately in severe cases.',
    ],
  }
];
