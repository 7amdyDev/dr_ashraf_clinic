import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'app_name': 'Dr Ashraf Yehia Clinic',
          'main_button': 'Home',
          'clinic_button': 'Clinic',
          'contact_button': 'Contact Us',
          'doctor_details': 'Gastroenterology & Liver Consultant',
          'doctor_details2': '''
  MS degree of G E & Liver
  Advanced Courses of Diabetis
  Member of (EASL&IDF&EACMED)
  Member of Harvard University - USA
          ''',
          'book_button': 'Book Now',
          'save_button': 'Save',
          'name_label': 'Name:',
          'book_sheet_label': 'Book Appointment',
          'mobile_label': 'Mobile Number:',
          'book_date_label': 'Book Date:',
          'choose_user_label': 'User Name',
        },
        'ar_EG': {
          'app_name': 'عيادة الدكتور أشرف يحيي',
          'main_button': 'الرئيسية',
          'clinic_button': 'العيادة',
          'contact_button': 'أتصل بنا',
          'doctor_details': 'إستشاري الجهاز الهضمي والكبد والمناظير',
          'doctor_details2': '''

    دكتوراه الجهاز الهضمي والكبد 
    ماجيستير الجهاز الهضمي والكبد
    دراسات متقدمة في السكر  
    عضو الجمعية الأوروبية للكبد والجهاز الهضمي
    عضو الجمعية المصرية للكبد والجهاز الهضمي
    زميل جامعة هارفارد - أمريكا
    عضو الجمعية المصرية للسكر
          ''',
          'book_button': 'أحجز الآن',
          'name_label': 'الأسم:',
          'book_sheet_label': 'حجز موعد',
          'mobile_label': 'رقم الموبايل:',
          'book_date_label': 'تاريخ الحجز:',
          'save_button': 'حفظ',
          'choose_user_label': 'أسم المستخدم',
        },
      };
}
