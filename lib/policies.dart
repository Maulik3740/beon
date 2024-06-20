import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_ads_web/constant/Screen.dart';
import 'package:super_ads_web/constant/drawer.dart';
import 'package:super_ads_web/constant/navbar.dart';
import 'package:velocity_x/velocity_x.dart';

class Policies extends StatefulWidget {
  const Policies({super.key});

  @override
  State<Policies> createState() => _PoliciesState();
}

class _PoliciesState extends State<Policies> {
  String _selectedPolicy = 'General Information';
  bool up = true;
  bool down = false;

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: s.width > 750 ? null : CustomDrawer(),
      body: Stack(
        children: [
          //background
          Container(
            width: s.width,
            height: s.height,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.9), // Change to your desired color and opacity
                BlendMode.srcATop,
              ),
              child: Image.asset(
                'assets/lottie/bbb.webp',
                fit: BoxFit.cover,
              ),
            ),
          ),

          Row(
            children: [
              s.width < 750
                  ? Container()
                  : Container(
                      width: s.width > 1024 ? 250 : 150,
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildPolicySections(),
                      ),
                    ),
              Expanded(
                child: Column(
                  children: [
                    s.width > 750
                        ? Container()
                        : Column(
                            children: [
                              Visibility(
                                visible: up,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  mouseCursor: MouseCursor.defer,
                                  onTap: () {
                                    setState(() {
                                      up = false;
                                      down = true;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "General Information",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        Icon(Icons.arrow_circle_down_sharp)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: down,
                                child: Container(
                                  // height: 40,
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  margin: EdgeInsets.all(20),
                                  decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(10)),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: _buildPolicySections(),
                                        ),
                                        IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    up = true;
                                                    down = false;
                                                  });
                                                },
                                                icon: Icon(Icons.arrow_circle_up_sharp))
                                            .w(double.infinity)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    Expanded(
                      child: Container(
                        // color: Colors.yellow,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: _buildPolicyContent(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPolicySections() {
    return [
      policySection('General Information'),
      policySection('Terms Of Services'),
      policySection('Private Statement'),
      policySection('Alternative Dispute Resolution Policy'),
      policySection('Refund Policy'),
      policySection('Cancellation Policy'),
      policySection('Human Usage Policy'),
      policySection('Site License Policy'),
      policySection('Publicly Filed Information Policy'),
    ];
  }

  Widget policySection(String title, {bool? text}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPolicy = title;
          up = true;
          down = false;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: text == true ? 5 : 10),
            width: double.infinity,
            color: Colors.transparent,
            child: Text(
              title,
              style: GoogleFonts.poppins(
                decoration: text == true ? TextDecoration.underline : TextDecoration.none,
                fontSize: MediaQuery.of(context).size.width > 1024 ? 16 : 14,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey,
              ),
            ),
          ),
          text == true ? Container() : Divider(),
        ],
      ),
    );
  }

  Widget _buildPolicyContent() {
    switch (_selectedPolicy) {
      case 'General Information':
        return Container(
          // color: Colors.green,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                mainLabelText(
                  'Policies, Terms, and General Service Information',
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Our aim is to create legal policies that are as fair and clear as possible, a challenge that is seldom undertaken and rarely achieved. The task of balancing genuine and substantial tensions between general readability and legal precision is difficult. Contractual text, similar to software code, is designed to be functional, with both attempting to ensure predictable outcomes. However, this often results in “legalese,” which, while familiar and comforting to attorneys, can be off-putting or frustrating to everyone else.',
                  style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 81, 109, 123)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'As with every other part of Beon, developing our policies is an ongoing process. We try to build our brand off our customers loving us. If you have any questions or feedback, please feel free to reach out to our founder, Dave Applegate, directly at contact@fuertedevelopers.in.',
                  style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 81, 109, 123)),
                ),
                Text(
                  'contact@fuertedevelopers.in.',
                  style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 5, 170, 252)),
                ),
                SizedBox(
                  height: 20,
                ),
                policySection('General Information', text: true),
                policySection('Terms Of Services', text: true),
                policySection('Private Statement', text: true),
                policySection('Alternative Dispute Resolution Policy', text: true),
                policySection('Refund Policy', text: true),
                policySection('Cancellation Policy', text: true),
                policySection('Human Usage Policy', text: true),
                policySection('Site License Policy', text: true),
                policySection('Publicly Filed Information Policy', text: true),
              ],
            ),
          ),
        );
      case 'Terms Of Services':
        return Container(
          // color: Colors.blue,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                mainLabelText(
                  'Terms of Service',
                ),
                LabelText2(
                  'These Terms of Service are effective as of February 19, 2024',
                ),
                SizedBox(
                  height: 20,
                ),
                LabelText2(
                  'Our aim is to create legal policies that are as fair and clear as possible, a challenge that is seldom undertaken and rarely achieved.',
                ),
                styledText(
                  'The task of balancing genuine and substantial tensions between general readability and legal precision is difficult. Contractual text, similar to software code, is designed to be functional, with both attempting to ensure predictable outcomes. However, this often results in “legalese,” which, while familiar and comforting to attorneys, can be off-putting or frustrating to everyone else.',
                ),
                SizedBox(
                  height: 10,
                ),
                styledText(
                  'As with every other part of Beon, developing our policies is an ongoing process. We try to build our brand off our customers loving us. If you have any questions or feedback, please feel free to reach out to our founder, Dave Applegate, directly at',
                ),
                Text(
                  'contact@fuertedevelopers.in.',
                  style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 5, 170, 252)),
                ),
                SizedBox(
                  height: 20,
                ),
                LabelText2(
                  'ACCEPTANCE OF THESE TERMS',
                ),
                styledText(
                  'The following are the terms of an agreement between Beon (collectively, “We, Our, Us, the Services, Beon services”) and you (or the legal entity you represent). These Terms of Use govern your use of our products and services, however accessed, by website, located at https://www.Beon.com/, mobile apps or other means and any other products and services that We may provide now or in the future (collectively, the “Services” “Products”). Visitors and users of the Services are referred to individually as “User” and collectively as “Users”',
                ),
                styledText(
                  'By using this website and the Beon services, you acknowledge that you have read, understand, and agree to be bound by these terms in their entirety, and to comply with all applicable laws and regulations. If you do not agree to these terms, please do not use this website or the Beon services.',
                ),
                styledText(
                  'These terms include several other important policies that you should know about. You can review our Privacy Notice, which outlines our practices towards any personal data that you may provide or we otherwise collect; our Refund Policy, which explains when and how refunds may be applied; our Cancellation Policy, which describes how to cancel your account; and our Alternative dispute resolution policy, which outlines how disputes will be resolved through mediation and, if necessary, arbitration.',
                ),
                styledText(
                  'We may, without notice to you, at any time, revise these Terms of Service and any other information contained in this website. We may also make improvements or changes to the Beon services, and any other products, services, or programs described in this site, at any time without notice.',
                ),
                styledText(
                  'IMPORTANT NOTICE - ARBITRATION AGREEMENT:BY AGREEING TO BE BOUND BY THIS AGREEMENT, YOU AGREE THAT ALL DISPUTES BETWEEN US WILL BE RESOLVED BY BINDING ARBITRATION.',
                ),
                styledText(
                  'The keynotes in the right margin are for informational purposes only. They are not legally binding and do not alter these terms. In case of any conflict, these Terms of Service shall prevail. They are not a substitute for legal advice.',
                ),
                SizedBox(
                  height: 10,
                ),
                LabelText(
                  'REGISTRATION AND USER ACCOUNTS',
                ),
                styledText(
                  '1. You and the individuals authorized by you to register accounts with the Services (“Users”) must be at least 18 years of age to use this website and the Beon services. Users must be human. Accounts registered by “bots” or other automated methods are not permitted.',
                ),
                styledText(
                  '2. As part of the registration creation process, each User creates login credentials by selecting a password and providing an e-mail address. Users must provide true, accurate, current, and complete information as prompted by the registration form, or at any other time, and You also agree to maintain and update the information as necessary.',
                ),
                styledText(
                  '3. Users may not share their login credentials or give their login credentials to anyone else. Each user is responsible for maintaining the confidentiality of their password. A user may not impersonate another user, use another user\'s account, permit someone else to use their account, or attempt to capture or guess other users\' passwords. You must immediately notify us of any unauthorized use of your password.',
                ),
                styledText(
                  '4. You agree that we may, for any or no reason, and without penalty, discontinue in whole or in part, cancel or suspend your (or any User\'s) access to and use of this website or the Services at any time, with or without notice.',
                ),
                SizedBox(
                  height: 10,
                ),
                LabelText(
                  'PAYMENTS, REFUNDS, AND CANCELLATIONS',
                ),
                styledText(
                  '1. If you are using a free version of one of our Services, it is really free: we do not ask you for your credit card or sell your data.',
                ),
                styledText(
                  '1. If you are using a free version of one of our Services, it is really free: we do not ask you for your credit card or sell your data.',
                ),
                styledText(
                  '2. We process refunds according to our refund policy',
                ),
                styledText(
                  '3. You are solely responsible for properly canceling your account. You can find instructions for how to cancel your account in our cancellation policy.',
                ),
                SizedBox(
                  height: 10,
                ),
                LabelText(
                  'LIMITED PERMISSION; NO RESALE OR DISTRIBUTION',
                ),
                styledText(
                  '1. Beon grants you the limited, revocable, non-transferable permission to access this website as a customer or potential customer of Beon and to access and use the Beon services, for your own personal, internal, non-commercial purposes, subject to your compliance with these Terms of Service. The use authorized under this agreement is non-commercial in nature (e.g., you may not sell the information, data, and content you access on or through this site) All other use of this site is prohibited.',
                ),
                styledText(
                  '2. Except for the limited permission above, Beon does not grant you any express or implied rights or licenses under any patents, trademarks, copyrights, or other proprietary or intellectual property rights.',
                ),
                styledText(
                  '3. You will not distribute, transfer, sub-license, rent, lend, transmit, sell, re-circulate, repackage, assign, lease, resell, publish, copy, translate, convert, decompile, reverse engineer, alter, enhance, disassemble, modify, or change all or any portion of the Beon services (including this website and any mobile apps).',
                ),
                styledText(
                  '4. You will not use, any robot, spider, site search/retrieval application, or other manual or automatic device or process to retrieve, index, “data mine,” or in any way reproduce or circumvent the navigational structure or presentation of this website or the Services. You will not harvest or collect information about website visitors or any customer of Beon without their express prior written consent.',
                ),
                styledText(
                  '5. You will not circumvent or attempt to circumvent the features of the Services to obtain information or data by other means.',
                ),
                styledText(
                  '6. You will not use the Services to create, contribute to or assist a competitive product or service, or to compile information useful for a commercial product or service.',
                ),
                SizedBox(
                  height: 10,
                ),
                LabelText(
                  'INTELLECTUAL PROPERTY',
                ),
                styledText(
                  '1. This website and the Beon Services, and their entire contents, features, and functionality (including but not limited to all information, software, text, displays, images, video, and audio, and the design, selection, and arrangement thereof) are owned by Beon, its licensors, or other providers of such materials, and are protected by U.S. and international copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws.',
                ),
                styledText(
                  '2. The Beon name, logomark, and all related names, logos, product and service names, designs, and slogans are trademarks and trade dress owned by us. Beon images and icons may be used by third party sites in connection with providing appropriate links to the Beon website.',
                ),
                styledText(
                  '3. We do not want to receive confidential information from you. Note that any information or material sent to us will be deemed NOT confidential, and provided with an unrestricted, irrevocable license to copy, reproduce, publish, upload, post, transmit, distribute, publicly display, perform, modify, create derivative works from, and otherwise freely use, those materials or information. You agree that we are free to use any ideas, concepts, know-how, or techniques that you send us for any purpose.',
                ),
                styledText(
                  '4. We shall not, under any circumstances, be liable for any content or materials from third parties, including users. For example (Facebbok® and Instagram® are the registered trademarks of Meta Platforms, Inc. in the United States and other countries. Google® is a registered trademark of Google LLC. and/or its affiliates. Twitter® is a registered trademark of Twitter, Inc. or its subsidiaries in the United States and/or other countries.) This includes but is not limited to, errors or omissions in any content or any loss or damage resulting from the use of such content. We may remove any content that violates these Terms of Service or is deemed objectionable by Us in its sole discretion. You agree that you must assess and assume all risks associated with using any content, including reliance on its accuracy, completeness, or usefulness.',
                ),
                SizedBox(
                  height: 10,
                ),
                LabelText(
                  'DISCLAIMER OF WARRANTIES',
                ),
                styledText(
                  '1. WE PROVIDE THE SERVICES “AS IS”, AS AVAILABLE, WITH ALL FAULTS, WITHOUT REPRESENTATION, WARRANTY OR GUARANTEE OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING WITHOUT LIMITATION, ANY IMPLIED WARRANTY OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT OF THIRD-PARTY RIGHTS, OR REGARDING RELIABILITY, TIMELINESS, QUALITY, SUITABILITY, AVAILABILITY, ACCURACY OR COMPLETENESS. WE HEREBY DISCLAIM ALL REPRESENTATIONS AND WARRANTIES TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW. USE OF THE SERVICES IS AT YOUR SOLE RISK.',
                ),
                styledText(
                  '2. We do not guarantee the continuous availability of the Services or of any specific feature(s) of the Services. We may change the Services, impose usage or service limits, suspend service, or block certain kinds of usage at our sole discretion. The security, accuracy, and timeliness of data are not guaranteed; loss, errors, delays, or omissions may occur. Please confirm the accuracy and completeness of information before using it to make decisions.',
                ),
                SizedBox(
                  height: 10,
                ),
                LabelText(
                  'LIMITATIONS OF LIABILITY',
                ),
                styledText(
                  'IN NO EVENT WILL Beon AND ITS SHAREHOLDERS, DIRECTORS, OFFICERS, EMPLOYEES, SUPPLIERS, AND LICENSORS (“Beon PARTIES”) BE LIABLE (JOINTLY OR SEVERALLY) TO YOU OR ANY OTHER PERSON AS A RESULT OF YOUR ACCESS OR USE OF THE SERVICES FOR INDIRECT, CONSEQUENTIAL, SPECIAL, INCIDENTAL, PUNITIVE, OR EXEMPLARY DAMAGES, INCLUDING, WITHOUT LIMITATION, LOST PROFITS, LOST SAVINGS, LOST REVENUES, OR LOST GOODWILL.',
                ),
                styledText(
                  'IN NO EVENT WILL THE Beon PARTIES BE LIABLE FOR DAMAGES OF ANY KIND, UNDER ANY LEGAL THEORY, ARISING OUT OF OR IN CONNECTION WITH YOUR USE, OR INABILITY TO USE, THE PLATFORMS, ANY WEBSITES LINKED TO IT, ANY DATA AND CONTENT ON THE PLATFORMS OR SUCH OTHER WEBSITES. THESE LIMITATIONS APPLY WHETHER THE ALLEGED LIABILITY IS BASED ON NEGLIGENCE, TORT, CONTRACT, OR OTHER THEORY OF LIABILITY, EVEN IF ANY OF THE Beon PARTIES HAVE BEEN ADVISED OF THE POSSIBILITY OF OR COULD HAVE FORESEEN ANY OF THE EXCLUDED DAMAGES, AND IRRESPECTIVE OF ANY FAILURE OF AN ESSENTIAL PURPOSE OF A LIMITED REMEDY.',
                ),
                styledText(
                  'IF ANY APPLICABLE AUTHORITY HOLDS ANY PORTION OF THIS SECTION TO BE UNENFORCEABLE, THEN THE Beon PARTIES\' LIABILITY WILL BE LIMITED TO THE FULLEST POSSIBLE EXTENT PERMITTED BY APPLICABLE LAW.',
                ),
                styledText(
                  'NOTWITHSTANDING THE FOREGOING, IN NO EVENT SHALL THE TOTAL LIABILITY OF Beon, FOR ALL DAMAGES, LOSSES, AND CAUSES OF ACTION WHETHER IN CONTRACT, TORT INCLUDING NEGLIGENCE, OR OTHERWISE, EXCEED THE AGGREGATE DOLLAR AMOUNT PAID BY THE USER CLAIMANT TO Beon IN THE TWELVE MONTHS PRIOR TO THE CLAIMED LOSS, DAMAGES OR OTHER SUCH ALLEGED EVENT GIVING RISE TO THE BASIS OF CLAIM.',
                ),
                SizedBox(
                  height: 10,
                ),
                LabelText(
                  'INDEMNITY',
                ),
                styledText(
                  'You hereby agree to indemnify and hold harmless Beon, its affiliated and associated companies, and their respective directors, officers, employees, agents, representatives, independent and dependent contractors, licensees, successors, and assigns from and against all claims, losses, expenses, damages and costs (including, but not limited to, direct, incidental, consequential, exemplary and indirect damages), and reasonable attorneys\' fees, resulting from or arising out of:',
                ),
                styledText(
                  'a. breach of this Agreement,',
                ),
                styledText(
                  'b. violation of any rights of a third party,',
                ),
                styledText(
                  'c. violation of law or willful misconduct, and',
                ),
                styledText(
                  'd. use of the Services, by you or any person using your account.',
                ),
                SizedBox(
                  height: 10,
                ),
                LabelText(
                  'GOVERNING LAW & ALTERNATIVE DISPUTE RESOLUTION',
                ),
                styledText(
                  'This Agreement shall be governed by the laws of the State of California without regard to its conflict of laws provisions.',
                ),
                styledText(
                  'The parties agree that any and all disputes, claims or controversies arising out of or relating to this Agreement, or the breach, termination, enforcement, interpretation or validity thereof, including the determination of the scope or applicability of this agreement to arbitrate, shall be submitted to JAMS, or its successor(a neutral arbitrator), for mediation, and if the matter is not resolved through mediation, then it shall be submitted to JAMS, or its successor, for final and binding arbitration, per our Alternative Dispute Resolution Policy',
                ),
                styledText(
                  'Arbitration will be in Los Angeles, California before one arbitrator. The arbitration shall be administered pursuant to the JAMS Streamlined Arbitration Rules and Procedures, or if you reside outside of the United States, the JAMS International Arbitration Rules. Judgment on the award may be entered in any court having jurisdiction. This clause shall not preclude parties from seeking provisional remedies in aid of arbitration from a court of appropriate jurisdiction.',
                ),
                styledText(
                  'ANY CAUSE OF ACTION OR CLAIM YOU MAY HAVE ARISING OUT OF OR RELATING TO THESE TERMS OR THE PLATFORMS MUST BE COMMENCED WITHIN ONE (1) YEAR AFTER THE CAUSE OF ACTION ACCRUES; OTHERWISE, SUCH CAUSE OF ACTION OR CLAIM IS PERMANENTLY BARRED.',
                ),
                SizedBox(
                  height: 10,
                ),
                LabelText(
                  'GENERAL',
                ),
                styledText(
                  '1. This Agreement represents the entire agreement and understanding between the parties. This Agreement shall supersede any and all other agreements, verbal or otherwise, concerning this subject matter. No amendments or modifications shall be binding unless made in writing and signed by both of parties.',
                ),
                styledText(
                  '2. Our failure to enforce any provision of this Agreement or to respond to a breach by you shall not in any way constitute a waiver of our right to enforce later any terms or conditions or to act with respect to similar breaches.',
                ),
                styledText(
                  '3. If a provision of this Agreement is held invalid or unenforceable for any reason, that provision will be deemed severable and shall be construed in a manner consistent with applicable law to reflect, as nearly as possible, the intention of the parties. The validity and enforceability of any remaining provisions will not be affected, and such provisions shall remain in full force and effect.',
                ),
                SizedBox(
                  height: 10,
                ),
                LabelText(
                  'YOUR COMMENTS AND CONCERNS',
                ),
                styledText(
                  'If you have a question about any of these terms and conditions, please contact our Support team.',
                ),
              ],
            ),
          ),
        );
      case 'Private Statement':
        return Container(
          // color: Colors.orange,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                mainLabelText(
                  'Private Statement',
                ),
                LabelText2('This Privacy Statement is effective as of February 19, 2024'),
                styledText(
                  'We love our users, and it\'s evident in everything we do. We chat with them daily to ensure we\'re creating something they truly enjoy. This commitment extends to the finer details, even the ones users might not notice, like legal policies, privacy statements, and other places the devil hides.',
                ),
                styledText(
                  'More important: Our privacy framework This privacy statement is just the tip of the “iceberg,” meaning just the most visible part of our framework of policies, processes, and internal controls for privacy and data security that we\'ve carefully thought through from bottom to top. These are made and followed in a culture and with a leadership that emphasizes privacy, respect, accountability, and excellence.',
                ),
                styledText(
                  'Most important: Built-On-Privacy Privacy and respect for our users are literally built into our DNA. What do we mean? Everyone talks about privacy policies and how difficult they are to read, and on and on. That\'s true, and by anchoring the public debate, the very idea of these “policies” successfully serves its first purpose: misdirection. There is a context to every privacy policy, a bigger picture, that\'s most important. Here\'s the real bottom line you need to know about us before you dive into the details.',
                ),
                LabelText2(
                  'What “Built-On-Privacy” means:',
                ),
                styledText(
                  '1. We do not make money from personal data. Our business model is not based on targeted advertising, platform network effects, or selling personal data, directly or indirectly. We aren\'t a business built on an inherent conflict of interest - this is what it means to have privacy in our DNA.',
                ),
                styledText(
                  '2. Our sole purpose for using personal data is to provide and improve products and services for our users. The details are below, where we clearly disclose the specific purposes and features data is used for.',
                ),
                styledText(
                  '3. We collect only the minimum amount of personal data necessary. We clearly disclose what personal data we collect, and only collect the minimum data necessary. Sometimes called “privacy-by-design.” Consider that privacy policies, in an essential sense, are unearned demands by companies for your trust: that they will keep their word, that they will keep the data safe. Our view: what we don\'t have, we can\'t misuse, we can\'t be hacked for.',
                ),
                styledText(
                  '4. We are a stable, profitable company with no outside funding and no VC or investor interference or pressure. We mean it when we say we only want to create things people love. You know who our founder and CEO is. No one else has a say.',
                ),
                styledText(
                  'Our commitment to excellence and your satisfaction in everything we do is unwavering. This is an ongoing process, as we continually strive to push the envelope. Your feedback is invaluable to us—help us improve by sharing your thoughts. As always, you\'re welcome to email our founder directly.',
                ),
                styledText(
                  'WE DO NOT COLLECT SENSITIVE PERSONAL DATA.',
                ),
                styledText(
                  'If you are a California resident, please click here to see our California Notice at Collection, which includes additional disclosures as required by California law.',
                ),
                styledText(
                  'Margin notes are for informational purposes only. They are not legally binding and do not alter these terms. In case of any conflict, these Terms of Service shall prevail. They are not a substitute for legal advice.',
                ),
                LabelText(
                  'WHAT DATA DO WE GATHER ABOUT YOU?',
                ),
                styledText(
                  'This section describes the various types of information that we collect and how we use it. “Personal data” means data or information that identifies, relates to, or describes you, or is reasonably capable of being associated with or could reasonably be linked to you. Under federal and state law, personal data does not include information made available from federal, state, or local government records.',
                ),
                LabelText2(
                  'A. Data You Voluntarily Give Us',
                ),
                styledText(
                  'This information includes account information, interactions on webpages, notes or transcripts of your conversations with us for support purposes, information to improve our business operations, and more.',
                ),
                styledText(
                  'a. For Your Account. When you sign up, we collect your name, your email address, and country. We may also store your details from business contact information that you provide to us, or that we collect from your organization or our service providers.',
                ),
                styledText(
                  'b. For Billing. To process payments, we collect and use your payment information. This can include your name, your address, your telephone number, your email address, your credit or debit card information, and other relevant information. Note that our payment processing vendors collect your credit or debit card information, and this information is not passed back to us.',
                ),
                styledText(
                  'c. Correspondence. When you email us with a question or to ask for help, or interact with a help chatbot, we keep the correspondence, including your email address, or transcript of chat history, so that we have a history of past correspondence to reference if you reach out in the future.',
                ),
                styledText(
                  'd. Feedback. If you provide feedback to us, we keep notes and records relating to your feedback. We also retain any other information you voluntarily provide, such as written survey responses. If you consent to a customer interview, we may request your permission to record the conversation for internal reference or training purposes. We will only do so if you expressly approve.',
                ),
                styledText(
                  'A Note about Sensitive Personal Data.',
                ),
                styledText(
                  'We aim to avoid collecting sensitive personal details about you. This includes government-issued IDs (e.g. driver\'s license, passport, or social security number), racial or ethnic background, political views, religious beliefs, health information, biometric or genetic traits, trade union membership, sexuality (including details about sex life or sexual orientation), and criminal history. However, please note that certain laws consider account access information, like a username and password, as sensitive personal data.',
                ),
                LabelText2(
                  'B. Data Collected Automatically',
                ),
                styledText(
                  'a. Website Interactions. As you navigate through and interact with our website, we may use automatic data collection technologies to collect certain information about your equipment, browsing actions, and patterns, including: details of your visits to our website, including traffic data, location data, logs, and other communication data and the resources that you access and use on the website, and information about your computer and internet connection, including your IP address, operating system, and browser type. If you interact on our website, we will track your activities online, but we do not know who you are. However, if you submit a form with your contact information, we will engage with you as requested and may follow up with you to further build a relationship.',
                ),
                styledText(
                  'The technologies we use for this automatic data collection may include:',
                ),
                styledText(
                  '• Cookies (or browser cookies). A cookie is a small file placed on the hard drive of your computer. You may refuse to accept browser cookies by activating the appropriate setting on your browser. However, if you select this setting, you may be unable to access certain parts of our website.',
                ),
                styledText(
                  '• Web Beacons. Pages of our Website (and our emails) may contain small electronic files known as web beacons (also referred to as clear gifs, pixel tags, and single-pixel gifs) that permit us, for example, to count users who have visited those pages or opened an email and for other related website statistics (for example, recording the popularity of certain website content and verifying system and server integrity). These may interact with technology from our third-party service providers.',
                ),
                LabelText2(
                  'California Do Not Track Disclosure.',
                ),
                styledText(
                  'Some browsers include a “Do Not Track” (DNT) setting that can send a signal to the websites you visit indicating you do not wish to be tracked. However, since there is no consensus on how browsers are to interpret the DNT signal, our Website does not respond to browser DNT signals.',
                ),
                styledText(
                  'b. Geolocation Information. We log the full IP address used to sign up an account and retain that for purposes of mitigating future spammy signups. We also log all account access by full IP address for security and fraud prevention purposes, and we keep this login data for as long as your account is active.',
                ),
                styledText(
                  'c. Malicious Activities. We may use specialized tooling and other technical means to collect information at access points to, and in, IT systems and networks to detect unauthorized access, viruses, and indications of malicious activities. The information we collect may be used to conduct investigations when unauthorized access, malware or malicious activities are suspected.',
                ),
                styledText(
                  'd. Personal Contacts. We never scan your device for contacts or upload them.',
                ),
                LabelText2(
                  'C. Data We Create or Generate',
                ),
                styledText(
                  'a. Aggregated and de-identified data. We may aggregate and/or de-identify information collected through the services, so that it no longer identifies you under applicable laws. We may use de-identified or aggregated data for any purpose, including marketing or analytics.',
                ),
                styledText(
                  'b. Artificial Intelligence. We may infer new information from data we collect, including using automated means such as artificial intelligence, which may include use of third party artificial intelligence or machine learning services, to generate information about your likely preferences or other characteristics.',
                ),
                LabelText2(
                  'D. Data Collected From Other Sources',
                ),
                styledText(
                  'U.S. Government Databases. Shipment records like bills of lading that we compile, enrich, organize and present may sometimes include personal information, like names and addresses (“Publicly Filed Personal Information“ or “PFPI”). These public records are made available by the federal government, including from the Customs and Border Patrol (CBP), and ultimately, the National Archives (with bills of lading going back over 200 years).',
                ),
                styledText(
                  'Under federal and state law, and as commonly known in the shipping industry, Publicly Filed Personal Information is not personal data. To be clear, we are under no legal obligations to remove PFPI. That said, we do not knowingly index, not tag, structure, format, identify, or make PFPI accessible as such at any point during our intake process or later in connection with the Services. Further, in practice, we aggressively implement and continue to fine-tune algorithms to detect PFPI in our databases in order to delete or redact such information.',
                ),
                styledText(
                  'If you are someone with PFPI, it is easy to ask the CBP to make this information confidential, often within 24 hours. Please see our Publicly-Filed Personal Information Notice.',
                ),
                LabelText(
                  'WHAT DO WE DO WITH DATA ABOUT YOU?',
                ),
                styledText(
                  'A. Services. We use your data to help you use our services, such as:',
                ),
                styledText(
                  '• To present our Website and its contents to you',
                ),
                styledText(
                  '• Making our services available',
                ),
                styledText(
                  '• Arranging access to your account',
                ),
                styledText(
                  '• Providing customer service',
                ),
                styledText(
                  '• Responding to your inquiries, requests, suggestions or complaints',
                ),
                styledText(
                  '• Completing your payments and transactions',
                ),
                styledText(
                  '• Sending service-related messages',
                ),
                styledText(
                  '• Saving your searches and notes',
                ),
                styledText(
                  '• Sending optional surveys to help improve our services',
                ),
                styledText(
                  '• With your consent, sending newsletters and other updates',
                ),
                styledText(
                  'B. Personalization and Marketing. We use your data to communicate with you about relevant features and services. We also use this information to personalize your online experience with our content and to develop internal marketing and business intelligence.',
                ),
                styledText(
                  'C. Improving Business Operations. We may use your data to improve our business operations, systems, and processes. For example, information may be used to audit and optimize our operations, or for product development.',
                ),
                styledText(
                  'D. Support Services. We may use your data to help you troubleshoot a software bug. When you contact us to request support, we collect your contact information, problem description, and possible resolutions. We may record the information that you provide during a support incident for quality assurance purposes.',
                ),
                styledText(
                  'E. Security. We may collect and use data to protect you and us from IT security threats and to secure the information that we hold from unauthorized access.',
                ),
                styledText(
                  'F. Restricted Uses. Accessing a customer\'s account when investigating potential abuse is a measure of last resort. We want to protect the privacy and safety of both our customers and the people reporting issues to us, and we do our best to balance those responsibilities throughout the process. If we discover you are using our products for a restricted purpose, we will take action as necessary, including notifying appropriate authorities where warranted.',
                ),
                styledText(
                  'G. Notify You of Changes. To notify you about changes to our Website or any products or services we offer or provide through it.',
                ),
                LabelText(
                  'WHO DO WE SHARE WITH OR DISCLOSE DATA TO?',
                ),
                styledText(
                  'We won\'t share your information unless it\'s needed for our business or we\'re required to do so by law. We may disclose aggregated or anonymized information about our users, and information that does not identify any individual without restriction, We may disclose personal information that we collect, or you provide as described in this privacy policy:',
                ),
                styledText(
                  'A. Service Providers. We work with service providers to carry out certain tasks, including:',
                ),
                styledText(
                  '• Providing you the services',
                ),
                styledText(
                  '• Processing your payments',
                ),
                styledText(
                  '• Fulfilling your orders',
                ),
                styledText(
                  '• Maintaining technology and related infrastructure',
                ),
                styledText(
                  '• Offering you customer service',
                ),
                styledText(
                  '• Distributing emails',
                ),
                styledText(
                  '• List processing and analytics',
                ),
                styledText(
                  '• Managing and analyzing research',
                ),
                styledText(
                  'We use well-known service providers that implement rigorous technical and organizational measures, including with at least SOC 2 attestation and often additional qualifications like ISO 27018 certification (information below current as of the date of this statement). All have executed Data Processing Agreements (DPAs) unless otherwise noted.',
                ),
                styledText(
                  '• Rudderstack: SOC 2 Type 2, ISO 27001 and 27018, GDPR: Open-source Customer Data Platform (CDP) that integrates with over 150 analytics, marketing, and data storage tools and data warehouses, enabling businesses to collect, unify, and activate their customer data across various platforms. Our mutual data processing agreement (DPA) with Rudderstack is here. See their privacy policy.',
                ),
                styledText(
                  '• Hubspot: SOC 2 Type 2, SOC 3, GDPR, CCPA: Cloud-based CRM platform that includes marketing, sales, customer service, and content management solutions to help businesses grow better. Our mutual data processing agreement (DPA) with Customer.io is here. See their privacy policy.',
                ),
                styledText(
                  '• Customer.io: SOC 2 Type 2, HIPAA, GDPR: Marketing automation platform that enables businesses to send targeted emails, push notifications, and SMS messages based on customer behavior and data. Our mutual data processing agreement (DPA) with Customer.io is here. See their privacy policy.',
                ),
                styledText(
                  '• Google Analytics: SOC 2 Type 2, SOC 3, ISO 27001/18, GDPR, CCPA: Web analytics service offered by Google that tracks and reports website traffic, providing insights into user behavior and website performance. Our mutual data processing agreement (DPA) with Google Analytics is here.',
                ),
                styledText(
                  '• Mixpanel: SOC 2 Type 2, ISO 27701, GDPR, CCPA, HIPAA: Analytics for mobile and web, allowing businesses to analyze user interactions with applications through event tracking and tailored reports. Our mutual data processing agreement (DPA) with Mixpanel is here. See their privacy policy.',
                ),
                styledText(
                  '• Amazon Web Services (AWS): ISO Certified, GDPR, CCPA, HIPAA: Comprehensive and widely adopted cloud platform that offers over 200 key essential for online services from data centers globally, supporting a variety of workloads and applications. Our mutual data processing agreement (DPA) with AWS is here. See their privacy policy.',
                ),
                styledText(
                  '• Google Cloud Platform (GCP): ISO 27001, ISO 27017, SOC 2 Type 2, HIPAA, CCPA, GDPR: Suite of cloud computing services that runs on the same infrastructure that Google uses internally for its end-user products, such as Google Search, Gmail, and YouTube. Our mutual data processing agreement (DPA) with GCP is here.',
                ),
                styledText(
                  '• ChargeBee: SOC 2 Type 2, ISO 27001, GDPR, CCPA, HIPAA: Subscription billing and revenue management platform that simplifies the back-end complexities of managing subscription business models. Our mutual data processing agreement (DPA) with ChargeBee is here. See their privacy policy.',
                ),
                styledText(
                  '• Stripe: SOC 2 Type 2, PCI, CCPA: Economic infrastructure for the internet, providing payment processing software and APIs for e-commerce websites and mobile applications. Our mutual data processing agreement (DPA) with Stripe is here. See their privacy policy.',
                ),
                styledText(
                  '• New Relic: SOC 2 Type 2, ISO 27001, HIPAA: Application Performance Monitoring. It helps us understand how fast Beon and catch errors. Our mutual data processing agreement (DPA) with New Relic is here. See their privacy policy.',
                ),
                styledText(
                  '• Front: SOC 2 Type 2, ISO 27001, HIPAA, CCPA, GDPR: Our eMail inbox managment platform that allows us to create stellar customer service. Our mutual data processing agreement (DPA) with Front is here. See their privacy policy.',
                ),
                styledText(
                  '• Zoom: SOC 2 Type 2, ISO 27001, ISO 27017, ISO 27018, GDPR, HIPAA: Awesome video calls. Our mutual data processing agreement (DPA) with Zoom is here. See their privacy policy.',
                ),
                styledText(
                  '• Cloudflare: SOC 2 Type 2, ISO 27001, ISO 27018, ISO 27701, GDPR, HIPAA, CCPA: Provides stellar cybersecurity features and improves Beon\'s site speed. Our mutual data processing agreement (DPA) with Cloudflare is here. See their privacy policy.',
                ),
                styledText(
                  '• Quickbooks: SOC 2 Type 2, ISO 27001, PCI, GDPR: Our accounting platform. Our mutual data processing agreement (DPA) with Quickbooks is here. See their privacy policy.',
                ),
                styledText(
                  '• PayPal: SOC 2 Type 2, ISO 27001, PCI, GDPR: Easy online money transfers especailly for people outside the United States. Our mutual data processing agreement (DPA) with Paypal is here. See their privacy policy.',
                ),
                styledText(
                  '• Slack: SOC 2 Type 2, ISO 27001, HIPAA, CCPA, GDPR: Provides our internal team the ability to communicate efficiently. Our mutual data processing agreement (DPA) with Slack is here. See their privacy policy.',
                ),
                styledText(
                  '• Ringover: GDPR, DTLS-SRTP, HSMHandles Beon\'s phone traffic. Our mutual data processing agreement (DPA) with Ringover is here. See their privacy policy.',
                ),
                styledText(
                  'B. Internal Usage. Our internal access to personal data is restricted and granted only on a need-to-know basis. Sharing of this information is subject to the appropriate intracompany arrangements, our policies, and security standards.',
                ),
                styledText(
                  'C. Governmental Requests. We don\'t respond to government requests for user data unless we are compelled by legal process or in limited circumstances in the event of an emergency request. Our policy is to notify affected users before we disclose data unless we are legally prohibited from doing so, and except in some emergency cases.',
                ),
                styledText(
                  'D. Tax Audits. If we are audited by a tax authority, we may be required to disclose billing-related information. If that happens, we will disclose only the minimum needed, such as billing addresses and tax exemption information.',
                ),
                styledText(
                  'E. Acquisition. If we are acquired by or merges with another company — we don\'t plan on that, we have deliberately avoided outside financing to ensure our autonomy, but if it happens — or in connection with a liquidation, bankruptcy or similar proceeding, we will notify you well before any of your personal data is transferred or becomes subject to a different privacy policy. Some information may be disclosed to potential purchasers.',
                ),
                LabelText(
                  'WHAT ARE YOUR RIGHTS AND CHOICES?',
                ),
                styledText(
                  'In many jurisdictions, you have certain rights and choices when it comes to the handling of your personal data. At Beon, we strive to apply the same data rights to all users, regardless of their location.',
                ),
                styledText(
                  'A. Beon Bill of Privacy Rights. We honor requests from all of our users, regardless of their location, to exercise the same rights that our California users have in accordance with our California Supplemental Privacy Statement. These include the exercise of the following choices (our “Bill of Rights”):',
                ),
                styledText(
                  '• Access to the personal data that we have on you, or have it updated or corrected.',
                ),
                styledText(
                  '• Obtain your personal data in a usable format, for transmittal to another party (a/k/a the right to data portability).',
                ),
                styledText(
                  '• Request to delete the personal data we hold about you.',
                ),
                styledText(
                  '• Opt-out of or restrict certain specific personal data processing types.',
                ),
                styledText(
                  'B. Exercising Your Choices and Rights. To exercise any of these choices, or any of your rights under applicable law, please reach us at contact@fuertedevelopers.in Please be specific in your request. For example, let us know exactly what needs updating, if you want your information removed, or how you\'d like us to handle your personal data. Please email us from the account associated with your personal data, since we only handle requests linked to an email we have on file. We will send a confirmation to this email, and in some instances, additional details may be required to confirm your identity. We\'ll respond to your request in a manner consistent with applicable law, including any exceptions that may result in a request being denied in whole or in part.',
                ),
                styledText(
                  'C. State Consumer & Privacy Laws. State consumer & privacy laws may provide their residents with additional rights regarding use of their personal information. California, Colorado, Connecticut, Delaware, Florida, Indiana, Iowa, Montana, Oregon, Tennessee, Texas, Utah, and Virginia generally provide their state residents with rights to:',
                ),
                styledText(
                  '• Confirm whether we process their personal information.',
                ),
                styledText(
                  '• Access and delete certain personal information.',
                ),
                styledText(
                  '• Correct inaccuracies in their personal information (excluding Iowa and Utah).',
                ),
                styledText(
                  '• Data portability.',
                ),
                styledText(
                  '• Opt-out of personal data processing for: (a) targeted advertising (excluding Iowa), (b) sales, and (c) profiling in furtherance of decisions with legal effects (excluding Iowa and Utah).',
                ),
                styledText(
                  'As described in more detail below, California residents have the right to instruct us to not “sell” or “share” their personal data. (Again: not applicable, as we don\'t sell your personal data.) Residents of Colorado, Connecticut, Virginia and Utah have the right to opt out of “targeted advertising” and “sales” (as defined under applicable law). (Again: not applicable, we don\'t sell targeted ads, we don\'t sell personal data).As described in more detail below, California residents have the right to instruct us to not “sell” or “share” their personal data. (Again: not applicable, as we don\'t sell your personal data.) Residents of Colorado, Connecticut, Virginia and Utah have the right to opt out of “targeted advertising” and “sales” (as defined under applicable law). (Again: not applicable, we don\'t sell targeted ads, we don\'t sell personal data).',
                ),
                styledText(
                  'The exact scope of these rights may vary by state. To learn more about California residents\' privacy rights, visit our California Supplemental Privacy Statement.',
                ),
                styledText(
                  'Residents of the European Union and the United Kingdom generally also enjoy these and other rights, for example, the right to withdraw consent for future processing.',
                ),
                styledText(
                  'In certain jurisdictions, it\'s possible to designate an authorized agent to act on your behalf. In this case, furnish the designated agent with written permission, signed by you, authorizing them to submit the request in your name. Ensure that the agent includes this written consent when making the request. We may reach out to you for identity verification, including confirmation of the agent\'s permission, before responding to the request.',
                ),
                styledText(
                  'Not intended as legal advice.Details concerning privacy rights are offered solely for general informational purposes. We have tried to be accurate as of the statement date, but all information is provided “as is.” For questions about your specific legal rights, please consult your own personal attorney.',
                ),
                LabelText(
                  'HOW DO YOU PROTECT OUR DATA?',
                ),
                styledText(
                  'We make reasonable efforts to provide a level of security appropriate to the risk associated with the processing of your personal data. We maintain organizational, technical and administrative measures designed to protect personal data against unauthorized access, destruction, loss, alteration or misuse.',
                ),
                styledText(
                  'These measures include role-based access controls and encryption to keep personal data private while in transit. All data is encrypted via SSL/TLS when transmitted from our servers to your browser. The database backups are also encrypted. All information you provide to us is stored on our secure servers behind firewalls. Any payment transactions will be encrypted using SSL technology.',
                ),
                styledText(
                  'The safety and security of your information also depends on you. Where we have given you (or where you have chosen) a password for access to certain parts of our Website, you are responsible for keeping this password confidential. We ask you not to share your password with anyone.',
                ),
                styledText(
                  'Unfortunately, the transmission of information via the internet is not completely secure. Although we do our best to protect your personal data, we cannot guarantee the security of your personal data transmitted to our Website. Any transmission of personal data is at your own risk.',
                ),
                LabelText(
                  'HOW LONG DO YOU STORE OUR DATA?',
                ),
                styledText(
                  'We only retain personal data as long as necessary to fulfill the purposes for which it is processed, or to comply with legal and regulatory retention requirements. Legal and regulatory retention requirements may include retaining information for:',
                ),
                styledText(
                  '• audit and accounting purposes,',
                ),
                styledText(
                  '• statutory retention terms,',
                ),
                styledText(
                  '• the handling of disputes,',
                ),
                styledText(
                  '• and the establishment, exercise, or defense of legal claims in the countries where we do business.',
                ),
                styledText(
                  'We retain any contractual relationship information for administrative purposes, legal and regulatory retention requirements, defending Beon rights, and to manage our relationship with you.',
                ),
                styledText(
                  'When personal data is no longer needed, we have processes in place to securely delete it, for example by erasing electronic files and shredding physical records.',
                ),
                LabelText(
                  'TRANSFER OF PERSONAL DATA INTO THE UNITED STATES',
                ),
                LabelText2(
                  'Location of Services',
                ),
                styledText(
                  'The Beon services are housed in the United States.',
                ),
                styledText(
                  'If you are located outside of the United States, please be aware that any information you provide to us will be transferred to and stored in the United States. By using our websites or services and/or providing us with your personal data, you consent to this transfer.',
                ),
                LabelText2(
                  'Transfer from the European Union & United Kingdom',
                ),
                styledText(
                  'The European Data Protection Board (EDPB) has issued guidance stating that personal data transferred out of the EU must receive an equivalent level of protection as granted under EU privacy law. UK legislation also offers similar safeguards for UK user data when transferred outside the UK.',
                ),
                styledText(
                  'To adhere to these requirements, Beon has implemented a Data Processing Addendum that incorporates Standard Contractual Clauses, which can be accessed here',
                ),
                styledText(
                  'Additionally, there are sporadic instances where EU personal data may be transmitted to the U.S. in the course of Beon\'s operations. For instance, this may occur when an EU user subscribes to our newsletter, participates in surveys, or makes purchases from our online store. These transfers are infrequent, and data is shared under the Article 49(1)(b) derogation as specified in GDPR and its UK counterpart.',
                ),
                LabelText2(
                  'Controller',
                ),
                styledText(
                  'The privacy laws in some countries consider a Controller to be the legal entity (or natural person) who defines the purposes for which the processing of personal data takes place and how that information is processed. Parties that are involved in processing operations on behalf of a Controller may be designated as Processors. Designations and associated obligations differ, depending on the jurisdiction.',
                ),
                styledText(
                  'Where this is relevant for the privacy laws in your country, the Controller of your personal data is Beon, LLC. Our contact details are: 24383 Marquis Court, Laguna Hills, CA 92653',
                ),
                LabelText(
                  'CHANGES AND QUESTIONS',
                ),
                styledText(
                  'We may update this policy as needed to comply with relevant regulations and reflect any new practices. If we make significant changes, we will refresh the date at the top of this page and notify users who have signed up to our policy updates mailing list.',
                ),
                LabelText(
                  'CONTACT INFORMATION',
                ),
                styledText(
                  'If you have any questions, concerns, or requests regarding your personal data, this Privacy Policy, or our data practices, please do not hesitate to contact us. You may reach our Privacy Team at the following contact information:',
                ),
                styledText(
                  'Company Name: Beon',
                ),
                styledText(
                  'Email Address: beon@gmail.com',
                ),
                styledText(
                  'Physical Address: 24383 Marquis Court, Laguna Hills, CA 92653',
                ),
                styledText(
                  'We are committed to addressing your inquiries promptly and in accordance with applicable data protection laws. Your privacy is important to us, and we appreciate your trust in our handling of your information.',
                ),
              ],
            ),
          ),
        );
      case 'Alternative Dispute Resolution Policy':
        return Container(
          // color: Colors.purple,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                mainLabelText("Alternative Dispute Resolution Policy"),
                styledText("This Alternative Dispute Resolution Policy is effective as of February 19, 2024."),
                styledText("In order to expedite and control the cost of disputes, Service Provider and you agree that any legal or equitable claim, dispute, action, or proceeding arising from or related to your use of the Services or these Terms (“Dispute“) will be resolved as follows to the fullest extent permitted by law"),
                styledText("We're aiming for a respectful and fair dispute resolution process. We're choosing ADR for its speed, cost-effectiveness, flexibility, and transparency. We've selected JAMS (a neutral arbitrator), for its well-earned reputation, and its familiar, straightforward rules and processes (all on the web). ADR encourages open dialog and mutual respect, hopefully with results that work for everybody, making the best of situations we frankly hope never occur."),
                styledText("These rules follow a structured approach that begins with direct outreach, progresses to mediation through JAMS, and if necessary, concludes with arbitration. Mediation through JAMS provides a faster, more affordable alternative to court, crucial for our commitment to providing accessible services. If necessary, arbitration provides a final decision, based on case merits by impartial experts."),
                styledText("As always, your feedback is invaluable to us—help us improve by sharing your thoughts."),
                styledText("1. ADR. The parties agree that any and all disputes, claims, or controversies arising out of or relating to this Agreement that have not been resolved by negotiation as provided herein within sixty (60) days or such time period as you and the Service Provider may otherwise agree, shall be finally resolved by binding arbitration, shall be submitted to JAMS, or its successor, for mediation, and if the matter is not resolved through mediation, then it shall be submitted to JAMS, or its successor, for final and binding arbitration, except for a limited right of appeal under the Federal Arbitration Act, pursuant to the clause set forth in Paragraph 5 below."),
                styledText("2. Initiation of Mediation. Either party may commence mediation by providing to JAMS and the other party a written request for mediation, setting forth the subject of the dispute and the relief requested."),
                styledText("3. Selection of Mediator; Participation and Costs. The parties will cooperate with JAMS and with one another in selecting a mediator from the JAMS panel of neutrals and in scheduling the mediation proceedings. The parties agree that they will participate in the mediation in good faith and that they will share equally in its costs."),
                styledText("4. Confidentiality and Privilege. All offers, promises, conduct, and statements, whether oral or written, made in the course of the mediation by any of the parties, their agents, employees, experts, and attorneys, and by the mediator or any JAMS employees, are confidential, privileged and inadmissible for any purpose, including impeachment, in any arbitration or other proceeding involving the parties, provided that evidence that is otherwise admissible or discoverable shall not be rendered inadmissible or non-discoverable as a result of its use in the mediation."),
                styledText("5. Initiation of Arbitration. Either party may initiate arbitration with respect to the matters submitted to mediation by filing a written demand for arbitration at any time following the initial mediation session or at any time following 45 days from the date of filing the written request for mediation, whichever occurs first (“Earliest Initiation Date”). The mediation may continue after the commencement of arbitration if the parties so desire."),
                styledText("6. Provisional Remedies. At no time prior to the Earliest Initiation Date shall either side initiate an arbitration or litigation related to this Agreement except to pursue a provisional remedy that is authorized by law or by JAMS Rules or by agreement of the parties. However, this limitation is inapplicable to a party if the other party to comply with the requirements of Paragraph 3 above."),
                styledText("7. Tolling. All applicable statutes of limitation and defenses based upon the passage of time shall be tolled until fifteen days after the Earliest Initiation Date. The parties will take such action, if any, required to effectuate such tolling."),
                LabelText2("YOUR COMMENTS AND CONCERNS"),
                styledText("If you have a question, please contact our Support team."),
              ],
            ),
          ),
        );
      case 'Refund Policy':
        return Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                mainLabelText("Refund Policy"),
                styledText("We offer a “No Frowns, Just Refunds” policy. If for some reason you no longer need our services, no worries! We've got your back. (For corporate plans, please refer to the contract or email us.)"),
                LabelText2("We will be able to grant you a full refund if:"),
                styledText("• You're charged for the next month's service but canceled within the 7-day leeway. (eg. if your billing cycle is on the 1st day of each month, you are given until the 8th to cancel for a full refund)"),
                styledText("• You stopped using the site, but you discovered that you're still incurring charges because you forgot to cancel. (maximum of 3 months)"),
                LabelText2("We will be able to grant you a partial refund if:"),
                styledText("• You've switched or opted to an annual subscription but ended up not needing our services before your annual subscription ends (eg. you have only used it for 6 months = remaining months would be refunded)"),
                LabelText2("We won't be able to grant you a refund if:"),
                styledText("• You've forgotten to feed the Beon. (He's always hungry!)"),
                styledText("Limitations: If your account is deactivated because you violated our Terms of Service or any other policy, we may decide to refund you for any services you haven't used yet. However, we also have the right to not refund you if we believe that deactivating your account was the right decision based on the violation. Any refund decisions will follow our internal rules and will be final."),
                styledText("Changes to Refund Policy: We may update our refund policy from time to time. Any changes will be effective immediately once we post the updated policy on our website. By continuing to use our services after we post any changes, you agree to the updated policy. It is your responsibility to review this refund policy periodically for any updates or changes."),
                styledText("Contact Us: We're here to help! If you have any questions or concerns about our refund policy or need assistance with your purchase, please don't hesitate to reach out to contact@fuertedevelopers.in."),
              ],
            ),
          ),
        );
      case 'Cancellation Policy':
        return Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                mainLabelText(
                  'Cancellation Policy',
                ),
                SizedBox(
                  height: 20,
                ),
                styledText("We want happy customers, not prisoners. The policies below apply to subscriptions purchased on Beon.com. For corporate plans, please refer to your individualized contract."),
                SizedBox(
                  height: 5,
                ),
                styledText(
                  "If you need to cancel, just email us anytime or use the self-serve option in your Account Settings.",
                ),
                SizedBox(
                  height: 5,
                ),
                styledText("If you cancel, your subscription will remain active until the next billing period. E.g. If you canceled your account on the 15th, but your next renewal isn\'t until the 30th, you can keep using Beon's premium features until then."),
                SizedBox(
                  height: 5,
                ),
                styledText(
                  "Your cancellation will take effect from the date it was requested.",
                ),
                SizedBox(
                  height: 5,
                ),
                styledText(
                  "Upon cancellation of the service, access to any content or data that has been used or generated during the subscription period will remain available to the user until the end of the current billing cycle or subscription period. After this time, the user's access to the content and data will be terminated, and they will no longer be able to retrieve or access this information. It is the user's responsibility to download or save any important content or data before the end of the subscription period.",
                ),
                SizedBox(
                  height: 5,
                ),
                styledText(
                  "If a user's account is terminated due to a violation of our terms of service or any other policy, access to any content or data associated with the account will be immediately terminated. The user will no longer have access to this content or data, and it will not be retrievable or accessible in any form. It is the user's responsibility to ensure they comply with our terms of service and policies to avoid termination and loss of access to their content and data.",
                ),
                SizedBox(
                  height: 5,
                ),
                styledText(
                  "We'll miss you, but remember, you're always welcome back. If you have a few minutes, we'd love to hear your reasons as to why you canceled, not because we want to debate, but because we're always looking to grow and improve. Your feedback is our stepping stone to becoming better (and we promise, no hard feelings or debates!). You can email our founder directly at contact@fuertedevelopers.in.",
                ),
              ],
            ),
          ),
        );
      case 'Human Usage Policy':
        return Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                mainLabelText(
                  "Human Usage Policy",
                ),
                styledText("Data lovers, unite! We understand that usage caps can be a bummer. Feel at ease to use our data to your heart's content, even for heavy-duty usage. We'll guide you through what we consider as human use versus data misuse."),
                SizedBox(
                  height: 10,
                ),
                LabelText2(
                  "Samples of human use",
                ),
                SizedBox(
                  height: 10,
                ),
                styledText("    1. Bob is with sales. On a daily average, he clicks the Random button over 500 times to search for prospects. He usually ends up seeing 50 potential companies and downloads each of their entire data for further review. Is this OK? Yes!"),
                SizedBox(
                  height: 10,
                ),
                styledText("    2. Billy owns a lumber company and is looking for a new supplier. He spends an entire week intensively searching for the hundreds of lumber suppliers on the site from all countries. Is this OK? Yes!"),
                SizedBox(
                  height: 10,
                ),
                styledText("    3. John is creating a report on the market conditions of coffee. He downloads all the data on each of the coffee companies and the entire HS Code dataset for coffee for a combined total of 50,000 shipments. Is this OK? Yes!"),
                SizedBox(
                  height: 20,
                ),
                LabelText2(
                  "Samples of \"data misuse\"*:",
                ),
                SizedBox(
                  height: 10,
                ),
                styledText('    1. Chuck is a data engineer at a startup. He tries to download 50,000,000 bill of ladings to incorporate into his Al-based supply chain risk algorithm. Is this OK? No. Chuck should reach out to sales to better understand our raw data products.'),
                SizedBox(
                  height: 10,
                ),
                styledText("    2. Charles built a script to crawl Beon. He's trying to integrate the data into his investing related website. His script hits Beon 100,000 times a day. Is this OK? No. Charles should reach out to sales to better understand our raw data products."),
                SizedBox(
                  height: 10,
                ),
                styledText("Beon has the right to deactivate accounts when we detect signs of data misuse. See our Refunds and Cancellation guidelines for more info."),
                SizedBox(
                  height: 10,
                ),
                styledText("You can contact us via email at contact@fuertedevelopers.in if you have any questions."),
              ],
            ),
          ),
        );
      case 'Site License Policy':
        return Container(
          // color: Colors.deepOrange,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                mainLabelText("Site License Policy"),
                LabelText2("What Are Site Licenses?"),
                styledText("Heavily discounted user pricing. Site licenses have all the features of a standard Beon License."),
                LabelText2("Why Create Site Licenses?"),
                styledText("We heard your feedback: “Why should all 10 of our salespeople pay the same when only half use Beon heavily?” We created site licenses to fix that. Now, there's no need to share logins or limit usage to certain teams!"),
                LabelText2("Who Is Eligible For a Site License?"),
                styledText("In order to qualify for a site license discount, you need to purchase Beon for all potential users within your organization."),
                styledText("Here at Beon, we're all about creating solutions that benefit everyone. If you have any questions or need more information about our site licenses, don't hesitate to reach out to us via email at contact@fuertedevelopers.in. We're more than happy to explore options that could be tailored to your specific needs."),
              ],
            ),
          ),
        );
      case 'Publicly Filed Information Policy':
        return Container(
          // color: Colors.indigo,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                mainLabelText("Notice Regarding Publicly Filed Personal Information"),
                styledText("This Publicly Filed Personal Information Notice is effective as of February 23, 2024."),
                styledText("We occasionally receive requests from individuals asking for the “takedown” or removal of their names and addresses from shipment records in our databases. Sometimes, they are confused about how their information ended up in our databases and what our legal obligations are."),
                styledText("It's true that sometimes personal names and addresses are found in bills of lading retrievable by our services (“Publicly Filed Personal Information”, “PFPI”). Here, we are specifically talking about individuals, operating as amateur shippers or receivers, who put their personal names and addresses in bills of lading - one of the shipping trade's most iconic and definitively public documents - that they submit to U.S. Customs and Border Protection (CPB)."),
                styledText("But before explaining how to easily contact the CBP, and swiftly remove personal information in bills of lading from government databases, we thought some valuable context might be helpful regarding bills of lading and personal information."),
                styledText("1. The history of bills of lading, and their public purposes"),
                styledText("2. What legal obligations is Beon under here?"),
                styledText("3. What does Beon do and why?"),
                styledText("4. What can individuals do here?"),
                LabelText2("THE HISTORY OF BILLS OF LADING, AND THEIR PUBLIC PURPOSES"),
                styledText("As Professor McLaughlin explains, bills of lading, as we know and cherish them, have origins dating back to the 11th century. The rise of commercial hubs in the Mediterranean led to a need for precise documentation of delivered goods and their origins. Ports established meticulous registers to document shipment specifics, overseen by diligent clerks, stringent regulations, and harsh penalties. From the beginning, these registers served not only buyers and sellers, who could obtain excerpts for their records, but were also accessible to a limited public, upon request, “regardless of any objections from the master or owner.”"),
                styledText("Fast-forward to the 19th century in America, where Congress closely engaged in regulating maritime trade, including bills of lading. New uniform bills of lading were introduced, collected, and subsequently orderly sent to the National Archives, as they continue to do today."),
                styledText("Bills of lading can fulfill various roles for shippers and receivers, as well as for banks, insurers, and other intermediaries in the shipping process from Point A to Point B. Online searches often highlight the direct benefits to parties, such as receipt, entitlement, and contractual aspects of bills of lading."),
                styledText("Compelling public functions are interwoven with historical practices, legal frameworks, and the operational requirements of international trade. Banks, insurance companies, and other entitiescan verify shipment details independently, crucial for risk management and secure business transactions. Publicizing these documentsenhances market efficiency, allowing businesses, investors, and researchers to access granular information on shipments and destinations,facilitating informed decision-making and guidance. Transparency in these detailsdeters fraudulent activities such as misrepresentation of shipped goods, smuggling, and tax evasion."),
                LabelText2("WHAT LEGAL OBLIGATIONS DOES BEON HAVE HERE?"),
                styledText("The short answer: none."),
                styledText("Public Domain Under Federal Law. While we offer a distinctive Beon experience with the informational content we provide, including robust search and processing of bills of lading, the records themselves are acquired “as is” from U.S. Customs and Border Protection. As we've learned from the history of bills of lading, these records have always been publicly accessible for significant historical, compliance, and operational purposes. Under federal law, these records are public domain, and ultimately reside in the National Archives under the Record of the United States Customs Service. Many public records, such as court decisions, may include personal information, so this balance between the public interest and personal privacy comes up in other contexts."),
                styledText("Not Governed by Privacy Statement.While the information we provide may include occasional personal details of individuals, these do not qualify as “personal data” under our Privacy Statement. We have not actively sought or gathered this data; rather, it is presented to us in an unstructured, unreferenced manner - devoid of metadata or tags linking it to a specific individual and clarifying how certain details are personal and can be publicly cross-referenced. For example, if John Doe puts his personal address in a bill of lading, how can we confirm that this mention indeed pertains to a personal residence and not, as usual, to the business premises of a shipper or recipient?"),
                styledText("Not Protected Under Federal or State Consumer Privacy Laws.While there is no federal consumer privacy statute, federal agencies like the FTC can and have issued guidance relating to personal information. None, however, apply here. In California, often considered the national leader on many consumer protection efforts, the California Consumer Protection Act (CCPA) was amended by the California Privacy Rights Act, which specifically excludes governmental records like bills of sale from its coverage."),
                styledText("Legitimate Public Interests Argue Against:As we've learned, there are notable public benefits from maintaining bills of lading public and easily accessible. Altering, redacting, or erasing these records, particularly those long-standing and widely trusted like bills of lading, presents evident risks or valid concerns, such as vanishing into the Memory Hole."),
                LabelText2("WHAT DOES Beon DO AND WHY?"),
                styledText("We've chosen to take active and reactive measures to minimize the presence of PFPI in our informational content and services. We aggressively implement and continue to fine-tune algorithms to detect PFPI in our databases."),
                LabelText2("WHAT CAN AN INDIVIDUAL DO?"),
                styledText("The CBP has made the first step simple. Submit a confidentiality request on their online portal, Vessel Manifest Confidentiality Request.In this CBP Trade Information Notice, updated September 2023, they report that processing times are as little as 24 hours, and the new online application enables specification of name variations to ensure broad matching of bills of ladling. An email is provided for technical questions:"),
                styledText("vesselmanifestconfidentiality@cbp.dhs.gov. Second, please reach out to us via the contact us form on the website with a link to the page you believe has personal information."),
              ],
            ),
          ),
        );
      default:
        return Container(
          color: Colors.white,
          child: Center(
            child: Text(
              'Select a policy to view its details.',
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
    }
  }

  Widget styledText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 18,
        color: Color.fromARGB(255, 81, 109, 123),
      ),
    ).pOnly(bottom: 10);
  }

  Widget mainLabelText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: 32, color: Color.fromARGB(255, 17, 120, 172), fontWeight: FontWeight.w700),
    ).pOnly(bottom: 10);
  }

  Widget LabelText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: 26, color: Color.fromARGB(255, 17, 120, 172)),
    ).pOnly(bottom: 10);
  }

  Widget LabelText2(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 17, 120, 172)),
    ).pOnly(bottom: 10);
  }
}
