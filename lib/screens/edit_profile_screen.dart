import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pairit/entity/user.dart';
import 'package:pairit/provider/user_provider.dart';
import 'package:pairit/services/api_service.dart';
import 'package:provider/provider.dart';

import '../states.dart';
import '../widgets.dart';
import 'main_screen.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ApiService _service = ApiService();

  User _currentUser = User();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phone1Controller = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController link1Controller = TextEditingController();
  TextEditingController link2Controller = TextEditingController();

  bool _secondNumberVisible = false;

  File _companyLogo;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserProvider>(context);
    _currentUser = userState.user;
    AppStates _states = AppStates(context);

    firstNameController.text = _currentUser.firstName;
    lastNameController.text = _currentUser.lastName;
    emailController.text = _currentUser.email;
    phone1Controller.text = _currentUser.phoneNumber1;
    phone2Controller.text = _currentUser.phoneNumber2;
    companyController.text = _currentUser.company;
    positionController.text = _currentUser.position;
    addressController.text = _currentUser.address;
    link1Controller.text = _currentUser.socialLink1;
    link2Controller.text = _currentUser.socialLink2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'USER PROFILE',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        elevation: 6.0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: CirclePairAvatar(
                  radius: 75,
                  width: 5,
                  child: _currentUser.profileImage != null &&
                      _currentUser.profileImage.isNotEmpty
                      ? Image.network(_currentUser.profileImage)
                      : Image.asset(
                      'assets/images/def_avatar.png'),
                  changeable: true,
                  onAdd: () {
                    print('tap');
                    getProfileImage(userState);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 12,
                  left: 160,
                ),
                child: Column(
                  children: [
                    PairItTextField(
                      title: "First Name",
                      controller: firstNameController,
                    ),
                    PairItTextField(
                      title: "Last Name",
                      controller: lastNameController,
                    ),
                  ],
                ),
              )
            ],
          ),
          PairItTextField(
            title: "Email",
            controller: emailController,
            readOnly: true,
          ),
          PairItTextField(
            title: "Phone Number",
            controller: phone1Controller,
          ),
          _secondNumberVisible
              ? PairItTextField(
                  title: "Phone Number 2",
                  controller: phone2Controller,
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      _secondNumberVisible = !_secondNumberVisible;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: accentColor,
                      radius: 20,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
          SizedBox(
            height: 24,
          ),
          PairItTextField(
            title: "Company Name",
            controller: companyController,
          ),
          PairItTextField(
            title: "Position",
            controller: positionController,
          ),
          PairItTextField(
            title: "Address",
            controller: addressController,
          ),
          Container(
            padding: EdgeInsets.only(top: 12),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                getCompanyLogo(userState);
              },
              child: _currentUser.companyLogo != null &&
                  _currentUser.companyLogo.isNotEmpty
                  ? Image.network(_currentUser.companyLogo)
                  : Text(
                '+ Add Company Logo',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold),
              )
            ),
          ),
          SizedBox(
            height: 14,
          ),
          PairItTextField(
            title: "Facebook Link",
            controller: link1Controller,
          ),
          PairItTextField(
            title: "Instagram Link",
            controller: link1Controller,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: _states.width / 2 - 96, vertical: 16),
            child: AccentButton(
              label: 'Save',
              onPressed: () {
                User user = User(
                  firstName: firstNameController.text != null ||
                          firstNameController.text.trim() != ""
                      ? firstNameController.text
                      : _currentUser.firstName,
                  lastName: lastNameController.text != null ||
                          lastNameController.text.trim() != ""
                      ? lastNameController.text
                      : _currentUser.lastName,
                  phoneNumber1: phone1Controller.text != null ||
                          phone1Controller.text.trim() != ""
                      ? phone1Controller.text
                      : _currentUser.phoneNumber1,
                  phoneNumber2: phone2Controller.text != null ||
                          phone2Controller.text.trim() != ""
                      ? phone2Controller.text
                      : _currentUser.phoneNumber2,
                  company: companyController.text != null ||
                          companyController.text.trim() != ""
                      ? companyController.text
                      : _currentUser.company,
                  position: positionController.text != null ||
                          positionController.text.trim() != ""
                      ? positionController.text
                      : _currentUser.position,
                  address: addressController.text != null ||
                          addressController.text.trim() != ""
                      ? addressController.text
                      : _currentUser.address,
                  socialLink1: link1Controller.text != null ||
                          link1Controller.text.trim() != ""
                      ? link1Controller.text
                      : _currentUser.socialLink1,
                  socialLink2: link2Controller.text != null ||
                          link2Controller.text.trim() != ""
                      ? link2Controller.text
                      : _currentUser.socialLink2,
                );

                _service.updateUser(user).then((success) {
                  if(success) {
                    _service.getCurrentUser().then((user) {
                      userState.user = user;
                      print(user.profileImage);
                      print('saved');
                    });
                  }
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => MainActivityScreen()));
              },
            ),
          )
        ],
      ),
    );
  }

  uploadCurrentUser() {
    _service.getCurrentUser().then((user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  Future getProfileImage(UserProvider userProvider) async {
    picker.getImage(source: ImageSource.gallery).then((pickedFile) {
      _service.uploadProfileImage(File(pickedFile.path)).then((value) {
        _service.getCurrentUser().then((user) {
          userProvider.user = user;

          print(userProvider.user.profileImage);
          setState(() {
            _currentUser = userProvider.user;
          });
        });
        print('profile page saved');
      });
    });
  }

  Future getCompanyLogo(UserProvider userProvider) async {
    /*final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _companyLogo = File(pickedFile.path);
    });*/

    picker.getImage(source: ImageSource.gallery).then((pickedFile) {
      _service.uploadCompanyLogo(File(pickedFile.path)).then((value) {
        _service.getCurrentUser().then((user) {
          userProvider.user = user;

          print(userProvider.user.companyLogo);
          setState(() {
            _currentUser = userProvider.user;
          });
        });
        print('profile page saved');
      });
    });
  }
}
