import 'package:bettymeals/utils/constants.dart';
import 'package:bettymeals/utils/device_utils.dart';
import 'package:bettymeals/utils/enums.dart';
import 'package:bettymeals/utils/noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../routes.dart';
import '../../cubit/user_cubit.dart' as cs;
import '../../utils/colours.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String gender = 'None';
  @override
  void initState() {
    super.initState();
    // context.read<FoodCubit>().getAllMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<cs.UserCubit, cs.UserState>(
        listener: (context, state) {
          if (state is cs.UserLoading) {
            Notificatn.showLoading(context, title: 'Loading');
          }
          if (state is cs.UserError) {
            Notificatn.showErrorModal(context, errorMsg: state.msg);
          }
          if (state is cs.UserSuccess) {
            Notificatn.hideLoading();
            Navigator.pushNamed(context, Routes.setPassword,
                arguments: [state.userId, state.email]);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: CommonUtils.sh(context, s: 0.3),
                padding: EdgeInsets.only(
                    top: CommonUtils.xlpadding,
                    left: CommonUtils.padding,
                    right: CommonUtils.padding),
                decoration: BoxDecoration(
                  color: AppColour(context).primaryColour,
                  image: DecorationImage(
                      image: AssetImage('assets/images/6.png'),
                      fit: BoxFit.cover,
                      opacity: 0.1),
                  borderRadius: BorderRadius.vertical(
                    top: const Radius.circular(20),
                    bottom: Radius.elliptical(CommonUtils.sw(context), 40.0),
                  ),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    textTheme: Theme.of(context).textTheme.apply(
                        displayColor: Colors.white, bodyColor: Colors.white),
                  ),
                  child: Container(
                    child: Image.asset(
                      'assets/images/5.png',
                      width: CommonUtils.sw(context, s: 0.6),
                      height: CommonUtils.sh(context, s: 0.2),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(CommonUtils.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.app_registration_outlined,
                          size: 25,
                        ),
                        CustomLayout.mPad.sizedBoxW,
                        Expanded(
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: AppColour(context)
                                        .primaryColour
                                        .withOpacity(0.7),
                                    fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    CustomLayout.sPad.sizedBoxH,
                    Text('We need to create a profile for you',
                        style: Theme.of(context).textTheme.bodyLarge),
                    CustomLayout.xlPad.sizedBoxH,
                    Text('Enter your email',
                        style: Theme.of(context).textTheme.titleMedium),
                    // CustomLayout.sPad.sizedBoxH,
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),

                    CustomLayout.lPad.sizedBoxH,

                    CustomLayout.xlPad.sizedBoxH,
                    ElevatedButton(
                      onPressed: () {
                        DeviceUtils.hideKeyboard(context);
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<cs.UserCubit>()
                              .userRegistration(_emailController.text);
                        }
                      },
                      child: Center(child: const Text('Continue')),
                    ),
                  ],
                ),
              ),
              CustomLayout.xlPad.sizedBoxH,
              Center(
                child: SizedBox(
                  height: CommonUtils.sh(context, s: 0.4),
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.loginScreen),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have a profile?',
                        children: [
                          TextSpan(
                            text: ' Login Now',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: AppColour(context).primaryColour,
                                    ),
                          )
                        ],
                        style: Theme.of(context).textTheme.bodyMedium!,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
