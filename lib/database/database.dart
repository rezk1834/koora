
final List<Map<String, String>> main_categories = [
  {"title": "تحدي معلومات كرة القدم", "image": "assets/main/games/تحدي معلومات كرة القدم.png", "path": "/games", "type" : "لعبة جماعية",},
  {"title": "دور ال16", "image": "assets/main/games/دور ال16.png", "path": "/round", "type" : "لعبة جماعية",},
];



final List<Map<String, String>> game_categories = [
  {"title": "اهبد صح", "image": "assets/main/saba7o.png", "path": "/ehbed","rules":"سؤال وكل فريق معاه 30 ثانية علشان يجاوب واللي اجابته اقرب بياخد نقطة ولو حد جاب اجابة صح بياخد نقطتين", "type" : "لعبة فردية وجماعية","rounds" : "5 جولات",},
  {"title": "اكدب صح", "image": "assets/main/saba7o.png", "path": "/ekdeb","rules":"كل لاعب من الفريق المنافس هيقول اجابة وهيكون في 3 اختيارات والفريق مطلوب منه يعرف الاجابة الصح", "type" : "لعبة جماعية","rounds" :"5 جولات",},
  {"title": "روندو", "image": "assets/main/saba7o.png", "path": "/rondo","rules":"هنبدأ باسم لاعب او فريق (لو لاعب هتقول اسم فريق بعده والعكس) وهتفضل كده لحد ما المنافس يقول اسم غلط واللاعب يقول cheating لو صح هياخد البوينت لو غلط الخصم هياخد البوينت", "type" : "لعبة جماعية","rounds" : "8 جولات",},
  {"title": "مين في الصورة", "image": "assets/main/saba7o.png", "path": "/men_fe_elsora","rules":"هيكون في صورة لفريق وكل فريق هيقول يجيب اكبر عدد يقدر عليه. الترتيب هيكون ABBA ولو لاعب معرفش يجاوب مرتين ورا بعض بيخسر واللاعب التاني يكمل لحد ما يخسر والبوينت تروح للفريق التاني", "type" : "لعبة جماعية","rounds" : "5 جولات",},
  {"title": "الهمس ", "image": "assets/main/saba7o.png", "path": "/whisper","rules":"اللاعب هيلبس سماعة في ودانه وصاحبه هيحاول يقوله اسم لاعب", "type" : "لعبة جماعية","rounds" : "8 جولات",},
  {"title": "5*10", "image": "assets/main/saba7o.png", "path": "/seconds","rules":"معاك 10 ثواني علشان تقول 5 اجابات صحيحة", "type" : "لعبة فردية","rounds" : "8 جولات",},
  {"title": "من اللاعب", "image": "assets/main/saba7o.png", "path": "/guess_the_player","rules":"هيكون في 5 معلومات عن اللاعب وكل فريق يحاول يعرفه اسرع", "type" : "لعبة فردية و جماعية","rounds" : "3 جولات",},
  {"title": "باسورد", "image": "assets/main/saba7o.png", "path": "/password","rules":"كل لاعب هيحاول يقول لزميله علي اسم اللاعب بس من غير ما يقول اسم او رقم او نادي", "type" : "لعبة جماعية","rounds" : "8 جولات",},
  {"title": "ريسك", "image": "assets/main/saba7o.png", "path": "/risk","rules":"هيكون في 4 كاتيجوري وكل واحدة فيها 4 اسئلة بالتدريج من الاسهل للاصعب والفريق اللي يجمع نقاط اكتر يكسب. في سؤال دابل بوينت الحكم يختاره", "type" : "لعبة فردية و جماعية","rounds": "جولة واحدة", },
  {"title": "بنك", "image": "assets/main/saba7o.png", "path": "/bank","rules":"كل فريق ليه 3 جولات كل جولة 12 سؤال كل لاعب بيتسأل سؤال. كل لاعب ممكن يقول بنك قبل ما يتسأل سؤال وكل اجابة صح النقاط بتزيد (لو مقالش بنك وحد غلط بيرجع ل0) والفريق الللي معاه نقاط اكتر في البنك بيكسب", "type" : "لعبة جماعية","rounds" : "3 جولات",},
  {"title": "لبس صاحبك", "image": "assets/main/saba7o.png", "path": "/Labes","rules":"بيكون في سؤال وكل واحد بيتوقع اللاعب اللي معاه هيقول كام اجابة (اللاعب التاني مش بيكون عارف السؤال)", "type" : "لعبة جماعية","rounds" : "8 جولات",},
  {"title": "عروستي", "image": "assets/main/saba7o.png", "path": "/arosty","rules":"كل لاعب بيتوقع صاحبه هيحتاج كام سؤال (الاجابة بصح او غلط) علشان يعرف اللاعب", "type" : "لعبة جماعية","rounds" : "8 جولات",},
  {"title": "الرسم", "image": "assets/main/saba7o.png", "path": "/draw","rules":"هيكون في لوجو فريق واللاعب هيحاول يرسمه لصاحبه ف 45 ثانيه لو معرفش الفريق التاني هيكون ليه اجابة", "type" : "لعبة جماعية","rounds" : "8 جولات",},
  {"title": "التمثيل", "image": "assets/main/saba7o.png", "path": "/acting","rules":"هيكون في اسم لاعب/مدرب واللاعب هيحاول يمثله لصاحبه من غير ما يتكلم ف45 ثانية ولو معرفش الفريق التاني هيكون ليه 10 ثواني يجاوب فيهم اجابة واحدة", "type" : "لعبة جماعية","rounds" : "10 جولات",},
  {"title": "ماذا تعرف", "image": "assets/main/30 Challenge.png", "path": "/wdyk","rules":"كل لاعب هيقول اجابه ولو حد غلط 3 غلطات بيخسر النقطة", "type" : "لعبة فردية","rounds" : "4 جولات",},
  {"title": "المزاد", "image": "assets/main/30 Challenge.png", "path": "/mazad","rules":"كل لاعب بيتوقع هيقول كام اجابة في خلال 30 ثانية", "type" : "لعبة فردية","rounds" : "6 جولات",},
  {"title": "الجرس", "image": "assets/main/games/الجرس.png", "path": "/bell","rules":"سؤال واللي يجاوب اسرع ياخد النقطة", "type" : "لعبة فردية","rounds" : "10 جولات",},
  {"title": "المستحيل", "image": "assets/main/games/المستحيل.png", "path": "/impossible","rules":"سؤال مستحيل واللي يجاوب اسرع ياخد 2 بوينت", "type" : "لعبة فردية","rounds" : "5 جولات",},
  {"title": "مسيرة اللاعب ", "image": "assets/main/30 Challenge.png", "path": "/career","rules":"هيكون في مسيرة لاعب واللي يعرفه الاول ياخد البوينت", "type" : "لعبة فردية","rounds" : "5 جولات",},
  {"title": "كوبري", "image": "assets/main/Aqua Ta7ady.png", "path": "/kobry","rules":"هيكون في 2 لاعيبة وتحاول توصل بينهم بلاعيبة لعبوا معاهم وهيكون في وقت. اللي هيربط بين الاتنين لاعيبة بعدد لاعبين اقل هيكسب. لو نفس عدد اللاعبين فالاسرع هو اللي هياخد البوينت", "type" : "لعبة فردية","rounds" : "8 جولات",},
  {"title": "خمن البطولة", "image": "assets/main/Aqua Ta7ady.png", "path": "/btola","rules":"هيكون في 5 اسئلة كل سؤال بيكون فيه ماتشات اتلعبت من بطولة من الدور الاول لحد النهائي بالنتيجة بتاعة الماتش والتيم اللي يعرف اسم البطولة والنسخة بياخد البوينت ولو جاوب في اول سؤالين بياخد 2 بوينتس", "type" : "لعبة فردية","rounds" : "5 جولات",},
];


final List<Map<String, String>> challenge_categories = [
  {"title": "ماذا تعرف", "image": "assets/main/30 Challenge.png", "path": "/wdyk","rules":"سؤال وكل فريق معاه 30 ثانية علشان يجاوب واللي اجابته اقرب بياخد نقطة ولو حد جاب اجابة صح بياخد نقطتين", "type" : "لعبة فردية",},
  {"title": "الجرس", "image": "assets/main/30 Challenge.png", "path": "/bell","rules":"s", "type" : "لعبة فردية",},
  {"title": "المستحيل", "image": "assets/main/30 Challenge.png", "path": "/impossible","rules":"sss", "type" : "لعبة فردية",},
  {"title": "مسيرة اللاعب ", "image": "assets/main/30 Challenge.png", "path": "/career","rules":"sssss", "type" : "لعبة فردية",},

];























