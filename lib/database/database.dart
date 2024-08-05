
final List<Map<String, String>> main_categories = [
  {"title": "تحدي معلومات كرة القدم", "image": "assets/main/saba7o.png", "path": "/games"},
  {"title": "دور ال16", "image": "assets/main/round.png", "path": "/round"},
];



final List<Map<String, String>> game_categories = [
  {"title": "اهبد صح", "image": "assets/main/saba7o.png", "path": "/ehbed","rules":"سؤال وكل فريق معاه 30 ثانية علشان يجاوب واللي اجابته اقرب بياخد نقطة ولو حد جاب اجابة صح بياخد نقطتين"},
  {"title": "اكدب صح", "image": "assets/main/saba7o.png", "path": "/ekdeb","rules":"كل لاعب من الفريق المنافس هيقول اجابة وهيكون في 3 اختيارات والفريق مطلوب منه يعرف الاجابة الصح"},
  {"title": "روندو", "image": "assets/main/saba7o.png", "path": "/rondo","rules":"هنبدأ باسم لاعب او فريق (لو لاعب هتقول اسم فريق بعده والعكس) وهتفضل كده لحد ما المنافس يقول اسم غلط واللاعب يقول cheating لو صح هياخد البوينت لو غلط الخصم هياخد البوينت"},
  {"title": "مين في الصورة", "image": "assets/main/saba7o.png", "path": "/men_fe_elsora","rules":"هيكون في صورة لفريق وكل فريق هيقول يجيب اكبر عدد يقدر عليه. الترتيب هيكون ABBA ولو لاعب معرفش يجاوب مرتين ورا بعض بيخسر واللاعب التاني يكمل لحد ما يخسر والبوينت تروح للفريق التاني"},
  {"title": "الهمس ", "image": "assets/main/saba7o.png", "path": "/whisper","rules":"اللاعب هيلبس سماعة في ودانه وصاحبه هيحاول يقوله اسم لاعب"},
  {"title": "5*10", "image": "assets/main/saba7o.png", "path": "/seconds","rules":"معاك 10 ثواني علشان تقول 5 اجابات صحيحة"},
  {"title": "من اللاعب", "image": "assets/main/saba7o.png", "path": "/guess_the_player","rules":"هيكون في 5 معلومات عن اللاعب وكل فريق يحاول يعرفه اسرع"},
  {"title": "باسورد", "image": "assets/main/saba7o.png", "path": "/password","rules":"كل لاعب هيحاول يقول لزميله علي اسم اللاعب بس من غير ما يقول اسم او رقم او نادي"},
  {"title": "ريسك", "image": "assets/main/saba7o.png", "path": "/risk","rules":"هيكون في 4 كاتيجوري وكل واحدة فيها 4 اسئلة بالتدريج من الاسهل للاصعب والفريق اللي يجمع نقاط اكتر يكسب. في سؤال دابل بوينت الحكم يختاره"},
  {"title": "بنك", "image": "assets/main/saba7o.png", "path": "/bank","rules":"كل فريق ليه 3 جولات كل جولة 12 سؤال كل لاعب بيتسأل سؤال. كل لاعب ممكن يقول بنك قبل ما يتسأل سؤال وكل اجابة صح النقاط بتزيد (لو مقالش بنك وحد غلط بيرجع ل0) والفريق الللي معاه نقاط اكتر في البنك بيكسب"},
  {"title": "لبس صاحبك", "image": "assets/main/saba7o.png", "path": "/labes_sa7bak","rules":"بيكون في سؤال وكل واحد بيتوقع اللاعب اللي معاه هيقول كام اجابة (اللاعب التاني مش بيكون عارف السؤال)"},
  {"title": "عروستي", "image": "assets/main/saba7o.png", "path": "/arosty","rules":"كل لاعب بيتوقع صاحبه هيحتاج كام سؤال (الاجابة بصح او غلط) علشان يعرف اللاعب"},
  {"title": "الرسم", "image": "assets/main/saba7o.png", "path": "/draw","rules":"هيكون في لوجو فريق واللاعب هيحاول يرسمه لصاحبه ف 45 ثانيه لو معرفش الفريق التاني هيكون ليه اجابة"},
  {"title": "التمثيل", "image": "assets/main/saba7o.png", "path": "/acting","rules":"هيكون في اسم لاعب/مدرب واللاعب هيحاول يمثله لصاحبه من غير ما يتكلم ف45 ثانية ولو معرفش الفريق التاني هيكون ليه 10 ثواني يجاوب فيهم اجابة واحدة"},
  {"title": "ماذا تعرف", "image": "assets/main/30 Challenge.png", "path": "/wdyk","rules":"كل لاعب هيقول اجابه ولو حد غلط 3 غلطات بيخسر النقطة"},
  {"title": "المزاد", "image": "assets/main/30 Challenge.png", "path": "/mazad","rules":"كل لاعب بيتوقع هيقول كام اجابة في خلال 30 ثانية"},
  {"title": "الجرس", "image": "assets/main/30 Challenge.png", "path": "/bell","rules":"سؤال واللي يجاوب اسرع ياخد النقطة"},
  {"title": "المستحيل", "image": "assets/main/30 Challenge.png", "path": "/impossible","rules":"سؤال مستحيل واللي يجاوب اسرع ياخد 2 بوينت"},
  {"title": "مسيرة اللاعب ", "image": "assets/main/30 Challenge.png", "path": "/career","rules":"هيكون في مسيرة لاعب واللي يعرفه الاول ياخد البوينت"},
];


final List<Map<String, String>> challenge_categories = [
  {"title": "ماذا تعرف", "image": "assets/main/30 Challenge.png", "path": "/wdyk","rules":"سؤال وكل فريق معاه 30 ثانية علشان يجاوب واللي اجابته اقرب بياخد نقطة ولو حد جاب اجابة صح بياخد نقطتين"},
  {"title": "الجرس", "image": "assets/main/30 Challenge.png", "path": "/bell","rules":"s"},
  {"title": "المستحيل", "image": "assets/main/30 Challenge.png", "path": "/impossible","rules":"sss"},
  {"title": "مسيرة اللاعب ", "image": "assets/main/30 Challenge.png", "path": "/career","rules":"sssss"},

];























