import 'package:tapea/model/field/company_website_field.dart';
import 'package:tapea/model/field/discord_field.dart';
import 'package:tapea/model/field/email_field.dart';
import 'package:tapea/model/field/facebook_field.dart';
import 'package:tapea/model/field/instagram_field.dart';
import 'package:tapea/model/field/link_field.dart';
import 'package:tapea/model/field/link_field_impl.dart';
import 'package:tapea/model/field/linked_in.dart';
import 'package:tapea/model/field/location_field.dart';
import 'package:tapea/model/field/paypal_field.dart';
import 'package:tapea/model/field/phone_number_field.dart';
import 'package:tapea/model/field/phone_number_field_impl.dart';
import 'package:tapea/model/field/profile_field.dart';
import 'package:tapea/model/field/telegram_field.dart';
import 'package:tapea/model/field/tiktok_field.dart';
import 'package:tapea/model/field/twitch_field.dart';
import 'package:tapea/model/field/twitter_field.dart';
import 'package:tapea/model/field/youtube_field.dart';

class ProfileModel {
  final String title;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String company;
  final String? photoUrl;
  final int color;
  final List<ProfileField> fields;
  final int index;

  const ProfileModel({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.company,
    this.photoUrl,
    required this.color,
    this.fields = const [],
    required this.index,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      title: json[FieldIdentifier.title],
      firstName: json[FieldIdentifier.firstName],
      lastName: json[FieldIdentifier.lastName],
      jobTitle: json[FieldIdentifier.jobTitle],
      company: json[FieldIdentifier.company],
      color: json[FieldIdentifier.color],
      photoUrl: json['photoUrl'],
      fields: fieldsFromJson(json['fields']),
      index: json[FieldIdentifier.index],
    );
  }

  ProfileModel copyWith({
    String? title,
    String? firstName,
    String? lastName,
    String? jobTitle,
    String? company,
    String? photoUrl,
    int? color,
    List<ProfileField>? fields,
    int? index,
  }) {
    return ProfileModel(
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      jobTitle: jobTitle ?? this.jobTitle,
      company: company ?? this.company,
      color: color ?? this.color,
      photoUrl: photoUrl ?? this.photoUrl,
      fields: fields ?? this.fields,
      index: index ?? this.index,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      FieldIdentifier.title: title,
      FieldIdentifier.firstName: firstName,
      FieldIdentifier.lastName: lastName,
      FieldIdentifier.jobTitle: jobTitle,
      FieldIdentifier.company: company,
      FieldIdentifier.color: color,
      'photoUrl': photoUrl,
      FieldIdentifier.fields: fieldsToJson(),
      FieldIdentifier.index: index,
    };
  }

  static List<ProfileField> fieldsFromJson(List<dynamic> fields) {
    // 'fields' variable is actually a List<Map<String, dynamic>>.
    if (fields.isEmpty) return [];
    final List<ProfileField> allFields = [];
    for (Map<String, dynamic> field in fields) {
      if (field.isEmpty) continue;
      final String title = field['title'];
      final subtitle = field.containsKey('subtitle') ? field['subtitle'] : '';
      final String type = field['type'];
      switch (type) {
        case FieldIdentifier.phoneNumber:
          allFields.add(
            PhoneNumberFieldImpl(
              title: title,
              subtitle: subtitle,
              ext: field['phoneExtension'],
            ),
          );
          break;
        case FieldIdentifier.email:
          allFields.add(
            EmailField(
              title: title,
              subtitle: subtitle,
            ),
          );
          break;
        case FieldIdentifier.link:
          allFields.add(
            LinkFieldImpl(
              title: title,
              subtitle: subtitle,
              link: field['link'],
            ),
          );
          break;
        case FieldIdentifier.location:
          allFields.add(
            LocationField(
              title: title,
              subtitle: subtitle,
            ),
          );
          break;
        case FieldIdentifier.companyWebsite:
          allFields.add(
            CompanyWebsiteField(
              title: title,
              subtitle: subtitle,
              link: field['link'],
            ),
          );
          break;
        case FieldIdentifier.linkedIn:
          allFields.add(
            LinkedInField(
              title: title,
              subtitle: subtitle,
              link: field['link'],
            ),
          );
          break;
        case FieldIdentifier.paypal:
          allFields.add(
            PaypalField(
              title: title,
              subtitle: subtitle,
              link: field['link'],
            ),
          );
          break;
        case FieldIdentifier.instagram:
          allFields.add(
            InstagramField(
              title: title,
              subtitle: subtitle,
              link: field['link'],
            ),
          );
          break;
        case FieldIdentifier.twitter:
          allFields.add(
            TwitterField(
              title: title,
              subtitle: subtitle,
              link: field['link'],
            ),
          );
          break;
        case FieldIdentifier.facebook:
          allFields.add(
            FacebookField(
              title: title,
              subtitle: subtitle,
              link: field['link'],
            ),
          );
          break;
        case FieldIdentifier.youtube:
          allFields.add(
            YoutubeField(
              title: title,
              subtitle: subtitle,
              link: field['link'],
            ),
          );
          break;
        case FieldIdentifier.discord:
          allFields.add(
            DiscordField(
              title: title,
              subtitle: subtitle,
              link: field['link'],
            ),
          );
          break;
        case FieldIdentifier.telegram:
          allFields.add(
            TelegramField(
              title: title,
              subtitle: subtitle,
              link: field['link'],
            ),
          );
          break;
        case FieldIdentifier.tiktok:
          allFields.add(TikTokField(
            title: title,
            subtitle: subtitle,
            link: field['link'],
          ));
          break;
        case FieldIdentifier.twitch:
          allFields.add(
            TwitchField(
              title: title,
              subtitle: subtitle,
              link: field['link'],
            ),
          );
          break;
        default:
          throw ('Field with id $type was not handled');
      }
    }
    return allFields;
  }

  List<Map<String, dynamic>> fieldsToJson() {
    final List<Map<String, dynamic>> allJsons = [];
    for (ProfileField field in fields) {
      final Map<String, dynamic> currentField = {
        'type': field.type.id,
        'title': field.title,
        'subtitle': field.subtitle,
      };
      if (field is PhoneNumberField) {
        currentField['phoneExtension'] = field.ext;
      }
      if (field is LinkField) {
        currentField['link'] = field.link;
      }
      allJsons.add(currentField);
    }
    return allJsons;
  }

  @override
  String toString() {
    return 'ProfileModel(title: $title, firstName: $firstName, lastName: $lastName, jobTitle: $jobTitle, company: $company, photoUrl: $photoUrl, fields: $fields)';
  }
}
