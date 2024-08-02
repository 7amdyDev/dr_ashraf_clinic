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
          'update_button': 'Update',
          'delete_button': 'Delete',
          'name_label': 'Name',
          'book_sheet_label': 'Book Appointment',
          'mobile_label': 'Mobile Number:',
          'book_date_label': 'Book Date:',
          'choose_user_label': 'User Name',
          'password_label': 'Password',
          'login_button': 'Login',
          'appointment_label': 'Schedule',
          'reserve_label': 'Reserve',
          'patient_label': 'Patient Profile',
          'new_patient_label': 'New Profile',
          'search_patient_label': 'Patient Search',
          'finance_label': 'Finance',
          'patient_finance_label': 'Patient Finance',
          'clinic_expenses_label': 'Clinic Expenses',
          'expenses_label': 'Expenses',
          'cash_label': 'Cash',
          'daily_revenue_label': 'Daily Income',
          'schedule_table_label': 'Schedule Table',
          'today_label': 'Today Schedule',
          'choose_date_label': 'Select Date',
          'no_show_label': 'No Show',
          'waiting_label': 'Waiting',
          'canceled_label': 'Canceled',
          'completed_label': 'Completed',
          'patient_name_label': 'Patient Name',
          'date_label': 'Date',
          'service_type_label': 'Service Type',
          'telephone_label': 'Telephone No.',
          'status_label': 'Status',
          'online_table_label': 'Online Reservation',
          'request_checkbox_label': 'Request Check',
          'logout_label': 'Logout',
          'appointment_page_label': 'Book Appointment',
          'hint_search_label':
              'Search by File no., Telephone no., Patient name.',
          'search_lst_patient_name_label': 'By Patient name',
          'search_lst_telephone_no_label': 'By Telephone no.',
          'search_lst_file_no_label': 'By File no.',
          'age_label': 'Age',
          'address_label': 'Address',
          'id_no_label': 'File No.',
          'paid_label': 'Paid',
          'cancel_button': 'Cancel',
          'search_result_label': 'Search Result',
          'male_label': 'Male',
          'female_label': 'Female',
          'gender_label': 'Gender',
          'personal_info_label': 'Personal Information',
          'medical_info_label': 'Medical Information',
          'family_history_label': 'Family Medical History',
          'surgical_history_label': 'Surgical History',
          'medications_label': 'Medications',
          'allergies_label': 'Allergies',
          'past_medical_label': 'Past Medical Conditions',
          'notes_label': 'Notes',
          'medical_supplies_label': 'Medical Supplies',
          'rent_label': 'Rent',
          'salaries_label': 'Salary',
          'utilities_label': 'Bills',
          'other_label': 'Other',
          'expense_type_label': 'Expense Type',
          'description_label': 'Description',
          'value_label': 'Value',
          'add_expense_label': 'Add Expense',
          'validation_required_label': 'Required',
          'validation_numbers_label': 'Only Numbers',
          'validation_text_label': 'At least 3 characters.',
          'expenses_table_label': 'Expenses Table',
          'patient_accounts_label': 'Patient Accounts',
          'patient_unpaid_label': 'Unpaid',
          'patient_paid_label': 'Paid',
          'cash_receipt_label': 'Cash Receipt',
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
          'update_button': 'تحديث',
          'delete_button': 'حذف',
          'choose_user_label': 'أسم المستخدم',
          'password_label': 'كلمة السر',
          'login_button': 'تسجيل الدخول',
          'appointment_label': 'المواعيد',
          'reserve_label': 'حجز موعد',
          'patient_label': 'ملفات المرضي',
          'new_patient_label': 'ملف جديد',
          'search_patient_label': 'بحث عن مريض',
          'finance_label': 'الحسابات',
          'patient_finance_label': 'حسابات المرضي',
          'clinic_expenses_label': 'مصروفات العيادة',
          'expenses_label': 'المصروفات',
          'cash_label': 'النقدية',
          'daily_revenue_label': 'الدخل اليومي',
          'schedule_table_label': 'جدول المواعيد',
          'today_label': 'مواعيد اليوم',
          'choose_date_label': 'إختيار تاريخ',
          'no_show_label': 'لم يظهر',
          'waiting_label': 'إنتظار',
          'canceled_label': 'ملغي',
          'completed_label': 'مكتمل',
          'patient_name_label': 'أسم المريض',
          'date_label': 'التاريخ',
          'service_type_label': 'نوع الخدمة',
          'telephone_label': 'رقم التليفون',
          'status_label': 'الحالة',
          'online_table_label': 'حجز الأونلاين',
          'request_checkbox_label': 'مراجعة الطلب',
          'logout_label': 'تسجيل الخروج',
          'appointment_page_label': 'حجز موعد',
          'hint_search_label': 'البحث باسم المريض ، رقم التليفون ، رقم الملف',
          'search_lst_patient_name_label': 'بأسم المريض',
          'search_lst_telephone_no_label': 'برقم التليفون',
          'search_lst_file_no_label': 'برقم الملف',
          'age_label': 'السن',
          'address_label': 'العنوان',
          'id_no_label': 'رقم الملف',
          'paid_label': 'تم الدفع',
          'cancel_button': 'إلغاء',
          'search_result_label': 'نتائج البحث',
          'male_label': 'ذكر',
          'female_label': 'أنثي',
          'gender_label': 'الجنس',
          'personal_info_label': 'المعلومات الشخصية',
          'medical_info_label': 'المعلومات الطبية',
          'family_history_label': 'التاريخ العائلي الطبي',
          'surgical_history_label': 'التاريخ الجراحي',
          'medications_label': 'الأدوية',
          'allergies_label': 'الحساسية',
          'past_medical_label': 'الحالات الطبية السابقة',
          'notes_label': 'ملاحظات',
          'medical_supplies_label': 'مستلزمات طبية',
          'rent_label': 'إيجار',
          'salaries_label': 'مرتبات',
          'utilities_label': 'فواتير',
          'other_label': 'أخري',
          'expense_type_label': 'نوع المصروف',
          'description_label': 'الوصف',
          'value_label': 'القيمة',
          'add_expense_label': 'إضافة مصروف',
          'validation_required_label': 'مطلوب',
          'validation_numbers_label': 'أرقام فقط',
          'validation_text_label': 'على الأقل ٣ أحرف',
          'expenses_table_label': 'جدول المصروفات',
          'patient_accounts_label': 'حسابات المريض',
          'patient_unpaid_label': ' المتبقي',
          'patient_paid_label': 'المدفوع',
          'check_label': 'كشف',
          'consult_label': 'متابعة',
          'cash_receipt_label': 'إيصال دفع',
        },
      };
}
