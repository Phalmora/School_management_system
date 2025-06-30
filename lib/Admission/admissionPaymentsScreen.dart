import 'package:flutter/material.dart';
import 'package:school/customWidgets/commonCustomWidget/commonMainInput.dart';

class AdmissionPaymentsScreen extends StatefulWidget {
  const AdmissionPaymentsScreen({super.key});

  @override
  State<AdmissionPaymentsScreen> createState() => _AdmissionPaymentsScreenState();
}

class _AdmissionPaymentsScreenState extends State<AdmissionPaymentsScreen> {
  String selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppThemeColor.primaryGradient,
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: AppThemeResponsiveness.getMaxWidth(context),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppThemeResponsiveness.getDashboardHorizontalPadding(context),
                    vertical: AppThemeResponsiveness.getDashboardVerticalPadding(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: AppThemeResponsiveness.getLargeSpacing(context)),

                      // Title Section with responsive spacing and text
                      _buildTitleSection(),

                      SizedBox(height: AppThemeResponsiveness.getLargeSpacing(context)),

                      // Payment Options Card with responsive layout
                      _buildPaymentOptionsCard(),

                      SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),

                      // Amount Display Card with responsive design
                      _buildAmountDisplayCard(),

                      SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),

                      // Navigation Buttons with responsive sizing
                      _buildNavigationButtons(),

                      SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        Text(
          'Choose Payment Method',
          style: AppThemeResponsiveness.getFontStyle(context).copyWith(
            fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 22.0 :
            AppThemeResponsiveness.isMediumPhone(context) ? 26.0 :
            AppThemeResponsiveness.isLargePhone(context) ? 28.0 :
            AppThemeResponsiveness.isTablet(context) ? 32.0 : 36.0,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
        Text(
          'Select your preferred payment option',
          style: AppThemeResponsiveness.getSplashSubtitleStyle(context).copyWith(
            fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 12.0 :
            AppThemeResponsiveness.isMediumPhone(context) ? 14.0 :
            AppThemeResponsiveness.isLargePhone(context) ? 15.0 :
            AppThemeResponsiveness.isTablet(context) ? 16.0 : 18.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPaymentOptionsCard() {
    return Card(
      elevation: AppThemeResponsiveness.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
      ),
      child: Container(
        padding: EdgeInsets.all(
          AppThemeResponsiveness.isSmallPhone(context) ? 16.0 :
          AppThemeResponsiveness.isMediumPhone(context) ? 20.0 :
          AppThemeResponsiveness.isLargePhone(context) ? 24.0 :
          AppThemeResponsiveness.isTablet(context) ? 28.0 : 32.0,
        ),
        child: Column(
          children: [
            // UPI Payment Option
            _buildPaymentOption(
              icon: Icons.account_balance_wallet,
              title: 'UPI Payment',
              subtitle: 'Pay using Google Pay, PhonePe, Paytm, etc.',
              paymentMethod: 'UPI',
              onTap: () => _handleUPIPayment(),
            ),

            SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),

            // Card Payment Option
            _buildPaymentOption(
              icon: Icons.credit_card,
              title: 'Card Payment',
              subtitle: 'Pay using Debit/Credit Card',
              paymentMethod: 'CARD',
              onTap: () => _handleCardPayment(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountDisplayCard() {
    return Card(
      elevation: AppThemeResponsiveness.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
      ),
      color: AppThemeColor.white.withOpacity(0.1),
      child: Container(
        padding: EdgeInsets.all(
          AppThemeResponsiveness.isSmallPhone(context) ? 20.0 :
          AppThemeResponsiveness.isMediumPhone(context) ? 24.0 :
          AppThemeResponsiveness.isLargePhone(context) ? 28.0 :
          AppThemeResponsiveness.isTablet(context) ? 32.0 : 36.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
          border: Border.all(
            color: AppThemeColor.white.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            Text(
              'Total Amount',
              style: AppThemeResponsiveness.getSubHeadingStyle(context).copyWith(
                color: AppThemeColor.white70,
                fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 12.0 :
                AppThemeResponsiveness.isMediumPhone(context) ? 14.0 :
                AppThemeResponsiveness.isLargePhone(context) ? 15.0 :
                AppThemeResponsiveness.isTablet(context) ? 16.0 : 18.0,
              ),
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              '₹ 5,000',
              style: AppThemeResponsiveness.getFontStyle(context).copyWith(
                fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 24.0 :
                AppThemeResponsiveness.isMediumPhone(context) ? 28.0 :
                AppThemeResponsiveness.isLargePhone(context) ? 32.0 :
                AppThemeResponsiveness.isTablet(context) ? 36.0 : 40.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
            Text(
              'Admission Fee',
              style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
                color: AppThemeColor.white.withOpacity(0.8),
                fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 10.0 :
                AppThemeResponsiveness.isMediumPhone(context) ? 11.0 :
                AppThemeResponsiveness.isLargePhone(context) ? 12.0 :
                AppThemeResponsiveness.isTablet(context) ? 13.0 : 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String paymentMethod,
    required VoidCallback onTap,
  }) {
    bool isSelected = selectedPaymentMethod == paymentMethod;

    // Responsive padding and sizing
    double containerPadding = AppThemeResponsiveness.isSmallPhone(context) ? 12.0 :
    AppThemeResponsiveness.isMediumPhone(context) ? 16.0 :
    AppThemeResponsiveness.isLargePhone(context) ? 18.0 :
    AppThemeResponsiveness.isTablet(context) ? 20.0 : 22.0;

    double iconContainerPadding = AppThemeResponsiveness.isSmallPhone(context) ? 8.0 :
    AppThemeResponsiveness.isMediumPhone(context) ? 10.0 :
    AppThemeResponsiveness.isLargePhone(context) ? 12.0 :
    AppThemeResponsiveness.isTablet(context) ? 14.0 : 16.0;

    double iconSize = AppThemeResponsiveness.isSmallPhone(context) ? 20.0 :
    AppThemeResponsiveness.isMediumPhone(context) ? 22.0 :
    AppThemeResponsiveness.isLargePhone(context) ? 24.0 :
    AppThemeResponsiveness.isTablet(context) ? 28.0 : 32.0;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = paymentMethod;
        });
        onTap();
      },
      child: AnimatedContainer(
        duration: AppThemeColor.buttonAnimationDuration,
        padding: EdgeInsets.all(containerPadding),
        decoration: BoxDecoration(
          color: isSelected
              ? AppThemeColor.blue50.withOpacity(0.3)
              : AppThemeColor.greyl.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          border: Border.all(
            color: isSelected
                ? AppThemeColor.blue600
                : Colors.grey.withOpacity(0.3),
            width: isSelected ? AppThemeResponsiveness.getFocusedBorderWidth(context) : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppThemeColor.blue600.withOpacity(0.1),
              blurRadius: AppThemeResponsiveness.isMobile(context) ? 6 : 8,
              spreadRadius: AppThemeResponsiveness.isMobile(context) ? 1 : 2,
            )
          ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(iconContainerPadding),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppThemeColor.blue600.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppThemeColor.blue600 : Colors.grey[600],
                size: iconSize,
              ),
            ),
            SizedBox(width: AppThemeResponsiveness.getDefaultSpacing(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
                      color: isSelected ? AppThemeColor.blue600 : Colors.grey[800],
                      fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 14.0 :
                      AppThemeResponsiveness.isMediumPhone(context) ? 15.0 :
                      AppThemeResponsiveness.isLargePhone(context) ? 16.0 :
                      AppThemeResponsiveness.isTablet(context) ? 18.0 : 20.0,
                    ),
                  ),
                  SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context) / 2),
                  Text(
                    subtitle,
                    style: AppThemeResponsiveness.getSubHeadingStyle(context).copyWith(
                      fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 11.0 :
                      AppThemeResponsiveness.isMediumPhone(context) ? 12.0 :
                      AppThemeResponsiveness.isLargePhone(context) ? 13.0 :
                      AppThemeResponsiveness.isTablet(context) ? 14.0 : 15.0,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? AppThemeColor.blue600 : Colors.grey[400],
              size: iconSize * 0.9,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    // Responsive button layout - stack vertically on small phones
    if (AppThemeResponsiveness.isSmallPhone(context)) {
      return Column(
        children: [
          Container(
            width: double.infinity,
            height: AppThemeResponsiveness.getButtonHeight(context),
            child: ElevatedButton(
              onPressed: selectedPaymentMethod.isEmpty ? null : () {
                if (selectedPaymentMethod == 'UPI') {
                  _handleUPIPayment();
                } else if (selectedPaymentMethod == 'CARD') {
                  _handleCardPayment();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppThemeColor.blue600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                ),
                elevation: AppThemeResponsiveness.getButtonElevation(context),
              ),
              child: Text(
                'Proceed to Pay',
                style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                  fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 14.0 : 16.0,
                ),
              ),
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
          Container(
            width: double.infinity,
            height: AppThemeResponsiveness.getButtonHeight(context),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                ),
                elevation: AppThemeResponsiveness.getButtonElevation(context),
              ),
              child: Text(
                'Back',
                style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                  color: Colors.grey[700],
                  fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 14.0 : 16.0,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Horizontal layout for larger screens
    return Row(
      children: [
        Expanded(
          child: Container(
            height: AppThemeResponsiveness.getButtonHeight(context),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                ),
                elevation: AppThemeResponsiveness.getButtonElevation(context),
              ),
              child: Text(
                'Back',
                style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
        Expanded(
          child: Container(
            height: AppThemeResponsiveness.getButtonHeight(context),
            child: ElevatedButton(
              onPressed: selectedPaymentMethod.isEmpty ? null : () {
                if (selectedPaymentMethod == 'UPI') {
                  _handleUPIPayment();
                } else if (selectedPaymentMethod == 'CARD') {
                  _handleCardPayment();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppThemeColor.blue600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                ),
                elevation: AppThemeResponsiveness.getButtonElevation(context),
              ),
              child: Text(
                'Proceed to Pay',
                style: AppThemeResponsiveness.getButtonTextStyle(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleUPIPayment() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildUPIBottomSheet(),
    );
  }

  void _handleCardPayment() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildCardBottomSheet(),
    );
  }

  Widget _buildUPIBottomSheet() {
    return Container(
      decoration: BoxDecoration(
        color: AppThemeColor.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
      ),
      padding: EdgeInsets.all(
        AppThemeResponsiveness.isSmallPhone(context) ? 16.0 :
        AppThemeResponsiveness.isMediumPhone(context) ? 20.0 :
        AppThemeResponsiveness.isLargePhone(context) ? 24.0 :
        AppThemeResponsiveness.isTablet(context) ? 28.0 : 32.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar with responsive width
          Container(
            width: AppThemeResponsiveness.isSmallPhone(context) ? 30 :
            AppThemeResponsiveness.isMobile(context) ? 40 : 50,
            height: 4,
            decoration: BoxDecoration(
              color: AppThemeColor.greyl,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
          Text(
            'Choose UPI App',
            style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
              fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 16.0 :
              AppThemeResponsiveness.isMediumPhone(context) ? 18.0 :
              AppThemeResponsiveness.isLargePhone(context) ? 20.0 :
              AppThemeResponsiveness.isTablet(context) ? 22.0 : 24.0,
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
          _buildUPIOption('Google Pay', Icons.account_balance_wallet, AppThemeColor.blue600),
          _buildUPIOption('PhonePe', Icons.phone_android, AppThemeColor.primaryIndigo),
          _buildUPIOption('Paytm', Icons.account_balance, AppThemeColor.primaryBlue),
          _buildUPIOption('Other UPI Apps', Icons.more_horiz, Colors.grey),
          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
        ],
      ),
    );
  }

  Widget _buildUPIOption(String name, IconData icon, Color color) {
    double iconRadius = AppThemeResponsiveness.isSmallPhone(context) ? 18.0 :
    AppThemeResponsiveness.isMediumPhone(context) ? 20.0 :
    AppThemeResponsiveness.isLargePhone(context) ? 22.0 :
    AppThemeResponsiveness.isTablet(context) ? 26.0 : 30.0;

    return Container(
      margin: EdgeInsets.only(bottom: AppThemeResponsiveness.getSmallSpacing(context)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppThemeResponsiveness.isSmallPhone(context) ? 12.0 :
          AppThemeResponsiveness.isMediumPhone(context) ? 16.0 :
          AppThemeResponsiveness.isLargePhone(context) ? 20.0 :
          AppThemeResponsiveness.isTablet(context) ? 24.0 : 28.0,
          vertical: AppThemeResponsiveness.getSmallSpacing(context),
        ),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          radius: iconRadius,
          child: Icon(
            icon,
            color: color,
            size: iconRadius * 0.8,
          ),
        ),
        title: Text(
          name,
          style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
            fontWeight: FontWeight.w500,
            fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 12.0 :
            AppThemeResponsiveness.isMediumPhone(context) ? 13.0 :
            AppThemeResponsiveness.isLargePhone(context) ? 14.0 :
            AppThemeResponsiveness.isTablet(context) ? 15.0 : 16.0,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: AppThemeResponsiveness.getIconSize(context) * 0.6,
          color: Colors.grey,
        ),
        onTap: () {
          Navigator.pop(context);
          _processPayment('UPI', name);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        ),
      ),
    );
  }

  Widget _buildCardBottomSheet() {
    // Responsive height calculation
    double sheetHeight = AppThemeResponsiveness.isSmallPhone(context)
        ? AppThemeResponsiveness.getScreenHeight(context) * 0.8
        : AppThemeResponsiveness.isMobile(context)
        ? AppThemeResponsiveness.getScreenHeight(context) * 0.7
        : AppThemeResponsiveness.getScreenHeight(context) * 0.6;

    return Container(
      decoration: BoxDecoration(
        color: AppThemeColor.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
      ),
      padding: EdgeInsets.all(
        AppThemeResponsiveness.isSmallPhone(context) ? 16.0 :
        AppThemeResponsiveness.isMediumPhone(context) ? 20.0 :
        AppThemeResponsiveness.isLargePhone(context) ? 24.0 :
        AppThemeResponsiveness.isTablet(context) ? 28.0 : 32.0,
      ),
      height: sheetHeight,
      child: Column(
        children: [
          // Handle bar
          Container(
            width: AppThemeResponsiveness.isSmallPhone(context) ? 30 :
            AppThemeResponsiveness.isMobile(context) ? 40 : 50,
            height: 4,
            decoration: BoxDecoration(
              color: AppThemeColor.greyd,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),
          Text(
            'Card Details',
            style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
              fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 16.0 :
              AppThemeResponsiveness.isMediumPhone(context) ? 18.0 :
              AppThemeResponsiveness.isLargePhone(context) ? 20.0 :
              AppThemeResponsiveness.isTablet(context) ? 22.0 : 24.0,
            ),
          ),
          SizedBox(height: AppThemeResponsiveness.getExtraLargeSpacing(context)),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Card Number Field
                  _buildCardInputField(
                    label: 'Card Number',
                    hint: '1234 5678 9012 3456',
                    icon: Icons.credit_card,
                    keyboardType: TextInputType.number,
                  ),

                  SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),

                  // Expiry and CVV Row - Stack on small phones
                  AppThemeResponsiveness.isSmallPhone(context)
                      ? Column(
                    children: [
                      _buildCardInputField(
                        label: 'Expiry Date',
                        hint: 'MM/YY',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                      _buildCardInputField(
                        label: 'CVV',
                        hint: '123',
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                    ],
                  )
                      : Row(
                    children: [
                      Expanded(
                        child: _buildCardInputField(
                          label: 'Expiry Date',
                          hint: 'MM/YY',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: AppThemeResponsiveness.getMediumSpacing(context)),
                      Expanded(
                        child: _buildCardInputField(
                          label: 'CVV',
                          hint: '123',
                          keyboardType: TextInputType.number,
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),

                  // Cardholder Name Field
                  _buildCardInputField(
                    label: 'Cardholder Name',
                    hint: 'John Doe',
                    icon: Icons.person,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: AppThemeResponsiveness.getDefaultSpacing(context)),

          // Pay Button
          Container(
            width: double.infinity,
            height: AppThemeResponsiveness.getButtonHeight(context),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _processPayment('Card', 'Credit/Debit Card');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppThemeColor.blue600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                ),
                elevation: AppThemeResponsiveness.getButtonElevation(context),
              ),
              child: Text(
                'Pay ₹5,000',
                style: AppThemeResponsiveness.getButtonTextStyle(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardInputField({
    required String label,
    required String hint,
    IconData? icon,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextFormField(
      style: AppThemeResponsiveness.getBodyTextStyle(context),
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppThemeResponsiveness.getSubHeadingStyle(context),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: AppThemeColor.blue600,
            width: AppThemeResponsiveness.getFocusedBorderWidth(context),
          ),
        ),
        prefixIcon: icon != null ? Icon(
          icon,
          size: AppThemeResponsiveness.getIconSize(context),
        ) : null,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppThemeResponsiveness.isSmallPhone(context) ? 12.0 :
          AppThemeResponsiveness.isMediumPhone(context) ? 16.0 :
          AppThemeResponsiveness.isLargePhone(context) ? 20.0 :
          AppThemeResponsiveness.isTablet(context) ? 24.0 : 28.0,
          vertical: AppThemeResponsiveness.getMediumSpacing(context),
        ),
      ),
    );
  }

  void _processPayment(String method, String provider) {
    // Show loading dialog with responsive sizing
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
        ),
        contentPadding: EdgeInsets.all(
          AppThemeResponsiveness.isSmallPhone(context) ? 16.0 :
          AppThemeResponsiveness.isMediumPhone(context) ? 20.0 :
          AppThemeResponsiveness.isLargePhone(context) ? 24.0 :
          AppThemeResponsiveness.isTablet(context) ? 28.0 : 32.0,
        ),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: AppThemeResponsiveness.isSmallPhone(context) ? 20.0 : 24.0,
              height: AppThemeResponsiveness.isSmallPhone(context) ? 20.0 : 24.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppThemeColor.blue600),
                strokeWidth: 2.5,
              ),
            ),
            SizedBox(width: AppThemeResponsiveness.getDefaultSpacing(context)),
            Flexible(
              child: Text(
                'Processing payment...',
                style: AppThemeResponsiveness.getBodyTextStyle(context),
              ),
            ),
          ],
        ),
      ),
    );

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog

      // Show success dialog with responsive design
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getCardBorderRadius(context)),
    ),
    contentPadding: EdgeInsets.all(
    AppThemeResponsiveness.isSmallPhone(context) ? 16.0 :
    AppThemeResponsiveness.isMediumPhone(context) ? 20.0 :
    AppThemeResponsiveness.isLargePhone(context) ? 24.0 :
    AppThemeResponsiveness.isTablet(context) ? 28.0 : 32.0,
    ),
    icon: Icon(
    Icons.check_circle,
    color: Colors.green,
      size: AppThemeResponsiveness.isSmallPhone(context) ? 40.0 :
      AppThemeResponsiveness.isMediumPhone(context) ? 48.0 :
      AppThemeResponsiveness.isLargePhone(context) ? 56.0 :
      AppThemeResponsiveness.isTablet(context) ? 64.0 : 72.0,
    ),
            title: Text(
              'Payment Successful!',
              style: AppThemeResponsiveness.getHeadingStyle(context).copyWith(
                color: Colors.green,
                fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 16.0 :
                AppThemeResponsiveness.isMediumPhone(context) ? 18.0 :
                AppThemeResponsiveness.isLargePhone(context) ? 20.0 :
                AppThemeResponsiveness.isTablet(context) ? 22.0 : 24.0,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your admission fee has been successfully paid using $provider.',
                  style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                    fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 12.0 :
                    AppThemeResponsiveness.isMediumPhone(context) ? 13.0 :
                    AppThemeResponsiveness.isLargePhone(context) ? 14.0 :
                    AppThemeResponsiveness.isTablet(context) ? 15.0 : 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppThemeResponsiveness.getMediumSpacing(context)),
                Container(
                  padding: EdgeInsets.all(
                    AppThemeResponsiveness.isSmallPhone(context) ? 12.0 :
                    AppThemeResponsiveness.isMediumPhone(context) ? 16.0 :
                    AppThemeResponsiveness.isLargePhone(context) ? 20.0 :
                    AppThemeResponsiveness.isTablet(context) ? 24.0 : 28.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
                    border: Border.all(
                      color: Colors.green.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transaction ID:',
                            style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
                              fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 10.0 :
                              AppThemeResponsiveness.isMediumPhone(context) ? 11.0 :
                              AppThemeResponsiveness.isLargePhone(context) ? 12.0 :
                              AppThemeResponsiveness.isTablet(context) ? 13.0 : 14.0,
                            ),
                          ),
                          Text(
                            'TXN${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                            style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 10.0 :
                              AppThemeResponsiveness.isMediumPhone(context) ? 11.0 :
                              AppThemeResponsiveness.isLargePhone(context) ? 12.0 :
                              AppThemeResponsiveness.isTablet(context) ? 13.0 : 14.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amount Paid:',
                            style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
                              fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 10.0 :
                              AppThemeResponsiveness.isMediumPhone(context) ? 11.0 :
                              AppThemeResponsiveness.isLargePhone(context) ? 12.0 :
                              AppThemeResponsiveness.isTablet(context) ? 13.0 : 14.0,
                            ),
                          ),
                          Text(
                            '₹ 5,000',
                            style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                              fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 12.0 :
                              AppThemeResponsiveness.isMediumPhone(context) ? 13.0 :
                              AppThemeResponsiveness.isLargePhone(context) ? 14.0 :
                              AppThemeResponsiveness.isTablet(context) ? 15.0 : 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date & Time:',
                            style: AppThemeResponsiveness.getCaptionTextStyle(context).copyWith(
                              fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 10.0 :
                              AppThemeResponsiveness.isMediumPhone(context) ? 11.0 :
                              AppThemeResponsiveness.isLargePhone(context) ? 12.0 :
                              AppThemeResponsiveness.isTablet(context) ? 13.0 : 14.0,
                            ),
                          ),
                          Text(
                            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                            style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 10.0 :
                              AppThemeResponsiveness.isMediumPhone(context) ? 11.0 :
                              AppThemeResponsiveness.isLargePhone(context) ? 12.0 :
                              AppThemeResponsiveness.isTablet(context) ? 13.0 : 14.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              Container(
                width: double.infinity,
                height: AppThemeResponsiveness.getButtonHeight(context) * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close success dialog
                    Navigator.of(context).pop(); // Go back to previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                    ),
                    elevation: AppThemeResponsiveness.getButtonElevation(context),
                  ),
                  child: Text(
                    'Continue',
                    style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                      fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 13.0 :
                      AppThemeResponsiveness.isMediumPhone(context) ? 14.0 :
                      AppThemeResponsiveness.isLargePhone(context) ? 15.0 :
                      AppThemeResponsiveness.isTablet(context) ? 16.0 : 17.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppThemeResponsiveness.getSmallSpacing(context)),
              Container(
                width: double.infinity,
                height: AppThemeResponsiveness.getButtonHeight(context) * 0.8,
                child: OutlinedButton(
                  onPressed: () {
                    _downloadReceipt();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.green,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppThemeResponsiveness.getButtonBorderRadius(context)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.download,
                        color: Colors.green,
                        size: AppThemeResponsiveness.getIconSize(context) * 0.8,
                      ),
                      SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
                      Text(
                        'Download Receipt',
                        style: AppThemeResponsiveness.getButtonTextStyle(context).copyWith(
                          color: Colors.green,
                          fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 13.0 :
                          AppThemeResponsiveness.isMediumPhone(context) ? 14.0 :
                          AppThemeResponsiveness.isLargePhone(context) ? 15.0 :
                          AppThemeResponsiveness.isTablet(context) ? 16.0 : 17.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      );
    });
  }

  void _downloadReceipt() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: AppThemeResponsiveness.getIconSize(context) * 0.8,
            ),
            SizedBox(width: AppThemeResponsiveness.getSmallSpacing(context)),
            Expanded(
              child: Text(
                'Payment receipt downloaded successfully!',
                style: AppThemeResponsiveness.getBodyTextStyle(context).copyWith(
                  color: Colors.white,
                  fontSize: AppThemeResponsiveness.isSmallPhone(context) ? 12.0 :
                  AppThemeResponsiveness.isMediumPhone(context) ? 13.0 :
                  AppThemeResponsiveness.isLargePhone(context) ? 14.0 :
                  AppThemeResponsiveness.isTablet(context) ? 15.0 : 16.0,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppThemeResponsiveness.getInputBorderRadius(context)),
        ),
        margin: EdgeInsets.all(
          AppThemeResponsiveness.isSmallPhone(context) ? 12.0 :
          AppThemeResponsiveness.isMediumPhone(context) ? 16.0 :
          AppThemeResponsiveness.isLargePhone(context) ? 20.0 :
          AppThemeResponsiveness.isTablet(context) ? 24.0 : 28.0,
        ),
      ),
    );
  }
}