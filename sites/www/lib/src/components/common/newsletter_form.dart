// Copyright 2026, the Flutter authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/js_interop.dart';
import 'package:universal_web/web.dart' as web;

import '../../utils/countries.dart';
import 'icon.dart';

@client
class NewsletterForm extends StatefulComponent {
  const NewsletterForm({super.key});

  @override
  State<NewsletterForm> createState() => _NewsletterFormState();
}

class _NewsletterFormState extends State<NewsletterForm> {
  // State variables
  bool _submitted = false;
  bool _focused = false;
  Map<String, String> _errors = {};

  // Form fields
  String _email = '';
  String _firstName = '';
  String _lastName = '';
  String _country = '';
  bool _optin = false;

  // Constants from Alpine.js implementation
  static const String _formUrl =
      'https://services.google.com/fb/submissions/fluttersubscribe/';
  static const String _recaptchaSiteKey =
      '6LdG504kAAAAAPZGIhZd_--CkTASNKaW64oMriCL';

  static const Map<String, String> _errorMessages = {
    'email': 'Please enter a valid email address',
    'first_name': 'Please enter a valid first name',
    'last_name': 'Please enter a valid last name',
    'country': 'Please select your country',
    'optin': 'You must agree to subscribe',
    'captcha': 'You must solve the captcha',
  };

  static const Map<String, String> _payloadFieldsMap = {
    'email': 'EmailAddress',
    'first_name': 'FirstName',
    'last_name': 'LastName',
    'country': 'Country',
    'optin': 'FlutterDevUpdates',
  };

  void onFocus() {
    setState(() => _focused = true);

    context.binding.addPostFrameCallback(() {
      final elem = web.document.getElementById('g-recaptcha')!;
      grecaptcha.render(
        elem,
        ReCaptchaRenderOptions(sitekey: _recaptchaSiteKey),
      );
    });
  }

