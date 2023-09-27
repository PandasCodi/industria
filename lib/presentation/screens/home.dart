import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:industria/core/constants/images.dart';
import 'package:industria/core/animations/fade_in_animation.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../app/router.dart';
import '../../core/constants/colors.dart';
import '../../core/themes/theme.dart';
import '../bloc/localization/localization_bloc.dart';
import '../widgets/footer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CarouselController carouselController = CarouselController();
  YoutubePlayerController? youtubeController;
  ScrollController scrollController = ScrollController();
  final textController = TextEditingController();
  String dropdownValue = '';
  bool isHovered = false;
  bool isHoveredCard1 = false;
  bool isHoveredCard2 = false;
  bool isHoveredCard3 = false;

  @override
  void initState() {
    youtubeController = YoutubePlayerController.fromVideoId(
      autoPlay: false,
      videoId: 'mvfvXl_LTvo',
      params: const YoutubePlayerParams(
          mute: false, loop: false, enableCaption: false),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dropdownValue = AppLocalizations.of(context)!.allGermany;
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 1100) {
          return CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 640,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(AppImages.homeBg).image
                            )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 70,),
                            Text(AppLocalizations.of(context)!.choosingRightCandidates, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),),
                            SizedBox(height: 15,),
                            SizedBox(
                              width: 320,
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white, letterSpacing: 1),
                                      children: [
                                        TextSpan(text: "${AppLocalizations.of(context)!.findYour} ", ),
                                        TextSpan(text: "${AppLocalizations.of(context)!.dream} ", style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppColors.mainAccent)),
                                        TextSpan(text: AppLocalizations.of(context)!.job, style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppColors.secondaryAccent)),
                                        TextSpan(text: " ${AppLocalizations.of(context)!.withUs}",),
                                      ]
                                  )),
                            ),
                            SizedBox(height: 15,),
                            SizedBox(
                                width: 430,
                                child: Text(AppLocalizations.of(context)!.hrSoftware, textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),)),
                            SizedBox(height: 31,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Container(
                                height: 70,
                                width: 800,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(offset: Offset(1,2), blurRadius: 6, color: Colors.black.withOpacity(0.25))
                                    ]
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 25,),
                                    Expanded(
                                      child: TextField(
                                        controller: textController,
                                        style: AppTheme.themeData.textTheme.labelMedium!
                                            .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontSize: 14),
                                        decoration: InputDecoration(
                                          enabledBorder: const OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          focusedBorder: const OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          hintText:
                                          AppLocalizations.of(context)!.jobTitle,
                                          hintStyle: AppTheme
                                              .themeData.textTheme.labelMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.darkGrey,
                                              fontSize: 14),
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.only(right: 28.5, top: 2),
                                            child: FaIcon(
                                              FontAwesomeIcons.solidBuilding,
                                              color: AppColors.darkGrey,
                                              size: 20,
                                            ),
                                          ),
                                          prefixIconConstraints: const BoxConstraints(
                                              maxWidth: 50, minHeight: 0),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 42,
                                    ),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      onEnter: (_) {
                                        setState(() {
                                          isHovered = !isHovered;
                                        });
                                      },
                                      onExit: (_) {
                                        setState(() {
                                          isHovered = !isHovered;
                                        });
                                      },
                                      child: GestureDetector(
                                        onTap: (){
                                          router.go(Uri.parse("/jobs").replace(queryParameters: {
                                            "country": dropdownValue.isEmpty || dropdownValue == AppLocalizations.of(context)!.allGermany ? null : dropdownValue,
                                            "keyword": textController.text
                                          }..removeWhere((key, value) => value == null)).toString());
                                        },
                                        child: Container(
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                              color: isHovered
                                                  ? AppColors.mainDarkAccent
                                                  : AppColors.mainAccent,
                                              borderRadius: const BorderRadius.only(
                                                  topRight: Radius.circular(12),
                                                  bottomRight: Radius.circular(12))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset(
                                                  AppImages.search,
                                                  width: 21,
                                                  height: 21,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!.search,
                                                  style: AppTheme
                                                      .themeData.textTheme.labelMedium!
                                                      .copyWith(
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Theme(
                              data: Theme.of(context).copyWith(
                                hoverColor: Colors.white,
                              ),
                              child: DropdownButton<String>(
                                focusColor: Colors.white,
                                icon: const Padding(
                                  padding: EdgeInsets.only(left: 8.0, top: 2),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                ),
                                underline: const SizedBox(),
                                value: dropdownValue,
                                borderRadius: BorderRadius.circular(10),
                                items: <String>[
                                  AppLocalizations.of(context)!.allGermany,
                                  'Berlin',
                                  'Munich'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: AppTheme
                                          .themeData.textTheme.labelMedium!
                                          .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 15,),
                            Text(AppLocalizations.of(context)!.typeYourKeyword, textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400, fontSize: 12),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 11,
                            right: MediaQuery.of(context).size.width / 11),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            FadeIn(
                              scrollController: scrollController,
                              revealOffset: 400,
                              slideBegin: const Offset(0.0, 1.0),
                              slideEnd: Offset.zero,
                              child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: AspectRatio(
                                            aspectRatio: 1.5,
                                            child: YoutubePlayer(
                                              controller: youtubeController!,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(
                                                      context)!
                                                  .ourIndustry,
                                              style: AppTheme.themeData
                                                  .textTheme.labelMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                      color: AppColors
                                                          .mainDarkAccent),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .connecting,
                                              style: AppTheme.themeData
                                                  .textTheme.headlineLarge!
                                                  .copyWith(fontSize: 36),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .foundedInLondon,
                                              textAlign: TextAlign.start,
                                              style: AppTheme.themeData
                                                  .textTheme.labelMedium!
                                                  .copyWith(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            FadeIn(
                              scrollController: scrollController,
                              revealOffset: 1100,
                              slideBegin: const Offset(1.0, 0.0),
                              slideEnd: Offset.zero,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .bestChoice,
                                        style: AppTheme.themeData
                                            .textTheme.labelMedium!
                                            .copyWith(
                                                fontWeight:
                                                    FontWeight.w600,
                                                fontSize: 20,
                                                color: AppColors
                                                    .mainDarkAccent),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .whyWeAre,
                                        style: AppTheme.themeData.textTheme
                                            .headlineLarge!
                                            .copyWith(fontSize: 36),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .atIndustria,
                                        textAlign: TextAlign.start,
                                        style: AppTheme
                                            .themeData.textTheme.labelMedium!
                                            .copyWith(fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .ourTailored,
                                        textAlign: TextAlign.start,
                                        style: AppTheme
                                            .themeData.textTheme.labelMedium!
                                            .copyWith(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 63,
                                  ),
                                  Image.asset(
                                    AppImages.homePic2,
                                    scale: 1,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            FadeIn(
                              scrollController: scrollController,
                              revealOffset: 1800,
                              slideBegin: const Offset(-1.0, 0.0),
                              slideEnd: Offset.zero,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .achievements,
                                    style: AppTheme
                                        .themeData.textTheme.headlineLarge!
                                        .copyWith(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 44,
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    onEnter: (_) {
                                      setState(() {
                                        isHoveredCard1 = !isHoveredCard1;
                                      });
                                    },
                                    onExit: (_) {
                                      setState(() {
                                        isHoveredCard1 = !isHoveredCard1;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      transform: isHoveredCard1
                                          ? Matrix4.translationValues(
                                              0, -20, 0)
                                          : Matrix4.identity(),
                                      decoration: BoxDecoration(
                                          color: isHoveredCard1
                                              ? AppColors.mainLightAccent
                                              : Colors.white,
                                          border: const Border(
                                            top: BorderSide(
                                                color: AppColors.mainAccent,
                                                width: 2),
                                          )),
                                      width:
                                          MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 44,
                                            ),
                                            Image.asset(
                                              AppImages.cup,
                                              scale: 2,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .oneOfTheLargest,
                                              style: AppTheme.themeData
                                                  .textTheme.headlineLarge!
                                                  .copyWith(fontSize: 32),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .weAreTop,
                                              textAlign: TextAlign.start,
                                              style: AppTheme.themeData
                                                  .textTheme.labelMedium!
                                                  .copyWith(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 89,
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    onEnter: (_) {
                                      setState(() {
                                        isHoveredCard2 = !isHoveredCard2;
                                      });
                                    },
                                    onExit: (_) {
                                      setState(() {
                                        isHoveredCard2 = !isHoveredCard2;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      transform: isHoveredCard2
                                          ? Matrix4.translationValues(
                                              0, -20, 0)
                                          : Matrix4.identity(),
                                      decoration: BoxDecoration(
                                          color: isHoveredCard2
                                              ? AppColors.mainLightAccent
                                              : Colors.white,
                                          border: const Border(
                                            top: BorderSide(
                                                color: AppColors.mainAccent,
                                                width: 2),
                                          )),
                                      width:
                                          MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 44,
                                            ),
                                            Image.asset(
                                              AppImages.sector,
                                              scale: 2,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .overTwo,
                                              style: AppTheme.themeData
                                                  .textTheme.headlineLarge!
                                                  .copyWith(fontSize: 32),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .weCanHelp,
                                              textAlign: TextAlign.start,
                                              style: AppTheme.themeData
                                                  .textTheme.labelMedium!
                                                  .copyWith(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 89,
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    onEnter: (_) {
                                      setState(() {
                                        isHoveredCard3 = !isHoveredCard3;
                                      });
                                    },
                                    onExit: (_) {
                                      setState(() {
                                        isHoveredCard3 = !isHoveredCard3;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      transform: isHoveredCard3
                                          ? Matrix4.translationValues(
                                              0, -20, 0)
                                          : Matrix4.identity(),
                                      decoration: BoxDecoration(
                                          color: isHoveredCard3
                                              ? AppColors.mainLightAccent
                                              : Colors.white,
                                          border: const Border(
                                            top: BorderSide(
                                                color: AppColors.mainAccent,
                                                width: 2),
                                          )),
                                      width:
                                          MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 44,
                                            ),
                                            Image.asset(
                                              AppImages.globe,
                                              scale: 2,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .weAreInternational,
                                              style: AppTheme.themeData
                                                  .textTheme.headlineLarge!
                                                  .copyWith(fontSize: 32),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .weHaveOur,
                                              textAlign: TextAlign.start,
                                              style: AppTheme.themeData
                                                  .textTheme.labelMedium!
                                                  .copyWith(fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 128,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 280,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              AppImages.homePic3,
                              fit: BoxFit.fitHeight,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.considering,
                                    style: AppTheme
                                        .themeData.textTheme.labelMedium!
                                        .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 19),
                                  ),
                                  SizedBox(height: 20,),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    onEnter: (_) {
                                      setState(() {
                                        isHovered = !isHovered;
                                      });
                                    },
                                    onExit: (_) {
                                      setState(() {
                                        isHovered = !isHovered;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: isHovered
                                              ? AppColors.mainDarkAccent
                                              : AppColors.mainAccent,
                                          borderRadius: BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 40,
                                          vertical: 16,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .getInTouch,
                                          style: AppTheme
                                              .themeData.textTheme.labelMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.ourPartners,
                          style: AppTheme.themeData.textTheme.headlineLarge!
                              .copyWith(
                                  fontSize: 24,),
                        ),
                      ),
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.over,

                          style: AppTheme.themeData.textTheme.headlineLarge!
                              .copyWith(
                            fontSize: 16,fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 61,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Center(
                                  child: Icon(
                                Icons.arrow_back_ios,
                                size: 40,
                                color: AppColors.mainAccent,
                              )),
                              onPressed: () {
                                carouselController.previousPage();
                              },
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                height: 160,
                                width:
                                    MediaQuery.of(context).size.width/2 ,
                                child: CarouselSlider(
                                  carouselController: carouselController,
                                  items: [
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Image.asset(
                                        AppImages.tnt,
                                        scale: 2,
                                      ),
                                    ),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Image.asset(
                                        AppImages.british,
                                        scale: 1,
                                      ),
                                    ),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Image.asset(
                                        AppImages.disney,
                                        scale: 1,
                                      ),
                                    ),
                                  ],
                                  options: CarouselOptions(
                                    height: 200,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 1,
                                    initialPage: 0,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Center(
                                  child: Icon(
                                Icons.arrow_forward_ios,
                                size: 40,
                                color: AppColors.mainAccent,
                              )),
                              onPressed: () {
                                carouselController.nextPage();
                              },
                              hoverColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                    ],
                  ),
              ),
              const Footer(),
            ],
          );
        } else {
          return desktop(context);
        }
      }),
    );
  }

  CustomScrollView desktop(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 640,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(AppImages.homeBg).image
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 70,),
                      Text(AppLocalizations.of(context)!.choosingRightCandidates, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),),
                      SizedBox(height: 15,),
                      SizedBox(
                        width: 320,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white, letterSpacing: 1),
                          children: [
                            TextSpan(text: "${AppLocalizations.of(context)!.findYour} ", ),
                            TextSpan(text: "${AppLocalizations.of(context)!.dream} ", style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppColors.mainAccent)),
                            TextSpan(text: AppLocalizations.of(context)!.job, style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: AppColors.secondaryAccent)),
                            TextSpan(text: " ${AppLocalizations.of(context)!.withUs}",),
                          ]
                        )),
                      ),
                      SizedBox(height: 15,),
                      SizedBox(
                          width: 430,
                          child: Text(AppLocalizations.of(context)!.hrSoftware, textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),)),
                      SizedBox(height: 31,),
                      Container(
                        height: 84,
                        width: 800,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(offset: Offset(1,2), blurRadius: 6, color: Colors.black.withOpacity(0.25))
                          ]
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 25,),
                            SizedBox(
                              width: 200,
                              child: TextField(
                                controller: textController,
                                style: AppTheme.themeData.textTheme.labelMedium!
                                    .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 14),
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  hintText:
                                  AppLocalizations.of(context)!.jobTitle,
                                  hintStyle: AppTheme
                                      .themeData.textTheme.labelMedium!
                                      .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.darkGrey,
                                      fontSize: 14),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(right: 28.5, top: 2),
                                    child: FaIcon(
                                      FontAwesomeIcons.solidBuilding,
                                      color: AppColors.darkGrey,
                                      size: 20,
                                    ),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                      maxWidth: 50, minHeight: 0),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: 39,
                              width: 2,
                              color: AppColors.lightGrey, // Color of the divider
                            ),
                            const SizedBox(
                              width: 42,
                            ),
                            Theme(
                              data: Theme.of(context).copyWith(
                                hoverColor: Colors.white,
                              ),
                              child: DropdownButton<String>(
                                focusColor: Colors.white,
                                icon: const Padding(
                                  padding: EdgeInsets.only(left: 8.0, top: 2),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 17,
                                    color: AppColors.darkGrey,
                                  ),
                                ),
                                underline: const SizedBox(),
                                value: dropdownValue,
                                borderRadius: BorderRadius.circular(10),
                                items: <String>[
                                  AppLocalizations.of(context)!.allGermany,
                                  'Berlin',
                                  'Munich'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: AppTheme
                                          .themeData.textTheme.labelMedium!
                                          .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.darkGrey,
                                          fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 42,
                            ),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) {
                                setState(() {
                                  isHovered = !isHovered;
                                });
                              },
                              onExit: (_) {
                                setState(() {
                                  isHovered = !isHovered;
                                });
                              },
                              child: GestureDetector(
                                onTap: (){
                                  router.go(Uri.parse("/jobs").replace(queryParameters: {
                                    "country": dropdownValue.isEmpty || dropdownValue == AppLocalizations.of(context)!.allGermany ? null : dropdownValue,
                                    "keyword": textController.text
                                  }..removeWhere((key, value) => value == null)).toString());
                                },
                                child: Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      color: isHovered
                                          ? AppColors.mainDarkAccent
                                          : AppColors.mainAccent,
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomRight: Radius.circular(12))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.search,
                                          width: 21,
                                          height: 21,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.search,
                                          style: AppTheme
                                              .themeData.textTheme.labelMedium!
                                              .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25,),
                      Text(AppLocalizations.of(context)!.typeYourKeyword, textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400, fontSize: 12),)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 92, top: 45),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .choosingRightCandidates,
                            style: AppTheme.themeData.textTheme.labelMedium!
                                .copyWith(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      AppLocalizations.of(context)!.findYour,
                                  style: AppTheme
                                      .themeData.textTheme.headlineLarge!
                                      .copyWith(fontSize: 36),
                                ),
                                TextSpan(
                                  text:
                                      ' ${AppLocalizations.of(context)!.dream}\n',
                                  style: AppTheme
                                      .themeData.textTheme.headlineLarge!
                                      .copyWith(
                                          fontSize: 36,
                                          color: AppColors.mainAccent),
                                ),
                                TextSpan(
                                    text:
                                        '${AppLocalizations.of(context)!.job} ',
                                    style: AppTheme
                                        .themeData.textTheme.headlineLarge!
                                        .copyWith(
                                            fontSize: 36,
                                            color:
                                                AppColors.secondaryAccent)),
                                TextSpan(
                                  text: AppLocalizations.of(context)!.withUs,
                                  style: AppTheme
                                      .themeData.textTheme.headlineLarge!
                                      .copyWith(fontSize: 36),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppLocalizations.of(context)!.hrSoftware,
                            style: AppTheme.themeData.textTheme.labelMedium!
                                .copyWith(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 589,
                            decoration: BoxDecoration(
                              color: const Color(0xFFfafafa),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(2, 4),
                                    color: AppColors.lightGrey,
                                    blurRadius: 2),
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  color: AppColors.lightGrey,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 23, right: 8, bottom: 8, top: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 180,
                                    child: TextField(
                                      controller: textController,
                                      style: AppTheme
                                          .themeData.textTheme.labelMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.darkGrey,
                                              fontSize: 10),
                                      decoration: InputDecoration(
                                        enabledBorder:
                                            const OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                        focusedBorder:
                                            const OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                        hintText:
                                            AppLocalizations.of(context)!
                                                .jobTitle,
                                        hintStyle: AppTheme
                                            .themeData.textTheme.labelMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.darkGrey,
                                                fontSize: 12),
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.only(
                                              right: 18.0, top: 2),
                                          child: FaIcon(
                                            FontAwesomeIcons.solidBuilding,
                                            color: AppColors.darkGrey,
                                            size: 15,
                                          ),
                                        ),
                                        prefixIconConstraints:
                                            const BoxConstraints(
                                                maxWidth: 50, minHeight: 0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: context
                                                .read<LocalizationBloc>()
                                                .state
                                                .locale ==
                                            const Locale('de')
                                        ? 40
                                        : 25,
                                  ),
                                  Container(
                                    height: 39,
                                    width: 2,
                                    color: AppColors
                                        .lightGrey, // Color of the divider
                                  ),
                                  const SizedBox(
                                    width: 32,
                                  ),
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      hoverColor: Colors.white,
                                    ),
                                    child: DropdownButton<String>(
                                      focusColor: Colors.white,
                                      icon: const Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.0, top: 2),
                                        child: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          size: 17,
                                          color: AppColors.darkGrey,
                                        ),
                                      ),
                                      underline: SizedBox(),
                                      value: dropdownValue,
                                      borderRadius: BorderRadius.circular(10),
                                      items: <String>[
                                        AppLocalizations.of(context)!
                                            .allGermany,
                                        'Berlin',
                                        'Munich'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: AppTheme.themeData
                                                .textTheme.labelMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w400,
                                                    color: AppColors.darkGrey,
                                                    fontSize: 10),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 42,
                                  ),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    onEnter: (_) {
                                      setState(() {
                                        isHovered = !isHovered;
                                      });
                                    },
                                    onExit: (_) {
                                      setState(() {
                                        isHovered = !isHovered;
                                      });
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        router.go('/jobs');
                                      },
                                      child: Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                            color: isHovered
                                                ? AppColors.mainDarkAccent
                                                : AppColors.mainAccent,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 22, right: 43),
                                          child: Row(
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons
                                                    .magnifyingGlass,
                                                color: Colors.white,
                                                size: 13,
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .search,
                                                style: AppTheme.themeData
                                                    .textTheme.labelMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white,
                                                        fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppLocalizations.of(context)!.typeYourKeyword,
                            style: AppTheme.themeData.textTheme.labelMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.darkGrey,
                                    fontSize: 12),
                          ),
                        ],
                      ),
                      Image.asset(
                        AppImages.homePic,
                        height: 552,
                        width: 720,
                      ),
                    ],
                  ),
                ),
                FadeIn(
                  scrollController: scrollController,
                  revealOffset: 250,
                  slideBegin: const Offset(0.0, 1.0),
                  slideEnd: Offset.zero,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 155,
                      left: 90,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 351,
                            width: 630,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: YoutubePlayer(
                                controller: youtubeController!,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          SizedBox(
                            width: 589,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .ourIndustry,
                                  style: AppTheme
                                      .themeData.textTheme.labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color:
                                              AppColors.mainDarkAccent),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.connecting,
                                  style: AppTheme
                                      .themeData.textTheme.headlineLarge!
                                      .copyWith(fontSize: 36),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .foundedInLondon,
                                  textAlign: TextAlign.start,
                                  style: AppTheme
                                      .themeData.textTheme.labelMedium!
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ),
                ),
                FadeIn(
                  scrollController: scrollController,
                  revealOffset: 800,
                  slideBegin: const Offset(1.0, 0.0),
                  slideEnd: Offset.zero,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 155, left: 90, right: 115),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.bestChoice,
                              style: AppTheme
                                  .themeData.textTheme.labelMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: AppColors.mainDarkAccent),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)!.whyWeAre,
                              style: AppTheme
                                  .themeData.textTheme.headlineLarge!
                                  .copyWith(fontSize: 36),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)!.atIndustria,
                              textAlign: TextAlign.start,
                              style: AppTheme.themeData.textTheme.labelMedium!
                                  .copyWith(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              AppLocalizations.of(context)!.ourTailored,
                              textAlign: TextAlign.start,
                              style: AppTheme.themeData.textTheme.labelMedium!
                                  .copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(offset: Offset(0,4), blurRadius: 20, color: Colors.black.withOpacity(0.25))
                            ]
                          ),
                          child: Image.asset(
                            AppImages.homePic2,
                            height: 477,
                            width: 472,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                FadeIn(
                  scrollController: scrollController,
                  revealOffset: 1400,
                  slideBegin: const Offset(-1.0, 0.0),
                  slideEnd: Offset.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Container(height: 2, color: AppColors.lightGrey.withOpacity(0.5))),
                          SizedBox(width: 80,),
                          Text(
                            AppLocalizations.of(context)!.achievements,
                            style: AppTheme.themeData.textTheme.headlineLarge!
                                .copyWith(
                                    fontSize: 24, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(width: 80,),
                          Expanded(child: Container(height: 2, color: AppColors.lightGrey.withOpacity(0.5))),
                        ],
                      ),
                      const SizedBox(
                        height: 88,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) {
                                setState(() {
                                  isHoveredCard1 = !isHoveredCard1;
                                });
                              },
                              onExit: (_) {
                                setState(() {
                                  isHoveredCard1 = !isHoveredCard1;
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                transform: isHoveredCard1
                                    ? Matrix4.translationValues(0, -20, 0)
                                    : Matrix4.identity(),
                                width: 400,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        AppImages.cup,
                                        scale: 2,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .oneOfTheLargest,
                                        style: AppTheme.themeData.textTheme
                                            .headlineLarge!
                                            .copyWith(fontSize: 32),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .weAreTop,
                                        textAlign: TextAlign.start,
                                        style: AppTheme
                                            .themeData.textTheme.labelMedium!
                                            .copyWith(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(height: 128, width: 2, color: AppColors.lightGrey.withOpacity(0.5), alignment: Alignment.center,),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) {
                                setState(() {
                                  isHoveredCard2 = !isHoveredCard2;
                                });
                              },
                              onExit: (_) {
                                setState(() {
                                  isHoveredCard2 = !isHoveredCard2;
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                transform: isHoveredCard2
                                    ? Matrix4.translationValues(0, -20, 0)
                                    : Matrix4.identity(),
                                width: 400,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        AppImages.sector,
                                        scale: 2,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.overTwo,
                                        style: AppTheme.themeData.textTheme
                                            .headlineLarge!
                                            .copyWith(fontSize: 32),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .weCanHelp,
                                        textAlign: TextAlign.start,
                                        style: AppTheme
                                            .themeData.textTheme.labelMedium!
                                            .copyWith(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(height: 128, width: 2, color: AppColors.lightGrey.withOpacity(0.5), alignment: Alignment.center,),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) {
                                setState(() {
                                  isHoveredCard3 = !isHoveredCard3;
                                });
                              },
                              onExit: (_) {
                                setState(() {
                                  isHoveredCard3 = !isHoveredCard3;
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                transform: isHoveredCard3
                                    ? Matrix4.translationValues(0, -20, 0)
                                    : Matrix4.identity(),
                                width: 400,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        AppImages.globe,
                                        scale: 2,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .weAreInternational,
                                        style: AppTheme.themeData.textTheme
                                            .headlineLarge!
                                            .copyWith(fontSize: 32),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .weHaveOur,
                                        textAlign: TextAlign.start,
                                        style: AppTheme
                                            .themeData.textTheme.labelMedium!
                                            .copyWith(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 128,
                ),
                SizedBox(
                  height: 269,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(AppImages.homePic3),
                      Positioned(
                        left: 110,
                        bottom: 52,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) {
                            setState(() {
                              isHovered = !isHovered;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              isHovered = !isHovered;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: isHovered
                                    ? AppColors.mainDarkAccent
                                    : AppColors.mainAccent,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 46,
                                vertical: 22,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.getInTouch,
                                style: AppTheme
                                    .themeData.textTheme.labelMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 110,
                        bottom: 143,
                        child: Text(
                          AppLocalizations.of(context)!.considering,
                          style: AppTheme.themeData.textTheme.labelMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 159,
                ),
                Text(
                  AppLocalizations.of(context)!.ourPartners,
                  style: AppTheme.themeData.textTheme.headlineLarge!
                      .copyWith(fontSize: 24,),
                ),
               Text(
                  AppLocalizations.of(context)!.over,

                  style: AppTheme.themeData.textTheme.headlineLarge!
                      .copyWith(
                      fontSize: 16,fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 61,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Center(
                            child: Icon(
                          Icons.arrow_back_ios,
                          size: 40,
                          color: AppColors.mainAccent,
                        )),
                        onPressed: () {
                          carouselController.previousPage();
                        },
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 58),
                        child: SizedBox(
                          height: 160,
                          width: MediaQuery.of(context).size.width / 1.32,
                          child: CarouselSlider(
                            carouselController: carouselController,
                            items: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Image.asset(
                                  AppImages.tnt,
                                  scale: 3,
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Image.asset(
                                  AppImages.british,
                                  scale: 2,
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Image.asset(
                                  AppImages.disney,
                                  scale: 2,
                                ),
                              ),
                            ],
                            options: CarouselOptions(
                              height: 200,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.4,
                              initialPage: 0,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Center(
                            child: Icon(
                          Icons.arrow_forward_ios,
                          size: 40,
                          color: AppColors.mainAccent,
                        )),
                        onPressed: () {
                          carouselController.nextPage();
                        },
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 161,
                ),
              ],
            ),
        ),
        const Footer(),
      ],
    );
  }
}
