import 'package:flutter/material.dart';
import 'package:football/theme.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? colors.darkBackground : colors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDarkMode ? colors.darkAppbarBackground : colors.lightAppbarBackground,
        title: Text(
          'عن البرنامج',
          style: TextStyle(fontSize: 30, fontFamily: 'Teko',color: isDarkMode ? colors.mainText : colors.secondaryText,)
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'مرحبًا بك في احنا بتوع الكورة',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'إذا كنت تقرأ هذا، فهذا يعني أنك مثلنا، من عشاق كرة القدم وتبحث دائمًا عن طرق جديدة لاختبار معرفتك بهذه الرياضة الرائعة.',
                style: TextStyle(
                  fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  textDirection: TextDirection.rtl,
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  'ما هو برنامج احنا بتوع الكورة؟',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'احنا بتوع الكورة هي لعبة مصممة خصيصًا لمحبين الاسئلة الرياضية، أنت الذي تعرف قيمة اللحظات المثيرة في عالم كرة القدم. نحن هنا لنقدم لك تجربة ترفيهية، حيث يمكنك اختبار معلوماتك والتحدي مع أصدقائك في مجموعة متنوعة من الأسئلة حول كرة القدم.',
                style: TextStyle(
                  fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  textDirection: TextDirection.rtl,
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  'كيفية اللعب',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'اللعبة بسيطة جدًا! اختر اللعبة التي ترغب في اختبار معلوماتك فيها، ثم أجب على الأسئلة المطروحة. اللعبة تتيح لك اللعب فرديا أو مع صديقا. وكلما أجبت على أسئلة أكثر، كلما ارتفع رصيد نقاطك.',
                style: TextStyle(
                  fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  textDirection: TextDirection.rtl,
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  'مميزات اللعبة',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• تنوع الالعاب: اختر من بين مجموعة واسعة من الالعاب المختلفة التي تغطي كل ما تحب معرفته عن كرة القدم.\n'
                    '• نظام تسجيل النقاط: تابع نقاطك ونقاط أصدقائك في الوقت الحقيقي، وتحداهم للوصول إلى القمة.\n'
                    '• الوضع الليلي والوضع الفاتح: يمكنك اختيار الوضع الذي يناسبك، سواء كنت تحب الألوان الداكنة أو الفاتحة.\n'
                    '• واجهة سهلة الاستخدام: حرصنا على تصميم واجهة سهلة وبسيطة لتتمكن من الاستمتاع باللعبة بدون أي تعقيدات.',
                style: TextStyle(
                  fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  textDirection: TextDirection.rtl,
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  'لماذا أنشأنا هذه اللعبة؟',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'أنا وفريقي عملنا على تطوير البرنامج لأننا مثلك تمامًا، نحب كرة القدم ونستمتع بتحدي أنفسنا وأصدقائنا. أردنا أن نشارك هذا الشغف معك. \n\n نحن من جمع الاسئلة ونظم كل شئ كل تلعب وتستمتع مع أصدقائك',
                style: TextStyle(
                  fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  textDirection: TextDirection.rtl,
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  'كلمة أخيرة',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'نأمل أن تستمتع باللعبة بقدر ما استمتعنا بتطويرها. إذا كان لديك أي أفكار أو ملاحظات، نحن دائمًا هنا للاستماع. نحن نسعى دائمًا لجعل اللعبة أفضل وأفضل.\n\nشكرًا لك على اختيارك لنا، ونتمنى لك أوقاتًا رائعة ومليئة بالمرح مع هذه اللعبة!',
                style: TextStyle(
                  fontSize: 16,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  textDirection: TextDirection.rtl,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
