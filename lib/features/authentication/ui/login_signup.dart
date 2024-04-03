import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnpconnect/constants/appbar.dart';
import 'package:tnpconnect/constants/user.dart';
import 'package:tnpconnect/features/authentication/bloc/auth_bloc.dart';
import 'package:tnpconnect/features/authentication/ui/login.dart';
import 'package:tnpconnect/features/bottombar/bloc/bottombar_bloc.dart';
import 'package:tnpconnect/features/chatbot/bloc/chatbot_bloc.dart';
import 'package:tnpconnect/features/chatbot/ui/chatbotpage.dart';
import 'package:tnpconnect/features/companyPosting/bloc/company_postings_bloc.dart';
import 'package:tnpconnect/features/companyPosting/ui/companyPostingPage.dart';
import 'package:tnpconnect/features/documentUpload/bloc/document_upload_bloc.dart';
import 'package:tnpconnect/features/documentUpload/ui/documentUploadPage.dart';
import 'package:tnpconnect/features/profile/bloc/profile_bloc.dart';
import 'package:tnpconnect/features/profile/ui/profilePage.dart';

class CheckLoginSignUp extends StatelessWidget {
  const CheckLoginSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthStates>(
      builder: (context, state) {
        log("Auth State = $state");
        if (state is LoginSuccessState || state is SignUpSuccessState) {
          return Scaffold(
            appBar: customAppBar(() => {
                  BlocProvider.of<AuthBloc>(context).add(LogOutEvent()),
                }),
            body: BlocBuilder<BottomBarBloc, BottomBarStates>(builder: (context, state) {
              if (state is BottomBarChatbotState) {
                return BlocProvider(
                  create: (context) => ChatbotBloc(),
                  child: const ChatBotPage(),
                );
              } else if (state is BottomBarProfileState) {
                return BlocProvider(
                  create: (context) => ProfileBloc()..add(GetProfileEvent(User.instance.enrollmentNumber)),
                  child: const ProfilePage(),
                );
              } else if (state is BottomBarDocumentsState) {
                return BlocProvider(
                  create: (context) => DocumentUploadBloc(),
                  child: const DocumentsUploadPage(),
                );
              } else if (state is BottomBarCompanyPostingsState) {
                return BlocProvider(
                  create: (context) => CompanyPostingsBloc()..add(GetCompanyPostingEvent()),
                  child: const CompanyPostingsPage(),
                );
              }
              return const Placeholder();
            }),
            bottomNavigationBar: Container(
              margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              child: CurvedNavigationBar(
                index: 2,
                height: MediaQuery.of(context).size.height * 0.07,
                items: <Widget>[
                  Icon(
                    Icons.chat,
                    size: 30,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  Icon(
                    Icons.work,
                    size: 30,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  Icon(
                    Icons.document_scanner_outlined,
                    size: 30,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ],
                color: Colors.blue.withOpacity(0.2),
                buttonBackgroundColor: Colors.blue.withOpacity(0.6),
                backgroundColor: Colors.transparent,
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 400),
                onTap: (index) {
                  BottomBarEvents? event;
                  switch (index) {
                    case 0:
                      event = BottomBarChatbotEvent();
                      break;
                    case 1:
                      event = BottomBarProfileEvent();
                      break;
                    case 2:
                      event = BottomBarCompanyPostingsEvent();
                      break;
                    case 3:
                      event = BottomBarDocumentsEvent();
                      break;
                  }
                  if (event != null) {
                    BlocProvider.of<BottomBarBloc>(context).add(event);
                  }
                },
                letIndexChange: (index) => true,
              ),
            ),
          );
        } else {
          return const LoginPage();
        }
      },
      listener: (context, state) {},
    );
  }
}