  bool _validateEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(email);
  }

  bool _validate() {
    final newErrors = <String, String>{};

    // Validate email
    if (!_validateEmail(_email)) {
      newErrors['email'] = _errorMessages['email']!;
    }

    // Validate first name
    if (_firstName.isEmpty) {
      newErrors['first_name'] = _errorMessages['first_name']!;
    }

    // Validate last name
    if (_lastName.isEmpty) {
      newErrors['last_name'] = _errorMessages['last_name']!;
    }

    // Validate country
    if (_country.isEmpty) {
      newErrors['country'] = _errorMessages['country']!;
    }

    // Validate optin
    if (!_optin) {
      newErrors['optin'] = _errorMessages['optin']!;
    }

    // Validate captcha
    // alpine-js: var response = grecaptcha.getResponse(); if (response.length == 0)

    final response = grecaptcha.getResponse();
    if (response.isEmpty) {
      newErrors['captcha'] = _errorMessages['captcha']!;
    }

    setState(() {
      _errors = newErrors;
    });

    return newErrors.isEmpty;
  }

  void _onSubmit(web.Event event) {
    event.preventDefault();

    setState(() {
      _errors = {};
    });

    if (_validate()) {
      unawaited(_sendData());
    }
  }

  Future<void> _sendData() async {
    try {
      // Create multipart request for form submission
      final request = http.MultipartRequest('POST', Uri.parse(_formUrl));

      request.fields['EmailAddress'] = _email;
      request.fields['FirstName'] = _firstName;
      request.fields['LastName'] = _lastName;
      request.fields['Country'] = _country;
      request.fields['FlutterDevUpdates'] = _optin.toString();
      request.fields['LanguagePreference'] = 'en-US';

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData case {'errors': final Map<String, Object?> serverErrors}) {
          _reverseSetErrors(serverErrors);
        } else {
          setState(() {
            _submitted = true;
          });
        }
      } else {
        setState(() {
          _errors['unknown'] = '__unknown__';
        });
      }
    } catch (e) {
      setState(() {
        _errors['unknown'] = '__unknown__';
      });
    }
  }

  void _reverseSetErrors(Map<String, Object?> serverErrors) {
    final newErrors = <String, String>{};
    final keys = _payloadFieldsMap.keys.toList();

    serverErrors.forEach((key, value) {
      if (key != 'LanguagePreference') {
        for (var i = 0; i < keys.length; i++) {
          if (_payloadFieldsMap[keys[i]] == key) {
            newErrors[keys[i]] = _errorMessages[keys[i]]!;
            break;
          }
        }
      }
    });

    setState(() {
      _errors = newErrors;
    });
  }

  @override
  Component build(BuildContext context) {
    return form(
      events: {'submit': _onSubmit},
      [
        fieldset([
          if (!_submitted)
            div([
              const h3([
                .text(
                  'Keep up with the latest Flutter news, releases, and more:',
                ),
              ]),
              div(classes: 'global-error', [
                if (_errors.containsKey('unknown'))
                  const span(classes: 'error', [
                    .text(
                      'There was an unknown error submitting your data. Please try again.',
                    ),
                  ]),
              ]),
              // Email field
              div(classes: 'field-wrapper', [
                div(
                  classes:
                      'field ${_errors.containsKey('email') ? 'error' : ''}',
                  [
                    const Icon(symbol: 'mail', size: .lg),
                    const label(htmlFor: 'email', classes: 'hidden', [
                      .text('Email'),
                    ]),
                    input(
                      type: InputType.email,
                      name: 'email',
                      id: 'email',
                      attributes: const {
                        'placeholder': 'Enter your email address',
                      },
                      onInput: (String value) {
                        setState(() => _email = value);
                      },
                      events: {
                        'focus': (_) {
                          onFocus();
                        },
                      },
                    ),
                  ],
                ),
                if (_errors.containsKey('email'))
                  span(classes: 'error', [.text(_errors['email']!)]),
              ]),
              if (_focused)
                div(classes: 'hidden-fields active', [
                  // Name fields grid
                  div(classes: 'field-grid', [
                    div(classes: 'field-wrapper', [
                      div(
                        classes:
                            'field ${_errors.containsKey('first_name') ? 'error' : ''}',
                        [
                          const label(htmlFor: 'firstname', classes: 'hidden', [
                            .text('First name'),
                          ]),
                          input(
                            type: InputType.text,
                            name: 'firstname',
                            id: 'firstname',
                            attributes: const {'placeholder': 'First name'},
                            onInput: (String value) {
                              setState(() => _firstName = value);
                            },
                          ),
                        ],
                      ),
                      if (_errors.containsKey('first_name'))
                        span(classes: 'error', [.text(_errors['first_name']!)]),
                    ]),
                    div(classes: 'field-wrapper', [
                      div(
                        classes:
                            'field ${_errors.containsKey('last_name') ? 'error' : ''}',
                        [
                          const label(htmlFor: 'lastname', classes: 'hidden', [
                            .text('Last name'),
                          ]),
                          input(
                            type: InputType.text,
                            name: 'lastname',
                            id: 'lastname',
                            attributes: const {'placeholder': 'Last name'},
                            onInput: (String value) {
                              setState(() => _lastName = value);
                            },
                          ),
                        ],
                      ),
                      if (_errors.containsKey('last_name'))
                        span(classes: 'error', [.text(_errors['last_name']!)]),
                    ]),
                  ]),
                  // Country field
                  div(classes: 'field-wrapper', [
                    div(
                      classes:
                          'field ${_errors.containsKey('country') ? 'error' : ''}',
                      [
                        const label(htmlFor: 'country', classes: 'hidden', [
                          .text('Country'),
                        ]),
                        select(
                          name: 'countries',
                          id: 'country',
                          onChange: (values) {
                            setState(() => _country = values.first);
                          },
                          [
                            const option(
                              value: '',
                              disabled: true,
                              selected: true,
                              [.text('Country')],
                            ),
                            for (final MapEntry(
                                  key: countryCode,
                                  value: countryName,
                                )
                                in countryNameByCode.entries)
                              option(value: countryCode, [.text(countryName)]),
                          ],
                        ),
                      ],
                    ),
                    if (_errors.containsKey('country'))
                      span(classes: 'error', [.text(_errors['country']!)]),
                  ]),
                  // Opt-in checkbox
                  div(classes: 'field-wrapper', [
                    div(classes: 'checkbox opt-in', [
                      div(
                        classes:
                            'field ${_errors.containsKey('optin') ? 'error' : ''}',
                        [
                          input(
                            type: InputType.checkbox,
                            name: 'optin',
                            id: 'optin',
                            onChange: (bool? value) {
                              setState(() => _optin = value ?? false);
                            },
                          ),
                        ],
                      ),
                      const label(htmlFor: 'optin', classes: 'optin', [
                        .text(
                          'By using this service, you agree to be bound by our ',
                        ),
                        a(href: 'https://policies.google.com/terms', [
                          .text('Google Terms of Service'),
                        ]),
                        .text(
                          '. I acknowledge that the information provided in this form will be subject to ',
                        ),
                        a(href: 'https://policies.google.com/privacy', [
                          .text("Google's Privacy Policy"),
                        ]),
                        .text('.'),
                      ]),
                    ]),
                    if (_errors.containsKey('optin'))
                      span(classes: 'error', [.text(_errors['optin']!)]),
                  ]),
                  // reCAPTCHA
                  div(classes: 'captcha-container field-wrapper', [
                    div(
                      id: 'g-recaptcha',
                      classes: _errors.containsKey('captcha') ? 'error' : '',
                      const [],
                    ),
                    if (_errors.containsKey('captcha'))
                      span(classes: 'error', [.text(_errors['captcha']!)]),
                  ]),
                  // Submit button
                  const div([
                    input(
                      type: InputType.submit,
                      classes: 'btn primary',
                      attributes: {'value': 'Subscribe'},
                    ),
                  ]),
                ]),
            ]),
          if (_submitted)
            const div(classes: 'success', [
              h3([.text("You're in!")]),
              p([
                .text(
                  'You have successfully signed up for the latest Flutter updates and announcements.',
                ),
              ]),
            ]),
        ]),
      ],
    );
  }
}

@JS()
external ReCaptcha get grecaptcha;

extension type ReCaptcha(JSObject _value) implements JSObject {
  external String getResponse();

  external JSAny? render(JSObject container, ReCaptchaRenderOptions options);
}

@anonymous
extension type ReCaptchaRenderOptions._(JSObject _value) implements JSObject {
  external factory ReCaptchaRenderOptions({String? sitekey});
}
