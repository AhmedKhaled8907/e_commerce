import 'package:e_commerce/consts/assets.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/providers/theme_provider.dart';
import 'package:e_commerce/providers/user_provider.dart';
import 'package:e_commerce/screens/auth/login/screens/login_screen.dart';
import 'package:e_commerce/screens/inner_screen/loading_manager.dart';
import 'package:e_commerce/screens/inner_screen/order/orders_screen.dart';
import 'package:e_commerce/screens/profile/viewed_recently_screen.dart';
import 'package:e_commerce/screens/profile/wishlist_screen.dart';
import 'package:e_commerce/services/my_app_services.dart';
import 'package:e_commerce/widgets/app_name_text.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  UserModel? userModel;

  Future<void> fetchUserData() async {
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.getUserData();
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    fetchUserData();
    super.initState();
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      await Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: buildAppBar(context),
      body: LoadingManager(
        isLoading: isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: user == null ? true : false,
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: TitleText(
                      label: 'Please Login to have the ultimate access.',
                      maxLines: 2,
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                user == null
                    ? const SizedBox.shrink()
                    : Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).cardColor,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.background,
                                width: 3,
                              ),
                              image: const DecorationImage(
                                image: AssetImage(
                                  Assets.imagesProfilePicture,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleText(
                                label: userModel!.userName,
                              ),
                              SubtitleText(label: userModel!.userEmail),
                            ],
                          ),
                        ],
                      ),
                const SizedBox(height: 16),
                const TitleText(label: 'General'),
                const SizedBox(height: 16),
                user == null
                    ? const SizedBox.shrink()
                    : CustomListTile(
                        imagePath: Assets.imagesBagOrderSvg,
                        title: 'All Orders',
                        onTap: () async {
                          await Navigator.of(context)
                              .pushNamed(OrdersScreen.routeName);
                        },
                      ),
                user == null
                    ? const SizedBox.shrink()
                    : CustomListTile(
                        imagePath: Assets.imagesBagWishlistSvg,
                        title: 'Wishlist',
                        onTap: () async {
                          await Navigator.of(context)
                              .pushNamed(WishlistScreen.routeName);
                        },
                      ),
                CustomListTile(
                  imagePath: Assets.imagesProfileRecent,
                  title: 'Viewed Recently',
                  onTap: () async {
                    await Navigator.of(context)
                        .pushNamed(ViewedRecently.routeName);
                  },
                ),
                CustomListTile(
                  imagePath: Assets.imagesProfileAddress,
                  title: 'Address',
                  onTap: () {},
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(thickness: 0.75),
                ),
                const TitleText(label: 'Settings'),
                const SizedBox(height: 16),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: Image.asset(
                    Assets.imagesProfileTheme,
                    height: 45,
                    fit: BoxFit.fill,
                  ),
                  title: TitleText(
                    label: themeProvider.getIsDarkTheme
                        ? 'Dark Mode'
                        : 'Light Mode',
                  ),
                  value: themeProvider.getIsDarkTheme,
                  onChanged: (value) {
                    themeProvider.setDarkTheme(themeValue: value);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(thickness: 0.75),
                ),
                const TitleText(label: 'Others'),
                const SizedBox(height: 16),
                CustomListTile(
                  imagePath: Assets.imagesProfilePrivacy,
                  title: 'Privacy & Policy',
                  onTap: () {},
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: user == null
                          ? Colors.blueAccent.shade700
                          : Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 12,
                      ),
                    ),
                    icon: Icon(
                      user == null ? Icons.login : Icons.logout,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      if (user == null) {
                        await Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      } else {
                        await MyAppServices.showErrorOrWarningDialog(
                          context: context,
                          subtitle: 'Are you Sure',
                          onPressed: () async {
                            await signOutUser();
                          },
                        );
                      }
                    },
                    label: Text(
                      user == null ? 'Login' : 'Logout',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Image.asset(Assets.imagesBagShoppingCart),
      ),
      title: const AppNameText(),
    );
  }
}
