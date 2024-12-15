import 'package:curai_app_mobile/features/user/models/chatbot_model/messages_chatbot_model.dart';

class MessageFactory {
  static List<MessageModel> generateEnglishMessages() {
    return [
      _createMessage('Hello!', -28, SenderType.user),
      _createMessage('Hi, how can I help you?', -27, SenderType.bot),
      _createMessage('What is the time?', -26, SenderType.user),
      _createMessage("It's 3:00 PM.", -25, SenderType.bot),
      _createMessage('Thanks!', -24, SenderType.user),
      _createMessage("You're welcome!", -23, SenderType.bot),
      _createMessage('How are you?', -22, SenderType.user),
      _createMessage("I am just a bot, but I'm fine!", -21, SenderType.bot),
      _createMessage('Can you tell me a joke?', -20, SenderType.user),
      _createMessage(
        "Why don't robots ever get lost? Because they follow the right path!",
        -19,
        SenderType.bot,
      ),
      _createMessage('Haha, that was funny!', -18, SenderType.user),
      _createMessage(
        "I'm glad you liked it! Anything else I can do for you?",
        -17,
        SenderType.bot,
      ),
      _createMessage('Yes, tell me a riddle!', -16, SenderType.user),
      _createMessage(
        '''What comes once in a minute, twice in a moment, but never in a thousand years? The letter "M".''',
        -15,
        SenderType.bot,
      ),
      _createMessage(
        'That was tricky! Do you have another one?',
        -14,
        SenderType.user,
      ),
      _createMessage(
        "Sure! What has keys but can't open locks? A piano.",
        -13,
        SenderType.bot,
      ),
      _createMessage(
        'Haha, you really know how to entertain!',
        -12,
        SenderType.user,
      ),
      _createMessage('What can you do?', -11, SenderType.user),
      _createMessage(
        '''I can answer your questions, tell jokes, provide riddles, and much more!''',
        -10,
        SenderType.bot,
      ),
      _createMessage('Can you solve math problems?', -9, SenderType.user),
      _createMessage(
        "Absolutely! Give me a math problem, and I'll do my best to solve it.",
        -8,
        SenderType.bot,
      ),
      _createMessage('What is 12 x 9?', -7, SenderType.user),
      _createMessage('12 x 9 = 108.', -6, SenderType.bot),
      _createMessage(
        'Wow, that was fast! Can you tell me about the weather?',
        -5,
        SenderType.user,
      ),
      _createMessage(
        '''I'm sorry, I can't fetch live weather updates yet. But I can suggest what to wear based on seasons!''',
        -4,
        SenderType.bot,
      ),
      _createMessage('What do you think about AI?', -3, SenderType.user),
      _createMessage(
        '''AI is fascinating! It helps humans solve complex problems and makes life easier. What do you think?''',
        -2,
        SenderType.bot,
      ),
      _createMessage('I think AI is amazing!', -1, SenderType.user),
      _createMessage("I'm glad we agree!", 0, SenderType.bot),
    ];
  }

  static List<MessageModel> generateArabicMessages() {
    return [
      _createMessage('مرحبًا!', -28, SenderType.user),
      _createMessage('مرحبًا، كيف يمكنني مساعدتك؟', -27, SenderType.bot),
      _createMessage('ما هو الوقت؟', -26, SenderType.user),
      _createMessage('الساعة 3:00 مساءً.', -25, SenderType.bot),
      _createMessage('شكرًا!', -24, SenderType.user),
      _createMessage('على الرحب والسعة!', -23, SenderType.bot),
      _createMessage('كيف حالك؟', -22, SenderType.user),
      _createMessage('أنا مجرد بوت، ولكنني بخير!', -21, SenderType.bot),
      _createMessage('هل يمكنك أن تخبرني بنكتة؟', -20, SenderType.user),
      _createMessage(
        'لماذا لا تضيع الروبوتات أبدًا؟ لأنها تتبع المسار الصحيح!',
        -19,
        SenderType.bot,
      ),
      _createMessage('هاها، كانت تلك مضحكة!', -18, SenderType.user),
      _createMessage(
        'أنا سعيد أنك أحببتها! هل يمكنني مساعدتك في شيء آخر؟',
        -17,
        SenderType.bot,
      ),
      _createMessage('نعم، أخبرني بأحجية!', -16, SenderType.user),
      _createMessage(
        '''
ما الذي يأتي مرة في الدقيقة، مرتين في اللحظة، ولكن لا يأتي أبدًا في ألف سنة؟ الحرف "م".''',
        -15,
        SenderType.bot,
      ),
      _createMessage(
        'كانت تلك صعبة! هل لديك واحدة أخرى؟',
        -14,
        SenderType.user,
      ),
      _createMessage(
        'بالطبع! ما الذي له مفاتيح ولكن لا يستطيع فتح الأقفال؟ البيانو.',
        -13,
        SenderType.bot,
      ),
      _createMessage('هاها، أنت حقًا تعرف كيف تُسلّي!', -12, SenderType.user),
      _createMessage('ما الذي يمكنك فعله؟', -11, SenderType.user),
      _createMessage(
        ''''أستطيع الإجابة على أسئلتك، وإخبارك بالنكات، وتقديم الأحاجي، والكثير غير ذلك!''',
        -10,
        SenderType.bot,
      ),
      _createMessage('هل يمكنك حل مسائل رياضية؟', -9, SenderType.user),
      _createMessage(
        'بالطبع! أعطني مسألة رياضية وسأحاول حلها بأفضل ما يمكن.',
        -8,
        SenderType.bot,
      ),
      _createMessage('ما هو 12 x 9؟', -7, SenderType.user),
      _createMessage('12 x 9 = 108.', -6, SenderType.bot),
      _createMessage(
        'رائع، كان هذا سريعًا! هل يمكنك إخباري عن الطقس؟',
        -5,
        SenderType.user,
      ),
      _createMessage(
        '''أنا آسف، لا يمكنني الحصول على تحديثات الطقس المباشرة بعد. لكن يمكنني اقتراح ما ترتديه بناءً على المواسم!''',
        -4,
        SenderType.bot,
      ),
      _createMessage('ما رأيك في الذكاء الاصطناعي؟', -3, SenderType.user),
      _createMessage(
        '''الذكاء الاصطناعي مثير جدًا! يساعد البشر في حل المشكلات المعقدة ويسهل الحياة. ما رأيك؟''',
        -2,
        SenderType.bot,
      ),
      _createMessage('أعتقد أن الذكاء الاصطناعي مذهل!', -1, SenderType.user),
      _createMessage('أنا سعيد أننا نتفق!', 0, SenderType.bot),
    ];
  }

  static MessageModel _createMessage(
    String text,
    int relativeMinutes,
    SenderType sender,
  ) {
    return MessageModel(
      messageText: text,
      date: DateTime.now().add(Duration(minutes: relativeMinutes)),
      sender: sender,
    );
  }
}

final List<MessageModel> messagesListEnglish =
    MessageFactory.generateEnglishMessages();
final List<MessageModel> messagesListArabic =
    MessageFactory.generateArabicMessages();
