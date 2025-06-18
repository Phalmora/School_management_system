import 'package:flutter/material.dart';
import 'package:school/customWidgets/appBar.dart';
import 'package:school/customWidgets/theme.dart';

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
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: AppTheme.getMaxWidth(context),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.getDashboardHorizontalPadding(context),
                    vertical: AppTheme.getDashboardVerticalPadding(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: AppTheme.getLargeSpacing(context)),

                      // Title Section with responsive spacing and text
                      _buildTitleSection(),

                      SizedBox(height: AppTheme.getLargeSpacing(context)),

                      // Payment Options Card with responsive layout
                      _buildPaymentOptionsCard(),

                      SizedBox(height: AppTheme.getExtraLargeSpacing(context)),

                      // Amount Display Card with responsive design
                      _buildAmountDisplayCard(),

                      SizedBox(height: AppTheme.getExtraLargeSpacing(context)),

                      // Navigation Buttons with responsive sizing
                      _buildNavigationButtons(),

                      SizedBox(height: AppTheme.getDefaultSpacing(context)),
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
          style: AppTheme.getFontStyle(context).copyWith(
            fontSize: AppTheme.isSmallPhone(context) ? 22.0 :
            AppTheme.isMediumPhone(context) ? 26.0 :
            AppTheme.isLargePhone(context) ? 28.0 :
            AppTheme.isTablet(context) ? 32.0 : 36.0,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppTheme.getSmallSpacing(context)),
        Text(
          'Select your preferred payment option',
          style: AppTheme.getSplashSubtitleStyle(context).copyWith(
            fontSize: AppTheme.isSmallPhone(context) ? 12.0 :
            AppTheme.isMediumPhone(context) ? 14.0 :
            AppTheme.isLargePhone(context) ? 15.0 :
            AppTheme.isTablet(context) ? 16.0 : 18.0,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPaymentOptionsCard() {
    return Card(
      elevation: AppTheme.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
      ),
      child: Container(
        padding: EdgeInsets.all(
          AppTheme.isSmallPhone(context) ? 16.0 :
          AppTheme.isMediumPhone(context) ? 20.0 :
          AppTheme.isLargePhone(context) ? 24.0 :
          AppTheme.isTablet(context) ? 28.0 : 32.0,
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

            SizedBox(height: AppTheme.getMediumSpacing(context)),

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
      elevation: AppTheme.getCardElevation(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
      ),
      color: AppTheme.white.withOpacity(0.1),
      child: Container(
        padding: EdgeInsets.all(
          AppTheme.isSmallPhone(context) ? 20.0 :
          AppTheme.isMediumPhone(context) ? 24.0 :
          AppTheme.isLargePhone(context) ? 28.0 :
          AppTheme.isTablet(context) ? 32.0 : 36.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
          border: Border.all(
            color: AppTheme.white.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            Text(
              'Total Amount',
              style: AppTheme.getSubHeadingStyle(context).copyWith(
                color: AppTheme.white70,
                fontSize: AppTheme.isSmallPhone(context) ? 12.0 :
                AppTheme.isMediumPhone(context) ? 14.0 :
                AppTheme.isLargePhone(context) ? 15.0 :
                AppTheme.isTablet(context) ? 16.0 : 18.0,
              ),
            ),
            SizedBox(height: AppTheme.getSmallSpacing(context)),
            Text(
              '₹ 5,000',
              style: AppTheme.getFontStyle(context).copyWith(
                fontSize: AppTheme.isSmallPhone(context) ? 24.0 :
                AppTheme.isMediumPhone(context) ? 28.0 :
                AppTheme.isLargePhone(context) ? 32.0 :
                AppTheme.isTablet(context) ? 36.0 : 40.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: AppTheme.getSmallSpacing(context)),
            Text(
              'Admission Fee',
              style: AppTheme.getCaptionTextStyle(context).copyWith(
                color: AppTheme.white.withOpacity(0.8),
                fontSize: AppTheme.isSmallPhone(context) ? 10.0 :
                AppTheme.isMediumPhone(context) ? 11.0 :
                AppTheme.isLargePhone(context) ? 12.0 :
                AppTheme.isTablet(context) ? 13.0 : 14.0,
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
    double containerPadding = AppTheme.isSmallPhone(context) ? 12.0 :
    AppTheme.isMediumPhone(context) ? 16.0 :
    AppTheme.isLargePhone(context) ? 18.0 :
    AppTheme.isTablet(context) ? 20.0 : 22.0;

    double iconContainerPadding = AppTheme.isSmallPhone(context) ? 8.0 :
    AppTheme.isMediumPhone(context) ? 10.0 :
    AppTheme.isLargePhone(context) ? 12.0 :
    AppTheme.isTablet(context) ? 14.0 : 16.0;

    double iconSize = AppTheme.isSmallPhone(context) ? 20.0 :
    AppTheme.isMediumPhone(context) ? 22.0 :
    AppTheme.isLargePhone(context) ? 24.0 :
    AppTheme.isTablet(context) ? 28.0 : 32.0;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = paymentMethod;
        });
        onTap();
      },
      child: AnimatedContainer(
        duration: AppTheme.buttonAnimationDuration,
        padding: EdgeInsets.all(containerPadding),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.blue50.withOpacity(0.3)
              : AppTheme.greylight.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          border: Border.all(
            color: isSelected
                ? AppTheme.blue600
                : Colors.grey.withOpacity(0.3),
            width: isSelected ? AppTheme.getFocusedBorderWidth(context) : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppTheme.blue600.withOpacity(0.1),
              blurRadius: AppTheme.isMobile(context) ? 6 : 8,
              spreadRadius: AppTheme.isMobile(context) ? 1 : 2,
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
                    ? AppTheme.blue600.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppTheme.blue600 : Colors.grey[600],
                size: iconSize,
              ),
            ),
            SizedBox(width: AppTheme.getDefaultSpacing(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.getHeadingStyle(context).copyWith(
                      color: isSelected ? AppTheme.blue600 : Colors.grey[800],
                      fontSize: AppTheme.isSmallPhone(context) ? 14.0 :
                      AppTheme.isMediumPhone(context) ? 15.0 :
                      AppTheme.isLargePhone(context) ? 16.0 :
                      AppTheme.isTablet(context) ? 18.0 : 20.0,
                    ),
                  ),
                  SizedBox(height: AppTheme.getSmallSpacing(context) / 2),
                  Text(
                    subtitle,
                    style: AppTheme.getSubHeadingStyle(context).copyWith(
                      fontSize: AppTheme.isSmallPhone(context) ? 11.0 :
                      AppTheme.isMediumPhone(context) ? 12.0 :
                      AppTheme.isLargePhone(context) ? 13.0 :
                      AppTheme.isTablet(context) ? 14.0 : 15.0,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? AppTheme.blue600 : Colors.grey[400],
              size: iconSize * 0.9,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    // Responsive button layout - stack vertically on small phones
    if (AppTheme.isSmallPhone(context)) {
      return Column(
        children: [
          Container(
            width: double.infinity,
            height: AppTheme.getButtonHeight(context),
            child: ElevatedButton(
              onPressed: selectedPaymentMethod.isEmpty ? null : () {
                if (selectedPaymentMethod == 'UPI') {
                  _handleUPIPayment();
                } else if (selectedPaymentMethod == 'CARD') {
                  _handleCardPayment();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.blue600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                ),
                elevation: AppTheme.getButtonElevation(context),
              ),
              child: Text(
                'Proceed to Pay',
                style: AppTheme.getButtonTextStyle(context).copyWith(
                  fontSize: AppTheme.isSmallPhone(context) ? 14.0 : 16.0,
                ),
              ),
            ),
          ),
          SizedBox(height: AppTheme.getMediumSpacing(context)),
          Container(
            width: double.infinity,
            height: AppTheme.getButtonHeight(context),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                ),
                elevation: AppTheme.getButtonElevation(context),
              ),
              child: Text(
                'Back',
                style: AppTheme.getButtonTextStyle(context).copyWith(
                  color: Colors.grey[700],
                  fontSize: AppTheme.isSmallPhone(context) ? 14.0 : 16.0,
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
            height: AppTheme.getButtonHeight(context),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                ),
                elevation: AppTheme.getButtonElevation(context),
              ),
              child: Text(
                'Back',
                style: AppTheme.getButtonTextStyle(context).copyWith(
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: AppTheme.getMediumSpacing(context)),
        Expanded(
          child: Container(
            height: AppTheme.getButtonHeight(context),
            child: ElevatedButton(
              onPressed: selectedPaymentMethod.isEmpty ? null : () {
                if (selectedPaymentMethod == 'UPI') {
                  _handleUPIPayment();
                } else if (selectedPaymentMethod == 'CARD') {
                  _handleCardPayment();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.blue600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                ),
                elevation: AppTheme.getButtonElevation(context),
              ),
              child: Text(
                'Proceed to Pay',
                style: AppTheme.getButtonTextStyle(context),
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
        color: AppTheme.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.getCardBorderRadius(context)),
        ),
      ),
      padding: EdgeInsets.all(
        AppTheme.isSmallPhone(context) ? 16.0 :
        AppTheme.isMediumPhone(context) ? 20.0 :
        AppTheme.isLargePhone(context) ? 24.0 :
        AppTheme.isTablet(context) ? 28.0 : 32.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar with responsive width
          Container(
            width: AppTheme.isSmallPhone(context) ? 30 :
            AppTheme.isMobile(context) ? 40 : 50,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.greydark,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: AppTheme.getDefaultSpacing(context)),
          Text(
            'Choose UPI App',
            style: AppTheme.getHeadingStyle(context).copyWith(
              fontSize: AppTheme.isSmallPhone(context) ? 16.0 :
              AppTheme.isMediumPhone(context) ? 18.0 :
              AppTheme.isLargePhone(context) ? 20.0 :
              AppTheme.isTablet(context) ? 22.0 : 24.0,
            ),
          ),
          SizedBox(height: AppTheme.getDefaultSpacing(context)),
          _buildUPIOption('Google Pay', Icons.account_balance_wallet, AppTheme.blue600),
          _buildUPIOption('PhonePe', Icons.phone_android, AppTheme.primaryPurple),
          _buildUPIOption('Paytm', Icons.account_balance, AppTheme.primaryBlue),
          _buildUPIOption('Other UPI Apps', Icons.more_horiz, Colors.grey),
          SizedBox(height: AppTheme.getDefaultSpacing(context)),
        ],
      ),
    );
  }

  Widget _buildUPIOption(String name, IconData icon, Color color) {
    double iconRadius = AppTheme.isSmallPhone(context) ? 18.0 :
    AppTheme.isMediumPhone(context) ? 20.0 :
    AppTheme.isLargePhone(context) ? 22.0 :
    AppTheme.isTablet(context) ? 26.0 : 30.0;

    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.getSmallSpacing(context)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppTheme.isSmallPhone(context) ? 12.0 :
          AppTheme.isMediumPhone(context) ? 16.0 :
          AppTheme.isLargePhone(context) ? 20.0 :
          AppTheme.isTablet(context) ? 24.0 : 28.0,
          vertical: AppTheme.getSmallSpacing(context),
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
          style: AppTheme.getBodyTextStyle(context).copyWith(
            fontWeight: FontWeight.w500,
            fontSize: AppTheme.isSmallPhone(context) ? 12.0 :
            AppTheme.isMediumPhone(context) ? 13.0 :
            AppTheme.isLargePhone(context) ? 14.0 :
            AppTheme.isTablet(context) ? 15.0 : 16.0,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: AppTheme.getIconSize(context) * 0.6,
          color: Colors.grey,
        ),
        onTap: () {
          Navigator.pop(context);
          _processPayment('UPI', name);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        ),
      ),
    );
  }

  Widget _buildCardBottomSheet() {
    // Responsive height calculation
    double sheetHeight = AppTheme.isSmallPhone(context)
        ? AppTheme.getScreenHeight(context) * 0.8
        : AppTheme.isMobile(context)
        ? AppTheme.getScreenHeight(context) * 0.7
        : AppTheme.getScreenHeight(context) * 0.6;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.getCardBorderRadius(context)),
        ),
      ),
      padding: EdgeInsets.all(
        AppTheme.isSmallPhone(context) ? 16.0 :
        AppTheme.isMediumPhone(context) ? 20.0 :
        AppTheme.isLargePhone(context) ? 24.0 :
        AppTheme.isTablet(context) ? 28.0 : 32.0,
      ),
      height: sheetHeight,
      child: Column(
        children: [
          // Handle bar
          Container(
            width: AppTheme.isSmallPhone(context) ? 30 :
            AppTheme.isMobile(context) ? 40 : 50,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.greydark,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: AppTheme.getDefaultSpacing(context)),
          Text(
            'Card Details',
            style: AppTheme.getHeadingStyle(context).copyWith(
              fontSize: AppTheme.isSmallPhone(context) ? 16.0 :
              AppTheme.isMediumPhone(context) ? 18.0 :
              AppTheme.isLargePhone(context) ? 20.0 :
              AppTheme.isTablet(context) ? 22.0 : 24.0,
            ),
          ),
          SizedBox(height: AppTheme.getExtraLargeSpacing(context)),

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

                  SizedBox(height: AppTheme.getMediumSpacing(context)),

                  // Expiry and CVV Row - Stack on small phones
                  AppTheme.isSmallPhone(context)
                      ? Column(
                    children: [
                      _buildCardInputField(
                        label: 'Expiry Date',
                        hint: 'MM/YY',
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: AppTheme.getMediumSpacing(context)),
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
                      SizedBox(width: AppTheme.getMediumSpacing(context)),
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

                  SizedBox(height: AppTheme.getMediumSpacing(context)),

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

          SizedBox(height: AppTheme.getDefaultSpacing(context)),

          // Pay Button
          Container(
            width: double.infinity,
            height: AppTheme.getButtonHeight(context),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _processPayment('Card', 'Credit/Debit Card');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.blue600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                ),
                elevation: AppTheme.getButtonElevation(context),
              ),
              child: Text(
                'Pay ₹5,000',
                style: AppTheme.getButtonTextStyle(context),
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
      style: AppTheme.getBodyTextStyle(context),
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTheme.getSubHeadingStyle(context),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
          borderSide: BorderSide(
            color: AppTheme.blue600,
            width: AppTheme.getFocusedBorderWidth(context),
          ),
        ),
        prefixIcon: icon != null ? Icon(
          icon,
          size: AppTheme.getIconSize(context),
        ) : null,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppTheme.isSmallPhone(context) ? 12.0 :
          AppTheme.isMediumPhone(context) ? 16.0 :
          AppTheme.isLargePhone(context) ? 20.0 :
          AppTheme.isTablet(context) ? 24.0 : 28.0,
          vertical: AppTheme.getMediumSpacing(context),
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
          borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
        ),
        contentPadding: EdgeInsets.all(
          AppTheme.isSmallPhone(context) ? 16.0 :
          AppTheme.isMediumPhone(context) ? 20.0 :
          AppTheme.isLargePhone(context) ? 24.0 :
          AppTheme.isTablet(context) ? 28.0 : 32.0,
        ),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: AppTheme.isSmallPhone(context) ? 20.0 : 24.0,
              height: AppTheme.isSmallPhone(context) ? 20.0 : 24.0,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.blue600),
                strokeWidth: 2.5,
              ),
            ),
            SizedBox(width: AppTheme.getDefaultSpacing(context)),
            Flexible(
              child: Text(
                'Processing payment...',
                style: AppTheme.getBodyTextStyle(context),
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
          borderRadius: BorderRadius.circular(AppTheme.getCardBorderRadius(context)),
    ),
    contentPadding: EdgeInsets.all(
    AppTheme.isSmallPhone(context) ? 16.0 :
    AppTheme.isMediumPhone(context) ? 20.0 :
    AppTheme.isLargePhone(context) ? 24.0 :
    AppTheme.isTablet(context) ? 28.0 : 32.0,
    ),
    icon: Icon(
    Icons.check_circle,
    color: Colors.green,
      size: AppTheme.isSmallPhone(context) ? 40.0 :
      AppTheme.isMediumPhone(context) ? 48.0 :
      AppTheme.isLargePhone(context) ? 56.0 :
      AppTheme.isTablet(context) ? 64.0 : 72.0,
    ),
            title: Text(
              'Payment Successful!',
              style: AppTheme.getHeadingStyle(context).copyWith(
                color: Colors.green,
                fontSize: AppTheme.isSmallPhone(context) ? 16.0 :
                AppTheme.isMediumPhone(context) ? 18.0 :
                AppTheme.isLargePhone(context) ? 20.0 :
                AppTheme.isTablet(context) ? 22.0 : 24.0,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your admission fee has been successfully paid using $provider.',
                  style: AppTheme.getBodyTextStyle(context).copyWith(
                    fontSize: AppTheme.isSmallPhone(context) ? 12.0 :
                    AppTheme.isMediumPhone(context) ? 13.0 :
                    AppTheme.isLargePhone(context) ? 14.0 :
                    AppTheme.isTablet(context) ? 15.0 : 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppTheme.getMediumSpacing(context)),
                Container(
                  padding: EdgeInsets.all(
                    AppTheme.isSmallPhone(context) ? 12.0 :
                    AppTheme.isMediumPhone(context) ? 16.0 :
                    AppTheme.isLargePhone(context) ? 20.0 :
                    AppTheme.isTablet(context) ? 24.0 : 28.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
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
                            style: AppTheme.getCaptionTextStyle(context).copyWith(
                              fontSize: AppTheme.isSmallPhone(context) ? 10.0 :
                              AppTheme.isMediumPhone(context) ? 11.0 :
                              AppTheme.isLargePhone(context) ? 12.0 :
                              AppTheme.isTablet(context) ? 13.0 : 14.0,
                            ),
                          ),
                          Text(
                            'TXN${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                            style: AppTheme.getBodyTextStyle(context).copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: AppTheme.isSmallPhone(context) ? 10.0 :
                              AppTheme.isMediumPhone(context) ? 11.0 :
                              AppTheme.isLargePhone(context) ? 12.0 :
                              AppTheme.isTablet(context) ? 13.0 : 14.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppTheme.getSmallSpacing(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amount Paid:',
                            style: AppTheme.getCaptionTextStyle(context).copyWith(
                              fontSize: AppTheme.isSmallPhone(context) ? 10.0 :
                              AppTheme.isMediumPhone(context) ? 11.0 :
                              AppTheme.isLargePhone(context) ? 12.0 :
                              AppTheme.isTablet(context) ? 13.0 : 14.0,
                            ),
                          ),
                          Text(
                            '₹ 5,000',
                            style: AppTheme.getBodyTextStyle(context).copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                              fontSize: AppTheme.isSmallPhone(context) ? 12.0 :
                              AppTheme.isMediumPhone(context) ? 13.0 :
                              AppTheme.isLargePhone(context) ? 14.0 :
                              AppTheme.isTablet(context) ? 15.0 : 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppTheme.getSmallSpacing(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date & Time:',
                            style: AppTheme.getCaptionTextStyle(context).copyWith(
                              fontSize: AppTheme.isSmallPhone(context) ? 10.0 :
                              AppTheme.isMediumPhone(context) ? 11.0 :
                              AppTheme.isLargePhone(context) ? 12.0 :
                              AppTheme.isTablet(context) ? 13.0 : 14.0,
                            ),
                          ),
                          Text(
                            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                            style: AppTheme.getBodyTextStyle(context).copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: AppTheme.isSmallPhone(context) ? 10.0 :
                              AppTheme.isMediumPhone(context) ? 11.0 :
                              AppTheme.isLargePhone(context) ? 12.0 :
                              AppTheme.isTablet(context) ? 13.0 : 14.0,
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
                height: AppTheme.getButtonHeight(context) * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close success dialog
                    Navigator.of(context).pop(); // Go back to previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                    ),
                    elevation: AppTheme.getButtonElevation(context),
                  ),
                  child: Text(
                    'Continue',
                    style: AppTheme.getButtonTextStyle(context).copyWith(
                      fontSize: AppTheme.isSmallPhone(context) ? 13.0 :
                      AppTheme.isMediumPhone(context) ? 14.0 :
                      AppTheme.isLargePhone(context) ? 15.0 :
                      AppTheme.isTablet(context) ? 16.0 : 17.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppTheme.getSmallSpacing(context)),
              Container(
                width: double.infinity,
                height: AppTheme.getButtonHeight(context) * 0.8,
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
                      borderRadius: BorderRadius.circular(AppTheme.getButtonBorderRadius(context)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.download,
                        color: Colors.green,
                        size: AppTheme.getIconSize(context) * 0.8,
                      ),
                      SizedBox(width: AppTheme.getSmallSpacing(context)),
                      Text(
                        'Download Receipt',
                        style: AppTheme.getButtonTextStyle(context).copyWith(
                          color: Colors.green,
                          fontSize: AppTheme.isSmallPhone(context) ? 13.0 :
                          AppTheme.isMediumPhone(context) ? 14.0 :
                          AppTheme.isLargePhone(context) ? 15.0 :
                          AppTheme.isTablet(context) ? 16.0 : 17.0,
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
    // Show a simple snackbar for receipt download simulation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: AppTheme.getIconSize(context) * 0.8,
            ),
            SizedBox(width: AppTheme.getSmallSpacing(context)),
            Expanded(
              child: Text(
                'Payment receipt downloaded successfully!',
                style: AppTheme.getBodyTextStyle(context).copyWith(
                  color: Colors.white,
                  fontSize: AppTheme.isSmallPhone(context) ? 12.0 :
                  AppTheme.isMediumPhone(context) ? 13.0 :
                  AppTheme.isLargePhone(context) ? 14.0 :
                  AppTheme.isTablet(context) ? 15.0 : 16.0,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.getInputBorderRadius(context)),
        ),
        margin: EdgeInsets.all(
          AppTheme.isSmallPhone(context) ? 12.0 :
          AppTheme.isMediumPhone(context) ? 16.0 :
          AppTheme.isLargePhone(context) ? 20.0 :
          AppTheme.isTablet(context) ? 24.0 : 28.0,
        ),
      ),
    );
  }
}